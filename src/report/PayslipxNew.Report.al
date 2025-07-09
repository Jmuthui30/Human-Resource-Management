report 52994 "Payslipx New"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/NewPayslipxNew.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No_; "No.")
            {

            }
            column(Name; Name) { }
            column(FullName; FullName) { }
            column(ID_No_; "ID No.") { }
            column(Position; Position) { }
            column(Mobile_Phone_No_; "Mobile Phone No.") { }
            column(E_Mail; "E-Mail") { }
            column(GrossPay; GrossPay) { }
            column(SIF17; SIF17) { }
            column(SIF8; SIF8) { }
            column(TaxableIncome; TaxableIncome) { }
            column(Tax20; Tax20) { }
            column(SalaryAdvance; SalaryAdvance) { }
            column(SACCO; SACCO) { }
            column(Other; Other) { }
            column(TotalDeductions; TotalDeductions) { }
            column(NetPay; NetPay) { }
            column(Gratuity; Gratuity) { }
            column(MedicalInsurance; MedicalInsurance) { }
            column(TotalStaffCost; TotalStaffCost) { }
            column(BankTransfer; BankTransfer) { }
            column(CashTransfer; CashTransfer) { }
            column(Employee_s_Bank; "Employee's Bank") { }
            column(Bank_Account_No_; "Bank Account No.") { }
            column(Bank_Branch; "Bank Branch") { }
            column(Employee_Bank_Name; "Employee Bank Name") { }
            column(Bank_Account_Number; "Bank Account Number") { }
            column(Employee_Branch_Name; "Employee Branch Name") { }
            column(CoName; CoName)
            {
            }
            column(CoRec_Picture; CompInfo.Picture)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompEmail; CompInfo."E-Mail")
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            trigger OnAfterGetRecord()
            begin

                DeductsRec.Reset();
                DeductsRec.SETRANGE(DeductsRec.NSSF, true);
                if DeductsRec.Findset() then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                    AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                        SIF17 := AssignMatrix."Employer Amount";
                        SIF8 := AssignMatrix.Amount;
                    END;
                end;
                DeductsRec.Reset();
                DeductsRec.SETRANGE(DeductsRec."PAYE Code", true);
                if DeductsRec.Findset() then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                    AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                        TaxableIncome := AssignMatrix."Taxable amount";
                        Tax20 := AssignMatrix."Taxable amount" * 0.2;
                    END;
                end;
                DeductsRec.Reset();
                DeductsRec.SETRANGE(DeductsRec.Advance, true);
                if DeductsRec.Findset() then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                        IF AssignMatrix.FIND('-') THEN BEGIN
                            SalaryAdvance := (AssignMatrix.Amount) * -1
                        END;
                    until DeductsRec.Next() = 0;
                end;

                // DeductsRec.Reset();
                // DeductsRec.SETRANGE(DeductsRec.Advance, true);
                // if DeductsRec.Findset() then begin
                //     repeat
                //         Message('dedu is %1', DeductsRec.Code);
                //         AssignMatrix.RESET;
                //         AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                //         AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                //         AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                //         AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                //         IF AssignMatrix.FIND('-') THEN BEGIN
                //             Other := (AssignMatrix.Amount) * -1
                //         END;
                //     until DeductsRec.Next() = 0;
                //     Message('other is %1', Other);
                // end;



                DeductsRec.Reset();
                DeductsRec.SETRANGE(DeductsRec."Insurance Code", true);
                if DeductsRec.Findset() then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                    AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                        MedicalInsurance := (AssignMatrix."Employer Amount")
                    END;
                end;
                //**************************************************************************************************
                Earn.Reset();
                Earn.SetRange(Earn."Basic Salary Code", true);
                if Earn.Find('-') then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Earning);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                    AssignMatrix.SetRange(Code, Earn.Code);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                        GrossPay := AssignMatrix.Amount;
                    END;
                end;



                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SetRange(Code, 'GRATUITY');
                IF AssignMatrix.FIND('-') THEN BEGIN
                    Gratuity := AssignMatrix."Employer Amount";
                END;
                //   end;
                TotalStaffCost := 0;
                TotalDeductions := Tax20 + SalaryAdvance + Other;
                NetPay := TaxableIncome - TotalDeductions;
                BankTransfer := NetPay;
                TotalStaffCost := GrossPay + SIF17 + Gratuity + MedicalInsurance;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(LayoutName)
                // {

                // }
            }
        }
    }

    trigger OnPreReport()
    begin

        PayPeriodtext := Employee.GetFilter("Pay Period Filter");
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText := Format(PayrollMonth, 1, 4);

        if PayPeriodtext = '' then
            Error('Pay period must be specified for this report');
        CoRec.Get();
        CoName := CoRec.Name;
        Evaluate(DateSpecified, Format(PayPeriodtext));

        CompInfo.Get();
        CompInfo.CalcFields(Picture);

        HRSetup.Get();

    end;

    var
        CoName: Text[250];
        AssignMatrix: Record "Assignment Matrix";
        CompInfo: Record "Company Information";
        CoRec: Record "Company Information";
        Deduct: Record Deductions;
        DeductsRec: Record Deductions;
        Earn: Record Earnings;
        HRSetup: Record "Human Resources Setup";
        LoanBalances: Record "Payroll Loan Application";
        DateSpecified: Date;
        PayrollMonth: Date;
        NetPay: Decimal;
        PAYE: Decimal;
        TaxableAmt: Decimal;
        Totalcoopshares: Decimal;
        TotalDeduction: Decimal;
        Totalnssf: Decimal;
        ArrHeadings: array[100] of Integer;

        PayPeriodtext: Text[30];
        PayrollMonthText: Text[30];
        GrossPay: Decimal;
        SIF17: Decimal;
        SIF8: Decimal;
        TaxableIncome: Decimal;
        Tax20: Decimal;
        SalaryAdvance: Decimal;
        SACCO: Decimal;
        Other: Decimal;
        TotalDeductions: Decimal;

        MedicalInsurance: Decimal;
        Gratuity: Decimal;
        TotalStaffCost: Decimal;
        BankTransfer: Decimal;
        CashTransfer: Decimal;


    procedure ChckRound(var AmtText: Text[30]) ChckRound: Text[30]
    var
        DecimalPos: Integer;
        Decimalstrlen: Integer;
        LenthOfText: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
    begin
        LenthOfText := StrLen(AmtText);
        DecimalPos := StrPos(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec := AmtText;
            DecimalAmt := '.00';
        end else begin
            AmtWithoutDec := CopyStr(AmtText, 1, DecimalPos - 1);
            DecimalAmt := CopyStr(AmtText, DecimalPos + 1, 2);
            Decimalstrlen := StrLen(DecimalAmt);
            if Decimalstrlen < 2 then
                DecimalAmt := '.' + DecimalAmt + '0'
            else
                DecimalAmt := '.' + DecimalAmt
        end;
        ChckRound := AmtWithoutDec + DecimalAmt;
    end;


    procedure CoinageAnalysis(var NetPay: Decimal; var ColNo: Integer)
    begin
    end;


    procedure GetPayPeriod()
    begin
    end;



    procedure GetTaxBracket(var TaxableAmount: Decimal)
    begin
    end;


    procedure GetTaxBracket1(var TaxableAmount: Decimal)
    begin
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

    local procedure GetTaxRelief(): Decimal
    var
        EarningRec: Record Earnings;
    begin
        EarningRec.Reset();
        EarningRec.SetRange("Earning Type", EarningRec."Earning Type"::"Tax Relief");
        EarningRec.SetFilter("Flat Amount", '<>%1', 0);
        if EarningRec.FindFirst() then
            exit(EarningRec."Flat Amount")
        else
            exit(0);
    end;
}