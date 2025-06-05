report 52075 "Close Pay Period - Trustees"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Close Pay Period - Trustees';
    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix")
        {
            DataItemTableView = where("Employee Type" = filter(Trustee));
            RequestFilterFields = "Employee No";

            trigger OnPostDataItem()
            begin
                //
                if PayperiodStart <> StartingDate then
                    Error(Error000)
                else
                    if PayPeriod.Get(StartingDate) then begin
                        PayPeriod."Close Pay" := true;
                        PayPeriod.Closed := true;
                        PayPeriod.Modify();
                        Message(Text000);
                    end;
                //
                // //Go Through Assignment Matrix for Loans and Validate Code
                // NewPeriod:=CALCDATE('1M',PayperiodStart);
                // Loan.RESET;
                // IF Loan.FIND('-') THEN
                //  BEGIN
                //    REPEAT
                //      AssMatrix.RESET;
                //      AssMatrix.SETRANGE("Payroll Period",NewPeriod);
                //      AssMatrix.SETRANGE(Code,Loan."Employee No");
                //      IF AssMatrix.FIND('-') THEN
                //        BEGIN
                //          REPEAT
                //            IF EmpRec.GET("Assignment Matrix-X"."Employee No") THEN
                //              BEGIN
                //                IF (EmpRec.Status=EmpRec.Status::Dormant) THEN
                //                    AssMatrix.VALIDATE(Code);
                //                    AssMatrix.MODIFY;
                //              END;
                //          UNTIL AssMatrix.NEXT=0;
                //        END;
                //    UNTIL Loan.NEXT=0;
                //  END;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin

        if not Confirm('Please backup up before closing current period! OK to Proceed?') then
            Error('The period has not been closed');

        PayrollRun.Run();
        Commit();

        DeducePayPeriod();
        ClosePeriodTrans();
        CreateNewEntries(PayperiodStart);
        //UpdateSalaryPointers(PayperiodStart);
    end;

    var
        EmpRec: Record Employee;
        Emprec2: Record Employee;
        LoanApplicationForm: Record "Payroll Loan Application";
        PayPeriod: Record "Payroll Period Trustees";
        PayrollRun: Report "Payroll Run Trustees";
        CreateRec: Boolean;
        TaxCode: Code[10];
        CurrentPeriodEnd: Date;
        NewPayTrust: Date;
        NewPeriod: Date;
        PayperiodStart: Date;
        StartingDate: Date;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        InterestDiff: Decimal;
        LoanInterest: Decimal;
        Window: Dialog;
        Error000: Label 'Cannot Close this Pay period Without Closing the preceding ones';
        Text000: Label 'The period has been closed';
        EmployeeName: Text[200];

    procedure CalculateRepaymentAmount(var EmpNo: Code[20]; var LoanNo: Code[20]; var LoanInterest: Decimal; LastPayment: Date) Repayment: Decimal
    var
        LoanApplication: Record "Payroll Loan Application";
        Balance: Decimal;
    begin
        Repayment := 0;
        LoanInterest := 0;
        //Get the loan being repaid
        LoanApplication.Reset();
        LoanApplication.SetRange(LoanApplication."Loan No", LoanNo);
        LoanApplication.SetRange(LoanApplication."Employee No", EmpNo);
        LoanApplication.SetRange("Date filter", 0D, LastPayment);
        if LoanApplication.FindFirst() then
            if LoanApplication."Interest Calculation Method" <> LoanApplication."Interest Calculation Method"::"Sacco Reducing Balance" then begin
                LoanApplication.CalcFields("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - (LoanApplication."Total Repayment") - Abs(LoanApplication.Receipts);
                Repayment := LoanApplication.Repayment;
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance / 12);
                LoanInterest := PayrollRounding(LoanInterest);
                if Balance <= 0 then
                    Repayment := 0;
                exit(Repayment);
            end
            else begin
                /*
                RepaymentSchedule.Reset();
                RepaymentSchedule.SetRange(RepaymentSchedule."Loan No",LoanNo);
                RepaymentSchedule.SetRange(RepaymentSchedule."Employee No",EmpNo);
                RepaymentSchedule.SetRange("Repayment Date",CalcDate('1M',PayperiodStart));
                 if RepaymentSchedule.FindFirst() then begin
                    Repayment:=-RepaymentSchedule."Monthly Repayment";
                    Repayment:=PayrollRounding(Repayment);
                    exit(Repayment);
                 end;
                 */
                //Get Principal Repayment and subtract the interest on the balance
                LoanApplication.CalcFields("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - Abs(LoanApplication."Total Repayment") - Abs(LoanApplication.Receipts);

                //MESSAGE('bal%1',Balance);
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance / 12);
                LoanInterest := PayrollRounding(LoanInterest);
                if Balance < Repayment then
                    Repayment := Balance
                else
                    Repayment := LoanApplication.Repayment;

                if Balance <= 0 then
                    Repayment := 0;
                exit(Repayment);
            end;

    end;

    procedure ClosePeriodTrans()
    var
        EarnDeduct: Record "Assignment Matrix";
    begin
        EarnDeduct.Reset();
        EarnDeduct.SetRange("Employee Type", EarnDeduct."Employee Type"::Trustee);
        EarnDeduct.SetRange(EarnDeduct."Payroll Period", PayperiodStart);
        if EarnDeduct.Find('-') then
            repeat
                EarnDeduct.Closed := true;
                EarnDeduct."Payroll Period" := PayperiodStart;
                EarnDeduct.Modify();
            until EarnDeduct.Next() = 0;
    end;

    procedure CoinageAnalysis(var NetPay: Decimal) NetPay1: Decimal
    begin
    end;

    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal)
    var
        PaymentDeduction: Record "Assignment Matrix";
        allowances: Record Earnings;
    begin
        PaymentDeduction.Init();
        PaymentDeduction."Employee No" := Employee;
        PaymentDeduction.Code := BenefitCode;
        PaymentDeduction.Type := PaymentDeduction.Type::Earning;
        PaymentDeduction."Payroll Period" := CalcDate('1M', PayperiodStart);
        PaymentDeduction.Amount := ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit" := true;
        PaymentDeduction.Taxable := true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.Get(BenefitCode) then
            PaymentDeduction.Description := allowances.Description;
        PaymentDeduction.Insert();
    end;

    procedure CreateNewEntries(var CurrPeriodStat: Date)
    var
        AssignMatrix: Record "Assignment Matrix";
        PaymentDed: Record "Assignment Matrix";
        EmpEarnRec: Record "Employee Earnings History";
    begin
        /*This function creates new entries for the Next() Payroll period which are accessible and editable
       by the User of the Payroll. It should ideally create new entries if the EmpRec is Active*/
        NewPeriod := CalcDate('1M', PayperiodStart);
        Window.Open('Creating Next period entries ##############################1', EmployeeName);
        PaymentDed.Reset();
        PaymentDed.SetRange(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SetRange(PaymentDed."Next Period Entry", true);
        PaymentDed.SetFilter("Effective End Date", '%1|>=%2', 0D, NewPeriod);
        PaymentDed.SetRange("Employee Type", PaymentDed."Employee Type"::Trustee);
        //PaymentDed.SETFILTER(PaymentDed.Amount, '<>%1',0);
        if PaymentDed.Find('-') then
            repeat
                CreateRec := true;
                AssignMatrix.Init();
                AssignMatrix."Employee Type" := AssignMatrix."Employee Type"::Trustee;
                AssignMatrix."Employee No" := PaymentDed."Employee No";
                AssignMatrix.Type := PaymentDed.Type;
                AssignMatrix.Code := PaymentDed.Code;
                AssignMatrix."Department Code" := PaymentDed."Department Code";
                AssignMatrix."Reference No" := PaymentDed."Reference No";
                AssignMatrix.Retirement := PaymentDed.Retirement;
                AssignMatrix."Effective Start Date" := PaymentDed."Effective Start Date";
                AssignMatrix.Tenure := PaymentDed.Tenure;
                AssignMatrix."Effective End Date" := PaymentDed."Effective End Date";
                AssignMatrix."Payroll Period" := NewPayTrust;//CALCDATE('1M',PayperiodStart);
                AssignMatrix.Validate("Payroll Period");
                if PaymentDed."Loan Repay" then begin
                    AssignMatrix.Amount := -CalculateRepaymentAmount(PaymentDed."Employee No", PaymentDed."Reference No", LoanInterest,
                                                                   PayperiodStart);
                    AssignMatrix."Loan Interest" := -LoanInterest;
                end
                else
                    AssignMatrix.Amount := PaymentDed.Amount;
                if PaymentDed.Prorated then
                    AssignMatrix.Amount := EmpEarnRec.FetchFullAmt(PaymentDed);
                AssignMatrix."Loan Interest" := PaymentDed."Loan Interest";
                AssignMatrix.Description := PaymentDed.Description;
                AssignMatrix.Taxable := PaymentDed.Taxable;
                AssignMatrix."Tax Deductible" := PaymentDed."Tax Deductible";
                AssignMatrix.Frequency := PaymentDed.Frequency;
                AssignMatrix."Pay Period" := PaymentDed."Pay Period";
                AssignMatrix.Validate("Payroll Period");
                AssignMatrix."Non-Cash Benefit" := PaymentDed."Non-Cash Benefit";
                AssignMatrix.Quarters := PaymentDed.Quarters;
                AssignMatrix."No. of Units" := PaymentDed."No. of Units";
                AssignMatrix.Section := PaymentDed.Section;
                AssignMatrix."Basic Pay" := PaymentDed."Basic Pay";
                AssignMatrix."Salary Grade" := PaymentDed."Salary Grade";
                AssignMatrix."Department Code" := PaymentDed."Department Code";
                AssignMatrix."Employer Amount" := PaymentDed."Employer Amount";
                AssignMatrix."Department Code" := PaymentDed."Department Code";
                AssignMatrix."Next Period Entry" := PaymentDed."Next Period Entry";
                AssignMatrix."Posting Group Filter" := PaymentDed."Posting Group Filter";
                AssignMatrix."Loan Repay" := PaymentDed."Loan Repay";
                AssignMatrix.DebitAcct := PaymentDed.DebitAcct;
                AssignMatrix.CreditAcct := PaymentDed.CreditAcct;
                AssignMatrix."Basic Salary Code" := PaymentDed."Basic Salary Code";
                AssignMatrix."Normal Earnings" := PaymentDed."Normal Earnings";
                AssignMatrix."Insurance No" := PaymentDed."Insurance No";
                AssignMatrix."Tax Relief" := PaymentDed."Tax Relief";
                AssignMatrix.Area := PaymentDed.Area;
                AssignMatrix."Ext Insurance Amount" := PaymentDed."Ext Insurance Amount";
                AssignMatrix."House Allowance Code" := PaymentDed."House Allowance Code";
                AssignMatrix."Commuter Allowance Code" := PaymentDed."Commuter Allowance Code";
                AssignMatrix."Salary Arrears Code" := PaymentDed."Salary Arrears Code";
                AssignMatrix."Sacco Deduction" := PaymentDed."Sacco Deduction";
                if PaymentDed."Department Code" = '' then begin
                    Emprec2.Reset();
                    if Emprec2.Get(PaymentDed."Employee No") then
                        AssignMatrix."Department Code" := Emprec2."Global Dimension 1 Code";
                end;
                //END EMM
                if EmpRec.Get(PaymentDed."Employee No") then begin
                    AssignMatrix."Payroll Group" := EmpRec."Posting Group";
                    Window.Update(1, EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name");
                    //MESSAGE('%1',EmpRec."Employee Job Type");
                    if (EmpRec.Status = EmpRec.Status::Active) and (CreateRec = true) and (AssignMatrix.Amount <> 0)
                        and (EmpRec."Employee Job Type" = EmpRec."Employee Job Type"::"  ") then
                        AssignMatrix.Insert();
                end;
            until PaymentDed.Next() = 0;
        //Manage loans
        PaymentDed.Reset();
        PaymentDed.SetRange(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SetRange(Type, PaymentDed.Type::Deduction);
        PaymentDed.SetRange("Employee Type", PaymentDed."Employee Type"::Trustee);
        if PaymentDed.Find('-') then
            repeat
                if LoanApplicationForm.Get(PaymentDed."Reference No") then //here
                begin
                    LoanApplicationForm.SetRange(LoanApplicationForm."Date filter", 0D, PayperiodStart);
                    LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment", Receipts);
                    if (LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment" - Abs(LoanApplicationForm.Receipts)) = 0 then begin
                        Message('Loan %1 has expired', PaymentDed."Reference No");
                        PaymentDed.Delete();
                    end
                    else
                        if (LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment" - Abs(LoanApplicationForm.Receipts))
                           < LoanApplicationForm.Repayment then begin
                            LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment", LoanApplicationForm.Receipts);
                            PaymentDed.Amount := -(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment"
                                                 - Abs(LoanApplicationForm.Receipts));
                            PaymentDed."Next Period Entry" := false;
                            PaymentDed.Modify();
                        end;
                end;
            until PaymentDed.Next() = 0;

    end;

    procedure DeducePayPeriod()
    var
        PayPeriodRec: Record "Payroll Period Trustees";
    begin
        PayPeriodRec.Reset();
        PayPeriodRec.SetRange(PayPeriodRec."Close Pay", false);
        if PayPeriodRec.FindFirst() then
            PayperiodStart := PayPeriodRec."Starting Date";
    end;

    procedure GetCurrentPeriod(var Payperiod: Record "Payroll Period Trustees")
    var
        PayTrust: Record "Payroll Period Trustees";
    begin
        CurrentPeriodEnd := Payperiod."Starting Date";
        StartingDate := CurrentPeriodEnd;
        PayTrust.Reset();
        PayTrust.SetRange("Close Pay", false);
        PayTrust.SetFilter("Starting Date", '<>%1', StartingDate);
        if PayTrust.FindFirst() then
            NewPayTrust := PayTrust."Starting Date"
        else
            Error('Please create a new pay period first');
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Brackets";
        EndTax: Boolean;
        Tax: Decimal;
        TotalTax: Decimal;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := Round(AmountRemaining, 0.01);
        EndTax := false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if Round((TaxableAmount), 0.01) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next() = 0) or EndTax = true;
        TotalTax := TotalTax;
        IncomeTax := -TotalTax;
    end;

    procedure Initialize()
    var
        InitEarnDeduct: Record "Assignment Matrix";
    begin
        InitEarnDeduct.SetRange(InitEarnDeduct.Closed, false);
        repeat
            InitEarnDeduct."Payroll Period" := PayperiodStart;
            InitEarnDeduct.Modify();
        until InitEarnDeduct.Next() = 0;
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin
        HRsetup.Get();
        if HRsetup."Payroll Rounding Precision" = 0 then
            Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure UpdateSalaryPointers(var PayrollPeriod: Date)
    var
        Emp: Record Employee;
    begin
        Emp.Reset();
        Emp.SetRange(Emp.Status, Emp.Status::Inactive);
        if Emp.Find('-') then
            repeat
                if Format(Date2DMY(NewPeriod, 2)) = Emp."Incremental Month" then
                    if IncStr(Emp."Present Pointer") < Emp.Halt then begin
                        //MESSAGE('%1 %2',INCSTR(Emp.Present),Emp.Halt);
                        Emp.Previous := Emp."Present Pointer";
                        Emp."Present Pointer" := IncStr(Emp."Present Pointer");
                        Emp.Modify();
                    end;
            until Emp.Next() = 0;
    end;
}





