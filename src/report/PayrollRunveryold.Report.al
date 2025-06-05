report 52027 "Payroll Run-veryold"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Payroll Run-veryold';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Nature of Employment", "Pay Period Filter";

            trigger OnAfterGetRecord()
            var
                EmploymentDate: Date;
                LeaveEndDate: Date;
                LeaveStartDate: Date;
            begin

                Percentage := (Round(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                //SLEEP(200);
                Window.Update(1, Percentage);
                Window.Update(2, (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"));




                //Auto Assign Defaults if None are Assigned
                if Employee."Employee Type" <> Employee."Employee Type"::Casual then begin
                    if Employee.Status = Employee.Status::Active then begin
                        EmployeeRec.Copy(Employee);
                        EmployeeRec.SetRange(Status, Employee.Status::Active);
                        EmployeeRec.SetRange("Pay Period Filter", Month);
                        EmployeeRec.CalcFields("Total Allowances", "Total Deductions", "Insurance Premium", "Loan Interest");
                    end;

                    //Delete Entries of Employees not Active
                    if Employee.Status <> Employee.Status::Active then begin
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        AssignMatrix.DeleteAll();
                    end;

                    //Non Casual Employees...................................................................................................................................

                    //Prorate Earnings

                    if Employee."Date Of Join" <> 0D then
                        if ((Date2DMY(Employee."Date Of Join", 2)) = (Date2DMY(Month, 2))) and
                           ((Date2DMY(Employee."Date Of Join", 3)) = (Date2DMY(Month, 3))) then begin
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                            AssignMatrix.SetRange("Non-Cash Benefit", false);
                            if AssignMatrix.Find('-') then
                                repeat
                                    if Earnings.Get(AssignMatrix.Code) then;
                                    if Earnings.Prorate then begin
                                        if not AssignMatrix.Prorated then
                                            EmployeeEarnRec.UpdateEntries(AssignMatrix);
                                        AssignMatrix.Amount := ((CalcDate('1M', Month)) - Employee."Date Of Join") / ((CalcDate('1M', Month)) - Month) *
                                                             EmployeeEarnRec.FetchFullAmt(AssignMatrix);
                                        /*//MESSAGE(FORMAT(Month));
                                        Message(Format(((CalcDate('1M',Month))-Employee."Date Of Join")));
                                        //MESSAGE(FORMAT(CALCDATE('1M',Month)));
                                        //MESSAGE(FORMAT(Employee."Date Of Join"));
                                        Message(Format((CalcDate('1M',Month))-Month));
                                        Message(Format(EmployeeEarnRec.FetchFullAmt(AssignMatrix)));*/
                                        AssignMatrix.Prorated := true;
                                        AssignMatrix.Modify();
                                    end;
                                until AssignMatrix.Next() = 0;
                        end;

                    //Assign New Pointer
                    CurrentMonth := Date2DMY(Month, 2);
                    Evaluate(CurrentMonthtext, Format(CurrentMonth));
                    if CurrentMonthtext = Employee."Incremental Month" then
                        if Employee.Halt <> Employee."Present Pointer" then begin
                            NextPointer := IncStr(Employee."Present Pointer");
                            if NextPointer <> Employee.Halt then begin
                                if ScalePointer.Get(NextPointer) then;
                                if Employee.Halt <> NextPointer then begin
                                    if not PointerExist(Employee, Month, Employee."Present Pointer", Employee.Previous) then begin
                                        Employee.Previous := Employee."Present Pointer";
                                        Employee."Present Pointer" := ScalePointer."Salary Pointer";
                                        Employee.Modify();
                                    end;
                                    UpdateEarnings(Employee);
                                    UpdatePointers(Employee, Month, Employee."Present Pointer", Employee.Previous);
                                end;
                            end;
                        end;

                    //Pay Partime Workers;
                    if PayrollMgt.CheckIfPartime(Employee."No.") <> 0 then begin
                        ScaleBenefits.Reset();
                        ScaleBenefits.SetRange("Salary Scale", Employee."Salary Scale");
                        ScaleBenefits.SetRange("Salary Pointer", Employee."Present Pointer");
                        if ScaleBenefits.FindFirst() then
                            repeat
                                PayrollMgt.PayPertimers(Employee."No.", ScaleBenefits."ED Code");
                            until ScaleBenefits.Next() = 0;
                    end;

                    //Calculate items that requires employee request Like Overtime.
                    Earnings.Reset();
                    Earnings.SetRange("Requires Employee Request", true);
                    if Earnings.Find('-') then
                        repeat
                            PayrollMgt.PayPertimers(Employee."No.", Earnings.Code);
                        until Earnings.Next() = 0;
                    Deductions.Reset();
                    Deductions.SetRange("PAYE Code", true);
                    if Deductions.Find('-') then begin
                        //Delete Previous PAYE
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(Code, Deductions.Code);
                        if Deductions.Find('-') then begin
                            //Delete All Previous PAYE
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange(Code, Deductions.Code);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.DeleteAll();
                        end;





                        // Validate assigment matrix code incase basic salary change and update calculation based on basic salary
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        if AssignMatrix.Find('-') then
                            repeat
                                if AssignMatrix.Type = AssignMatrix.Type::Earning then
                                    if Earnings.Get(AssignMatrix.Code) then begin
                                        if (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic pay") or
                                           (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic after tax") or
                                           (Earnings."Calculation Method" = Earnings."Calculation Method"::"Based on Hourly Rate") then begin
                                            AssignMatrix.Validate(Code);
                                            //AssignMatrix.VALIDATE("Employee Voluntary");
                                            AssignMatrix.Amount := Round(AssignMatrix.Amount, 1);
                                            AssignMatrix.Modify();
                                        end;
                                        //Set amount to 0 if an employee not paying tax was set for a tax relief
                                        if Earnings."Earning Type" = Earnings."Earning Type"::"Tax Relief" then
                                            if Employee."Pays tax?" = false then begin
                                                if AssignMatrix.Amount > 0 then
                                                    AssignMatrix.Amount := 0;
                                                AssignMatrix.Modify();
                                            end;
                                    end;

                                if AssignMatrix.Retirement = false then
                                    if AssignMatrix.Type = AssignMatrix.Type::Deduction then
                                        if Deductions.Get(AssignMatrix.Code) then
                                            if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or
                                               (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or
                                               (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                                AssignMatrix.Validate(Code);
                                                AssignMatrix.Validate("Employee Voluntary");
                                                AssignMatrix.Amount := Round(AssignMatrix.Amount, 1);
                                                AssignMatrix.Modify();
                                            end;
                                if AssignMatrix.Type = AssignMatrix.Type::Deduction then
                                    if Deductions.Get(AssignMatrix.Code) then
                                        if (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table") and
                                           (Deductions."PAYE Code" = false) then begin
                                            AssignMatrix.Validate(Code);
                                            AssignMatrix.Amount := Round(AssignMatrix.Amount, 1);
                                            AssignMatrix.Modify();
                                        end;

                            until AssignMatrix.Next() = 0;

                        //Pay Leave Allowance.

                        if PayLeave then begin
                            LeaveEndDate := LastMonth;
                            LeaveStartDate := CalcDate('-6M', LeaveEndDate);
                            EmploymentDate := DMY2Date(Date2DMY(Employee."Employment Date", 1), Date2DMY(Employee."Employment Date", 2), Date2DMY(LeaveEndDate, 3));
                            if (EmploymentDate >= LeaveStartDate) and (EmploymentDate <= LeaveEndDate) then begin
                                Earnings.Reset();
                                Earnings.SetRange("Leave Allowance", true);
                                if Earnings.Find('-') then begin
                                    AssignMatrix.Init();
                                    AssignMatrix."Employee No" := Employee."No.";
                                    AssignMatrix.Type := AssignMatrix.Type::Earning;
                                    AssignMatrix.Code := Earnings.Code;
                                    AssignMatrix."Reference No" := '';
                                    AssignMatrix.Validate(Code);
                                    AssignMatrix."Payroll Period" := Month;
                                    AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                                    AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                    AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                    AssignMatrix.Validate(Amount);
                                    if (AssignMatrix.Amount <> 0) and
                                       (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then
                                        AssignMatrix.Insert();
                                end;
                            end;
                        end;
                        //Validate Loans
                        LoanInterest := 0;
                        LoanApplication.Reset();
                        LoanApplication.SetRange("Employee No", Employee."No.");
                        LoanApplication.SetRange("Loan Status", LoanApplication."Loan Status"::Issued);
                        LoanApplication.SetRange("Stop Loan", false);
                        if LoanApplication.Find('-') then
                            repeat
                                AssignMatrix.Reset();
                                AssignMatrix.SetRange("Employee No", Employee."No.");
                                AssignMatrix.SetRange("Payroll Period", Month);
                                AssignMatrix.SetRange("Reference No", LoanApplication."Loan No");
                                AssignMatrix.SetRange("Loan Repay", true);
                                if AssignMatrix.Find('-') then
                                    repeat

                                        AssignMatrix.Amount := -(ClosePayPeriod.CalculateRepaymentAmount(Employee."No.", LoanApplication."Loan No", LoanInterest,
                                                                                                 CalcDate('-1M', Month)) - LoanInterest);

                                        AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                                        AssignMatrix."Loan Interest" := -LoanInterest;
                                        AssignMatrix."Loan Interest" := PayrollRounding(AssignMatrix."Loan Interest");
                                        AssignMatrix.Modify();

                                        //Delete Loan
                                        if AssignMatrix.Amount = 0 then
                                            AssignMatrix.Delete();

                                    until AssignMatrix.Next() = 0;
                            until LoanApplication.Next() = 0;

                        //End of Loans


                        //Assign Insurance Relief
                        if EmployeeRec."Insurance Relief" = true then begin
                            if EmployeeRec."Insurance Premium" <> 0 then begin
                                Earnings.Reset();
                                Earnings.SetCurrentKey("Earning Type");
                                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                                if Earnings.Find('-') then begin
                                    AssignMatrix.Init();
                                    AssignMatrix."Employee No" := Employee."No.";
                                    AssignMatrix.Type := AssignMatrix.Type::Earning;
                                    AssignMatrix.Code := Earnings.Code;
                                    AssignMatrix."Reference No" := '';
                                    AssignMatrix.Validate(Code);
                                    AssignMatrix."Payroll Period" := Month;
                                    AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                                    AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                    AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                    AssignMatrix.Validate(Amount);
                                    if (AssignMatrix.Amount <> 0) and
                                      (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then
                                        AssignMatrix.Insert()
                                    else begin
                                        Earnings.Reset();
                                        Earnings.SetCurrentKey("Earning Type");
                                        Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                                        if Earnings.Find('-') then begin
                                            AssignMatrix.Reset();
                                            AssignMatrix.SetRange("Payroll Period", DateSpecified);
                                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                                            AssignMatrix.SetRange(Code, Earnings.Code);
                                            AssignMatrix.SetRange("Employee No", Employee."No.");
                                            if AssignMatrix.Find('-') then begin
                                                AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                                AssignMatrix.Validate(Amount);
                                                AssignMatrix.Modify();
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end else begin
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange("Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                            AssignMatrix.SetRange(Code, Earnings.Code);
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            if AssignMatrix.Find('-') then begin
                                AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                AssignMatrix.Validate(Amount);
                                AssignMatrix.Modify();
                            end;
                        end;


                        Deductions.Reset();
                        Deductions.SetRange("PAYE Code", true);
                        if Deductions.Find('-') then begin
                            GetPaye.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetireCont);

                            //Create PAYE

                            //Update Tax Relief
                            if (IncomeTax > 0) and (Employee."Employee Job Type" <> Employee."Employee Job Type"::Director) then begin
                                Earnings.Reset();
                                Earnings.SetCurrentKey("Earning Type");
                                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Tax Relief");
                                if Earnings.Find('-') then
                                    repeat
                                        AssignMatrix.Reset();
                                        AssignMatrix.SetRange("Payroll Period", Month);
                                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                                        AssignMatrix.SetRange(Code, Earnings.Code);
                                        AssignMatrix.SetRange("Employee No", Employee."No.");
                                        if not AssignMatrix.Find('-') then begin
                                            AssignMatrix.Init();
                                            AssignMatrix."Employee No" := Employee."No.";
                                            AssignMatrix.Type := AssignMatrix.Type::Earning;
                                            AssignMatrix.Code := Earnings.Code;
                                            AssignMatrix."Reference No" := '';
                                            AssignMatrix.Validate(Code);
                                            AssignMatrix."Payroll Period" := Month;
                                            AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                            if AssignMatrix.Amount <> 0 then
                                                AssignMatrix.Insert();
                                        end else begin
                                            AssignMatrix.Reset();
                                            AssignMatrix.SetRange("Payroll Period", Month);
                                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                                            AssignMatrix.SetRange(Code, Earnings.Code);
                                            AssignMatrix.SetRange("Employee No", Employee."No.");
                                            if AssignMatrix.Find('-') then begin
                                                AssignMatrix.Validate(Code);
                                                AssignMatrix.Modify();
                                            end;
                                        end;
                                    until Earnings.Next() = 0
                                else begin
                                    Earnings.Reset();
                                    Earnings.SetCurrentKey("Earning Type");
                                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Tax Relief");
                                    if Earnings.Find('-') then;

                                end;

                                //Recompute Tax after Adding Tax Relief
                                GetPaye.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetireCont);
                            end;
                            //Create PAYE
                            AssignMatrix.Init();
                            AssignMatrix."Employee No" := Employee."No.";
                            AssignMatrix.Validate("Employee No");
                            AssignMatrix.Type := AssignMatrix.Type::Deduction;
                            AssignMatrix.Code := Deductions.Code;
                            AssignMatrix.Validate(Code);
                            AssignMatrix."Reference No" := '';
                            AssignMatrix."Payroll Period" := Month;
                            AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                            if IncomeTax > 0 then
                                IncomeTax := -IncomeTax;
                            AssignMatrix.Amount := IncomeTax;
                            AssignMatrix.Paye := true;
                            AssignMatrix."Taxable amount" := TaxableAmount;
                            AssignMatrix."Less Pension Contribution" := RetireCont;
                            AssignMatrix.Paye := true;
                            AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                            AssignMatrix.Validate(Amount);
                            if AssignMatrix.Amount <> 0 then
                                AssignMatrix.Insert();
                        end else
                            Error(Text001);

                        //Update Bank Account History
                        EmployeeAccHistory.UpdateAccountDetails(Employee, Month);


                        //Update Pay Mode, Company, Department, Posting Group
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        if AssignMatrix.Find('-') then
                            repeat
                                AssignMatrix."Pay Mode" := Employee."Pay Mode";
                                AssignMatrix."Payroll Group" := Employee.Company;
                                AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                                AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                AssignMatrix."Salary Grade" := Employee."Salary Scale";
                                AssignMatrix.Modify();
                            until AssignMatrix.Next() = 0;

                        //Casual Workers

                    end;



                end;

                if Employee."Employee Type" = Employee."Employee Type"::Casual then begin

                    AssignMatrix.Reset();
                    AssignMatrix.SetRange("Employee No", Employee."No.");
                    AssignMatrix.SetRange("Payroll Period", Month);
                    AssignMatrix.SetRange("Next Period Entry", false);
                    AssignMatrix.SetFilter("Effective End Date", '<%1', Month);
                    AssignMatrix.DeleteAll();

                    Earnings.Reset();
                    Earnings.SetRange("Casual Code", true);
                    if Earnings.FindFirst() then
                        repeat

                            PayrollMgt.PayPertimers(Employee."No.", Earnings.Code);
                        until Earnings.Next() = 0;
                end;
                Window.Update(1, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");

            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;

            trigger OnPreDataItem()
            begin
                Window.Open(Text000 + Text002);
                TotalCount := Count;

                PayPeriod.SetRange(Closed, false);
                if PayPeriod.Find('-') then begin
                    Month := PayPeriod."Starting Date";
                    LastMonth := CalcDate('-1M', Month);
                    if PayPeriod."Leave Payment Period" then
                        PayLeave := true;
                end;
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

    var
        AssignMatrix: Record "Assignment Matrix";
        Deductions: Record Deductions;
        Earnings: Record Earnings;
        EmployeeRec: Record Employee;
        EmployeeAccHistory: Record "Employee Account History";
        EmployeeEarnRec: Record "Employee Earnings History";
        LoanApplication: Record "Payroll Loan Application";
        PayPeriod: Record "Payroll Period";
        ScalePointer: Record "Salary Pointer";
        ScaleBenefits: Record "Scale Benefits";
        ClosePayPeriod: Report "Close Pay Period";
        GetPaye: Codeunit Payroll;
        PayrollMgt: Codeunit Payroll;
        PayLeave: Boolean;
        NextPointer: Code[10];
        TaxCode: Code[10];
        BeginDate: Date;
        DateSpecified: Date;
        LastMonth: Date;
        Month: Date;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        LoanInterest: Decimal;
        RetireCont: Decimal;
        TaxableAmount: Decimal;
        Window: Dialog;
        Counter: Integer;
        CurrentMonth: Integer;
        Percentage: Integer;
        TotalCount: Integer;
        Text000: Label 'Calculating Payroll @1@@@@@@@@@@@@@@@';
        Text001: Label 'You Must specify Paye Code under deductions';
        Text002: Label 'For Employee:#2###############';
        CurrentMonthtext: Text[30];

    procedure DefaultAssignment(EmployeeRec: Record Employee)
    var
        ScaleBenefits: Record "Scale Benefits";
    begin
        GetPayPeriod();
        if BeginDate <> 0D then begin
            AssignMatrix.Init();
            AssignMatrix."Employee No" := EmployeeRec."No.";
            AssignMatrix.Type := AssignMatrix.Type::Earning;
            AssignMatrix."Payroll Period" := BeginDate;
            AssignMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
            ScaleBenefits.Reset();
            ScaleBenefits.SetRange("Salary Scale", EmployeeRec."Salary Scale");
            ScaleBenefits.SetRange("Salary Pointer", EmployeeRec."Present Pointer");
            if ScaleBenefits.Find('-') then
                repeat
                    AssignMatrix.Code := ScaleBenefits."ED Code";
                    AssignMatrix.Validate(Code);
                    AssignMatrix.Amount := ScaleBenefits.Amount;
                    AssignMatrix.Validate(Amount);
                    if not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No") then
                        AssignMatrix.Insert()
                    else begin
                        AssignMatrix.Code := ScaleBenefits."ED Code";
                        AssignMatrix.Validate(Code);
                        AssignMatrix.Amount := ScaleBenefits.Amount;
                        AssignMatrix.Validate(Amount);
                        AssignMatrix.Modify();
                    end;
                until ScaleBenefits.Next() = 0;
            // Insert Deductions assigned to every employee
            Deductions.Reset();
            Deductions.SetRange("Applies to All", true);
            if Deductions.Find('-') then
                repeat
                    AssignMatrix.Init();
                    AssignMatrix."Employee No" := EmployeeRec."No.";
                    AssignMatrix.Type := AssignMatrix.Type::Deduction;
                    AssignMatrix."Payroll Period" := BeginDate;
                    AssignMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
                    AssignMatrix.Code := Deductions.Code;
                    AssignMatrix.Validate(Code);
                    if not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No") then
                        AssignMatrix.Insert()
                    else begin
                        AssignMatrix.Code := Deductions.Code;
                        AssignMatrix.Validate(Code);
                    end;
                until Deductions.Next() = 0;
        end;
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then
            //PayPeriodtext:=PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Brackets";
        EndTax: Boolean;
        Tax: Decimal;
        TotalTax: Decimal;
    begin
        AmountRemaining := TaxableAmount;
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
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax?" then
            IncomeTax := 0;
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

    procedure PointerExist(EmployeeRec: Record Employee; PayPeriod: Date; PresentPointer: Code[20]; PreviousPointer: Code[20]): Boolean
    var
        SalaryPointers: Record "Salary Pointer Details";
    begin
        if SalaryPointers.Get(EmployeeRec."No.", PayPeriod, PresentPointer, PreviousPointer) then
            exit(true)
        else
            exit(false);
    end;

    procedure UpdateEarnings(EmployeeRec: Record Employee)
    begin
        Earnings.Reset();
        if Earnings.Find('-') then
            repeat
                if ScaleBenefits.Get(EmployeeRec."Salary Scale", EmployeeRec."Present Pointer", Earnings.Code) then begin
                    AssignMatrix.Reset();
                    AssignMatrix.SetRange(AssignMatrix.Code, Earnings.Code);
                    AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Earning);
                    AssignMatrix.SetRange(AssignMatrix."Employee No", EmployeeRec."No.");
                    AssignMatrix.SetRange(AssignMatrix."Payroll Period", Month);
                    if AssignMatrix.Find('-') then begin
                        AssignMatrix.Amount := ScaleBenefits.Amount;
                        if AssignMatrix."Manual Entry" = false then
                            AssignMatrix.Modify();
                    end
                    else begin
                        AssignMatrix.Init();
                        AssignMatrix."Employee No" := EmployeeRec."No.";
                        AssignMatrix.Type := AssignMatrix.Type::Earning;
                        AssignMatrix.Code := Earnings.Code;
                        AssignMatrix.Validate(AssignMatrix.Code);
                        AssignMatrix."Payroll Period" := Month;
                        AssignMatrix.Amount := ScaleBenefits.Amount;
                        AssignMatrix."Manual Entry" := false;
                        AssignMatrix.Insert();
                    end;
                end;
            until Earnings.Next() = 0;
    end;

    procedure UpdatePointers(EmployeeRec: Record Employee; PayPeriod: Date; PresentPointer: Code[20]; PreviousPointer: Code[20])
    var
        SalaryPointers: Record "Salary Pointer Details";
    begin
        if not SalaryPointers.Get(EmployeeRec."No.", PayPeriod, PresentPointer, PreviousPointer) then begin
            SalaryPointers.Init();
            SalaryPointers."Employee No" := EmployeeRec."No.";
            SalaryPointers."Payroll Period" := PayPeriod;
            SalaryPointers.Present := PresentPointer;
            SalaryPointers.Previous := PreviousPointer;
            SalaryPointers.Insert();
        end;
    end;
}





