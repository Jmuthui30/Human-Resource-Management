report 52026 "Payroll Run"
{
    ApplicationArea = All;
    Caption = 'Payroll Run';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where("Employee Type" = filter(<> "Board Member"), Status = const(Active));
            RequestFilterFields = "No.", "Nature of Employment", "Pay Period Filter";

            trigger OnAfterGetRecord()
            var
                EmploymentDate: Date;
                LeaveEndDate: Date;
                LeaveStartDate: Date;
            begin

                Employee.TestField("Posting Group");

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
                        EmployeeRec.CalcFields("Total Allowances", "Total Deductions", "Insurance Premium", "Loan Interest", "NHIF Amount", "Housing Levy Amount");
                    end;

                    //Delete Entries of Employees not Active
                    if Employee.Status <> Employee.Status::Active then begin
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        AssignMatrix.DeleteAll();
                    end;

                    //Non Casual Employees...................................................................................................................................

                    //Assign New Pointer on anniversery date
                    if HumanResourcesSetup."Effect Anniversary Increment" then begin
                        Employee.TestField("Next Increment Date");

                        NextScale := '';
                        NextPointer := '';
                        CurrentMonth := 0;
                        CurrentYear := 0;

                        CurrentMonth := Date2DMY(Month, 2);
                        CurrentYear := Date2DMY(Month, 3);

                        Evaluate(CurrentMonthtext, Format(CurrentMonth));
                        if Date2DMY(Employee."Next Increment Date", 3) = CurrentYear then
                            if CurrentMonthtext = Employee."Incremental Month" then begin
                                PayrollMgt.GetNextSalaryScale(Employee, NextScale, NextPointer);

                                if NextPointer <> '' then begin

                                    if Employee."Salary Scale" <> NextScale then
                                        Employee.Validate("Salary Scale", NextScale)
                                    else
                                        Employee."Previous Salary Scale" := Employee."Salary Scale";

                                    if Employee."Present Pointer" <> NextPointer then begin
                                        Employee.Previous := Employee."Present Pointer";
                                        Employee."Present Pointer" := NextPointer;
                                    end;

                                    Employee.Modify();

                                    if ScalePointer.Get(NextScale, NextPointer) then begin
                                        UpdateEarnings(Employee);
                                        UpdatePointers(Employee, Month, Employee."Present Pointer", Employee.Previous);
                                        Employee."Last Increment Date" := Today();
                                        Employee."Next Increment Date" := DMY2Date(1, Date2DMY(Employee."Date Of Join", 2), (Date2DMY(Today(), 3) + 1));
                                        Employee.Modify();
                                    end;
                                end;
                            end;
                    end;
                    //End of Assign New Pointer on anniversery date


                    //Prorate Earnings

                    if Employee."Date Of Join" <> 0D then
                        if ((Date2DMY(Employee."Date Of Join", 2)) = (Date2DMY(Month, 2))) and
                           ((Date2DMY(Employee."Date Of Join", 3)) = (Date2DMY(Month, 3))) then begin
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                            AssignMatrix.SetRange("Non-Cash Benefit", false);
                            if AssignMatrix.Findset() then
                                repeat
                                    if Earnings.Get(AssignMatrix.Code) then;
                                    if Earnings.Prorate then begin
                                        if not AssignMatrix.Prorated then
                                            EmployeeEarnRec.UpdateEntries(AssignMatrix);

                                        //Exact days
                                        AssignMatrix.Amount := ((CalcDate('1M', Month)) - Employee."Date Of Join") / ((CalcDate('1M', Month)) - Month) *
                                                             EmployeeEarnRec.FetchFullAmt(AssignMatrix);

                                        AssignMatrix.Amount := AssignMatrix.PayrollRounding(AssignMatrix.Amount);
                                        AssignMatrix.Prorated := true;
                                        AssignMatrix.Modify();
                                    end;
                                until AssignMatrix.Next() = 0;
                        end;

                    //Prorate Earnings for Employees leaving within the month
                    if Employee."Date Of Leaving" <> 0D then
                        if ((Date2DMY(Employee."Date Of Leaving", 2)) = (Date2DMY(Month, 2))) and
                           ((Date2DMY(Employee."Date Of Leaving", 3)) = (Date2DMY(Month, 3))) then begin
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                            AssignMatrix.SetRange("Non-Cash Benefit", false);
                            if AssignMatrix.Findset() then
                                repeat
                                    if Earnings.Get(AssignMatrix.Code) then;
                                    if Earnings.Prorate then begin
                                        if not AssignMatrix.Prorated then
                                            EmployeeEarnRec.UpdateEntries(AssignMatrix);

                                        //Exact days
                                        AssignMatrix.Amount := (Date2DMY(Employee."Date Of Leaving", 1)) / (CalcDate('1M', Month) - Month) *
                                                             EmployeeEarnRec.FetchFullAmt(AssignMatrix);

                                        AssignMatrix.Amount := AssignMatrix.PayrollRounding(AssignMatrix.Amount);
                                        AssignMatrix.Prorated := true;
                                        AssignMatrix.Modify();
                                    end;
                                until AssignMatrix.Next() = 0;
                        end;

                    //Pay Partime Workers;
                    /*if PayrollMgt.CheckIfPartime(Employee."No.") <> 0 then begin
                        ScaleBenefits.Reset();
                        ScaleBenefits.SetRange("Salary Scale", Employee."Salary Scale");
                        ScaleBenefits.SetRange("Salary Pointer", Employee."Present Pointer");
                        if ScaleBenefits.FindFirst() then begin
                            repeat
                                PayrollMgt.PayPertimers(Employee."No.", ScaleBenefits."ED Code");
                            until ScaleBenefits.Next() = 0;
                        end;
                    end;*/

                    //Calculate items that requires employee request Like Overtime.
                    /*Earnings.Reset();
                    Earnings.SetRange("Requires Employee Request", true);
                    if Earnings.Find('-') then begin
                        repeat
                            PayrollMgt.PayPertimers(Employee."No.", Earnings.Code);
                        until Earnings.Next() = 0;
                    end;*/


                    Deductions.Reset();
                    Deductions.SetRange("PAYE Code", true);
                    if Deductions.FindFirst() then begin
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
                    if AssignMatrix.FindSet() then
                        repeat
                            if AssignMatrix.Type = AssignMatrix.Type::Earning then
                                if Earnings.Get(AssignMatrix.Code) then begin
                                    if (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic pay") or
                                       (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic after tax") or
                                       (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Gross pay") or
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

                            //if AssignMatrix.Retirement = false then begin
                            if AssignMatrix.Type = AssignMatrix.Type::Deduction then
                                if Deductions.Get(AssignMatrix.Code) then
                                    if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or
                                       (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or
                                       (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay") or
                                       (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                        AssignMatrix.Validate(Code);
                                        AssignMatrix.Validate("Employee Voluntary");
                                        AssignMatrix.Amount := Round(AssignMatrix.Amount, 1);
                                        AssignMatrix.Modify();
                                    end;

                            //end;
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
                                AssignMatrix.Amount := Abs(Earnings."Flat Amount");
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

                                    if LoanApplication."Interest Calculation Method" <> LoanApplication."Interest Calculation Method"::Amortised then
                                        AssignMatrix.Amount := -(ClosePayPeriod.CalculateRepaymentAmount(Employee."No.", LoanApplication."Loan No", LoanInterest,
                                                                                               CalcDate('-1M', Month)))
                                    else
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

                        //Calculate insurance relief from opening balances
                        Ded.Reset();
                        Ded.SetRange("Insurance Code", true);
                        if Ded.FindSet() then begin
                            InsuranceAmt := 0;

                            DeductionBalances.Reset();
                            DeductionBalances.SetRange("Employee No", Employee."No.");
                            DeductionBalances.SetRange("Deduction Code", Ded.Code);
                            if DeductionBalances.FindSet() then
                                repeat
                                    InsuranceAmt += DeductionBalances.Amount;
                                until DeductionBalances.Next() = 0;

                            Earnings.Reset();
                            Earnings.SetCurrentKey("Earning Type");
                            Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                            if Earnings.FindFirst() then begin
                                AssignMatrix.Init();
                                AssignMatrix."Employee No" := Employee."No.";
                                AssignMatrix.Type := AssignMatrix.Type::Earning;
                                AssignMatrix.Code := Earnings.Code;
                                AssignMatrix."Reference No" := '';
                                AssignMatrix.Validate(Code);
                                AssignMatrix."Payroll Period" := Month;
                                AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                                AssignMatrix.Amount := Abs(InsuranceAmt * (Earnings.Percentage / 100));
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
                                            AssignMatrix.Amount := Abs(InsuranceAmt * (Earnings.Percentage / 100));
                                            AssignMatrix.Validate(Amount);
                                            AssignMatrix.Modify();
                                        end;
                                    end;
                                end;
                            end; //else
                                 //   Message('Please define at least one Insurance Relief Earning');
                        end;
                    end;

                    //Assign NHIF Relief
                    if EmployeeRec."NHIF Amount" <> 0 then begin
                        Earnings.Reset();
                        Earnings.SetCurrentKey("Earning Type");
                        Earnings.SetRange("Earning Type", Earnings."Earning Type"::"NHIF Relief");
                        if Earnings.FindFirst() then begin
                            AssignMatrix.Init();
                            AssignMatrix."Employee No" := Employee."No.";
                            AssignMatrix.Type := AssignMatrix.Type::Earning;
                            AssignMatrix.Code := Earnings.Code;
                            AssignMatrix."Reference No" := '';
                            AssignMatrix.Validate(Code);
                            AssignMatrix."Payroll Period" := Month;
                            AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                            AssignMatrix.Amount := Abs(EmployeeRec."NHIF Amount" * (Earnings.Percentage / 100));
                            AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                            AssignMatrix.Validate(Amount);
                            if (AssignMatrix.Amount <> 0) and
                              (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then
                                AssignMatrix.Insert()
                            else begin
                                Earnings.Reset();
                                Earnings.SetCurrentKey("Earning Type");
                                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"NHIF Relief");
                                if Earnings.FindFirst() then begin
                                    AssignMatrix.Reset();
                                    AssignMatrix.SetRange("Employee No", Employee."No.");
                                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                                    AssignMatrix.SetRange(Code, Earnings.Code);
                                    AssignMatrix.SetRange("Payroll Period", DateSpecified);
                                    AssignMatrix.SetRange("Reference No", '');
                                    if AssignMatrix.FindLast() then begin
                                        AssignMatrix.Amount := Abs(EmployeeRec."NHIF Amount" * (Earnings.Percentage / 100));
                                        AssignMatrix.Validate(Amount);
                                        AssignMatrix.Modify();
                                    end;
                                end;
                            end;
                        end;
                    end;

                    //Assign NHIF Relief
                    if EmployeeRec."Housing Levy Amount" <> 0 then begin
                        Earnings.Reset();
                        Earnings.SetCurrentKey("Earning Type");
                        Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Housing Levy Relief");
                        if Earnings.FindFirst() then begin
                            AssignMatrix.Init();
                            AssignMatrix."Employee No" := Employee."No.";
                            AssignMatrix.Type := AssignMatrix.Type::Earning;
                            AssignMatrix.Code := Earnings.Code;
                            AssignMatrix."Reference No" := '';
                            AssignMatrix.Validate(Code);
                            AssignMatrix."Payroll Period" := Month;
                            AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                            AssignMatrix.Amount := Abs(EmployeeRec."Housing Levy Amount" * (Earnings.Percentage / 100));
                            AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                            AssignMatrix.Validate(Amount);
                            if (AssignMatrix.Amount <> 0) and
                              (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then
                                AssignMatrix.Insert()
                            else begin
                                Earnings.Reset();
                                Earnings.SetCurrentKey("Earning Type");
                                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Housing Levy Relief");
                                if Earnings.FindFirst() then begin
                                    AssignMatrix.Reset();
                                    AssignMatrix.SetRange("Employee No", Employee."No.");
                                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                                    AssignMatrix.SetRange(Code, Earnings.Code);
                                    AssignMatrix.SetRange("Payroll Period", DateSpecified);
                                    AssignMatrix.SetRange("Reference No", '');
                                    if AssignMatrix.FindLast() then begin
                                        AssignMatrix.Amount := Abs(EmployeeRec."Housing Levy Amount" * (Earnings.Percentage / 100));
                                        AssignMatrix.Validate(Amount);
                                        AssignMatrix.Modify();
                                    end;
                                end;
                            end;
                        end;
                    end;

                    Deductions.Reset();
                    Deductions.SetRange("PAYE Code", true);
                    if Deductions.Find('-') then begin
                        //  Message('here');
                        GetPaye.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetireCont);

                        //Update Tax Relief
                        if (IncomeTax > 0) and (Employee."Employee Job Type" <> Employee."Employee Job Type"::Director)
                        and (not Employee."Secondary Employee") then begin
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
                        //   Message('here2');
                        //Create PAYE
                        if IncomeTax <> 0 then begin
                            //     Message('here3');
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
                        end;
                    end else
                        Error(Text001);

                    //Check One Third Rule
                    NetPay := 0;
                    TotalEarnings := 0;
                    TotalDeductions := 0;
                    ExemptDeductions := 0;
                    Ratio := 0;

                    if not PayrollMgt.CheckOneThirdRule(Employee."No.", Month, NetPay, TotalEarnings, TotalDeductions, ExemptDeductions, Ratio) then
                        Message('One Third Rule has been surpassed for Employee %1: %2 \Total Earnings: %3\Total Deductions: %4\Total Exempt Deductions: %5\Ratio: %6 \Please check their deductions.',
                                Employee."No.", Employee.FullName(), TotalEarnings, TotalDeductions, ExemptDeductions, Ratio);

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
                end;

                //Casual Workers
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

                Window.Update(1, Employee.FullName());
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;

            trigger OnPreDataItem()
            begin
                PayrollDateFilter := Employee.GetFilter("Pay Period Filter");
                Evaluate(PayrollDate, PayrollDateFilter);
                if PayPeriodCopy.Get(PayrollDate) then
                    if PayPeriodCopy.Closed then
                        Error(CanNotRunOnClosePeriodErr);

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

    trigger OnPreReport()
    begin
        HumanResourcesSetup.Get();
    end;

    var
        AssignMatrix: Record "Assignment Matrix";
        DeductionBalances: Record "Deduction Balances";
        Ded, Deductions : Record Deductions;
        Earnings: Record Earnings;
        EmployeeRec: Record Employee;
        EmployeeAccHistory: Record "Employee Account History";
        EmployeeEarnRec: Record "Employee Earnings History";
        HumanResourcesSetup: Record "Human Resources Setup";
        LoanApplication: Record "Payroll Loan Application";
        PayPeriod: Record "Payroll Period";
        PayPeriodCopy: Record "Payroll Period";
        ScalePointer: Record "Salary Pointer";
        ScaleBenefits: Record "Scale Benefits";
        ClosePayPeriod: Report "Close Pay Period";
        GetPaye: Codeunit Payroll;
        PayrollMgt: Codeunit Payroll;
        PayLeave: Boolean;
        TaxCode: Code[10];
        NextPointer, NextScale : Code[20];
        BeginDate: Date;
        DateSpecified: Date;
        LastMonth: Date;
        Month: Date;
        PayrollDate: Date;
        AmountRemaining: Decimal;
        ExemptDeductions, NetPay, Ratio, TotalDeductions, TotalEarnings : Decimal;
        IncomeTax: Decimal;
        InsuranceAmt: Decimal;
        LoanInterest: Decimal;
        RetireCont: Decimal;
        TaxableAmount: Decimal;
        Window: Dialog;
        Counter: Integer;
        CurrentMonth, CurrentYear : Integer;
        Percentage: Integer;
        TotalCount: Integer;
        CanNotRunOnClosePeriodErr: Label 'You can not run payroll for a closed Payroll Period';
        Text000: Label 'Calculating Payroll @1@@@@@@@@@@@@@@@';
        Text001: Label 'You Must specify Paye Code under deductions';
        Text002: Label 'For Employee:#2###############';
        PayrollDateFilter: Text;
        CurrentMonthtext: Text[30];

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
        if SalaryPointers.Get(EmployeeRec."No.") then
            exit(true)
        else
            exit(false);
    end;

    procedure UpdateEarnings(EmployeeRec: Record Employee)
    begin
        Earnings.Reset();
        if Earnings.FindSet() then
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
        if not SalaryPointers.Get(EmployeeRec."No.") then begin
            SalaryPointers.Init();
            SalaryPointers."Employee No" := EmployeeRec."No.";
            SalaryPointers."Payroll Period" := PayPeriod;
            SalaryPointers.Present := PresentPointer;
            SalaryPointers.Previous := PreviousPointer;
            SalaryPointers.Insert();
        end;
    end;
}





