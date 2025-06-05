codeunit 52002 "Payroll"
{
    trigger OnRun()
    begin
    end;

    procedure CalculateMonths(StartDate: Date; EndDate: Date) "count": Integer
    var
        NextDate: Date;
        PreviousDate: Date;
    begin
        PreviousDate := StartDate;
        Count := -1;
        while PreviousDate <= EndDate do begin
            NextDate := CalcDate('<1M>', PreviousDate);
            Count += 1;
            PreviousDate := NextDate;
        end;
    end;

    procedure CalculateTaxableAmount(EmployeeNo: Code[20]; DateSpecified: Date; var FinalTax: Decimal; var TaxableAmountNew: Decimal; var RetirementCont: Decimal)
    var
        Assignmatrix: Record "Assignment Matrix";
        Ded: Record Deductions;
        Earnings: Record Earnings;
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        PPSetup: Record "Purchases & Payables Setup";
        InsuranceRelief: Decimal;
        MortgageRelief: Decimal;
        NHIFRelief: Decimal;
        OwnerOccupier: Decimal;
        PersonalRelief: Decimal;
        TaxableAmount: Decimal;
        ExcessRetirement: Decimal;
        PensionAdd: Decimal;
        AddBack: Decimal;
        HousingLevyRelief: Decimal;
    begin
        FinalTax := 0;
        TaxableAmount := 0;
        RetirementCont := 0;
        InsuranceRelief := 0;
        PersonalRelief := 0;
        OwnerOccupier := 0;
        NHIFRelief := 0;
        HousingLevyRelief := 0;
        MortgageRelief := 0;
        ExcessRetirement := 0;
        PensionAdd := 0;
        //Get payroll period
        GetCurrentPayPeriodDate();
        if DateSpecified = 0D then
            Error('Pay period must be specified for this report');

        HRSetup.Get();

        // Taxable Amount
        Employee.Reset();
        Employee.SetRange("No.", EmployeeNo);
        Employee.SetRange("Pay Period Filter", DateSpecified);
        if Employee.FindFirst() then
            if Employee."Pays tax?" = true then begin
                Employee.CalcFields("Taxable Allowance", "Tax Deductible Amount", "Relief Amount", "Total Allowances");
                // Message(' Employee."Taxable Allowance" %1', Employee."Total Allowances");
                TaxableAmount := Employee."Total Allowances";
                Ded.Reset();
                Ded.SetRange(Ded.NSSF, true);
                if Ded.Find('-') then
                    repeat

                        Assignmatrix.Reset();
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Deduction);
                        Assignmatrix.SetRange(Assignmatrix.Code, Ded.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.Find('-') then
                            RetirementCont := Abs(RetirementCont) + Abs(Assignmatrix.Amount);

                    until Ded.Next() = 0;
                // Message('taxabl122 is %1..#RetirementCont is %2', TaxableAmount, RetirementCont);
                TaxableAmount := TaxableAmount - RetirementCont;
                // Message('taxabl122 is %1..#RetirementCont is %2', TaxableAmount, RetirementCont);

                //  Message('taxabl122 is %1', TaxableAmount);


                // HRSetup.Get();

                // PensionAdd := TaxableAmount * (HRSetup."Secondary PAYE %" / 100);
                // Message('   PensionAdd is %1', PensionAdd);

                // TaxableAmount := TaxableAmount - PensionAdd;
                // Message('taxabl is %1', TaxableAmount);

                // PensionAdd := 0;
                // if RetirementCont < HRSetup."Pension Limit Amount" then begin
                //     PensionAdd := ExcessRetirement + RetirementCont;
                //     if PensionAdd > HRSetup."Pension Limit Amount" then begin
                //         //PensionAdd:=PensionAdd-HRSetup."Pension Limit Amount";
                //         AddBack := PensionAdd - HRSetup."Pension Limit Amount";
                //         TaxableAmount := TaxableAmount + AddBack - HRSetup."Pension Limit Amount";
                //     end;
                //     if PensionAdd <= HRSetup."Pension Limit Amount" then begin
                //         TaxableAmount := TaxableAmount - PensionAdd;
                //     end;
                // end;

                // if Employee.Disabled = Employee.Disabled::Yes then
                //     TaxableAmount := TaxableAmount - HRSetup."Disabililty Tax Exp. Amt";
                // end Taxable Amount

                //Owner occupier occupied interest
                // Ded.Reset();
                // Ded.SetRange(Ded."Tax deductible", true);
                // Ded.SetRange(Ded."Owner Occupied Interest", true);
                // if Ded.Find('-') then
                //     repeat
                //         Assignmatrix.Reset();
                //         Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                //         Assignmatrix.SetRange(Type, Assignmatrix.Type::Deduction);
                //         Assignmatrix.SetRange(Assignmatrix.Code, Ded.Code);
                //         Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                //         if Assignmatrix.FindSet() then
                //             repeat
                //                 OwnerOccupier := OwnerOccupier + Abs(Assignmatrix.Amount);
                //             until Assignmatrix.Next() = 0;
                //     until
                //     Ded.Next() = 0;
                // if OwnerOccupier > 0 then begin
                //     if HRSetup.Get() then
                //         if HRSetup."Owner Occupied Interest Limit" < OwnerOccupier then
                //             OwnerOccupier := HRSetup."Owner Occupied Interest Limit";
                //     TaxableAmount := TaxableAmount - OwnerOccupier;
                // end;
                //End of owner occupied interest
                //Add Owner Occuppier
                if OwnerOccupier > 0 then begin
                    Earnings.Reset();
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Owner Occupier");
                    if Earnings.Find('-') then
                        repeat
                            if Employee.Get(EmployeeNo) then;
                            if Assignmatrix.Find('-') then
                                Assignmatrix.Init();
                            Assignmatrix."Employee No" := Employee."No.";
                            Assignmatrix.Type := Assignmatrix.Type::Earning;
                            Assignmatrix.Code := Earnings.Code;
                            Assignmatrix."Reference No" := '';
                            Assignmatrix.Validate(Code);
                            Assignmatrix."Payroll Period" := DateSpecified;
                            Assignmatrix."Department Code" := Employee."Global Dimension 1 Code";
                            Assignmatrix.Amount := OwnerOccupier;
                            Assignmatrix."Posting Group Filter" := Employee."Posting Group";
                            Assignmatrix."Department Code" := Employee."Global Dimension 1 Code";
                            Assignmatrix.Validate(Amount);
                            if (Assignmatrix.Amount <> 0) and
                               (not Assignmatrix.Get(Assignmatrix."Employee No", Assignmatrix.Type,
                                    Assignmatrix.Code, Assignmatrix."Payroll Period", Assignmatrix."Reference No")) then
                                Assignmatrix.Insert()
                            else begin
                                Assignmatrix.Reset();
                                Assignmatrix.SetRange("Payroll Period", DateSpecified);
                                Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                                Assignmatrix.SetRange(Code, Earnings.Code);
                                Assignmatrix.SetRange("Employee No", EmployeeNo);
                                if Assignmatrix.Find('-') then begin
                                    Assignmatrix.Amount := OwnerOccupier;
                                    Assignmatrix.Validate(Amount);
                                    Assignmatrix.Modify();
                                end;
                            end;
                        until Earnings.Next() = 0;
                end;

                //if OwnerOccupier = 0 then begin//For cases with deductions elsewhere
                OwnerOccupier := 0;                     // Mortgage Relief
                Earnings.Reset();
                Earnings.SetCurrentKey("Earning Type");
                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Owner Occupier");
                if Earnings.Find('-') then
                    repeat
                        Assignmatrix.Reset();
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                        Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.Find('-') then
                            OwnerOccupier := OwnerOccupier + Assignmatrix.Amount;
                    until Earnings.Next() = 0;

                if OwnerOccupier > 0 then begin
                    HRSetup.Get();

                    /* if HRSetup."Owner Occupied Interest Limit" < OwnerOccupier then
                        OwnerOccupier := HRSetup."Owner Occupied Interest Limit"; */

                    TaxableAmount := TaxableAmount - OwnerOccupier;
                end;
                //end;
                // End ofOwner occupier Specific
                /*
                // Low Interest Benefits
                     EarnRec.Reset();
                     EarnRec.SetCurrentKey(EarnRec."Earning Type");
                     EarnRec.SetRange(EarnRec."Earning Type",EarnRec."Earning Type"::"Low Interest");
                     if EarnRec.Find('-') then begin
                      repeat
                       Assignmatrix.Reset();
                       Assignmatrix.SetRange(Assignmatrix."Payroll Period",DateSpecified);
                       Assignmatrix.SetRange(Type,Assignmatrix.Type::Payment);
                       Assignmatrix.SetRange(Assignmatrix.Code,EarnRec.Code);
                       Assignmatrix.SetRange(Assignmatrix."Employee No",EmployeeNo);
                       if Assignmatrix.Find('-') then
                        TaxableAmount:=TaxableAmount+Assignmatrix.Amount;
                      until EarnRec.Next()=0;
                     end;
                 //End of Low Interest benefits
                */
                //Per Diem
                PPSetup.Get();
                Earnings.Reset();
                Earnings.SetRange("Per Diem", true);
                if Earnings.Find('-') then
                    repeat
                        Assignmatrix.Reset();
                        Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                        Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                        Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.Find('-') then
                            if Assignmatrix."No of Days" > 0 then
                                TaxableAmount := TaxableAmount - (Assignmatrix."No of Days" * 1)
                            else
                                if Assignmatrix."No of Days" = 0 then
                                    TaxableAmount := TaxableAmount;
                    until Earnings.Next() = 0;
                //
                TaxableAmount := Round(TaxableAmount, 0.01, '<');
                TaxableAmountNew := TaxableAmount;

                // Get PAYE
                // Message('here4');
                if Employee."Secondary Employee" then begin
                    HRSetup.TestField("Secondary PAYE %");
                    FinalTax := TaxableAmount * (HRSetup."Secondary PAYE %" / 100);
                end else
                    FinalTax := GetTaxBracket(TaxableAmount, Employee);
                //   Message('final is %1', FinalTax);
                if Employee.Get(EmployeeNo) then;
                if Employee."Employee Job Type" <> Employee."Employee Job Type"::Director then begin
                    // Get Reliefs
                    InsuranceRelief := 0;
                    // Calculate insurance relief;
                    Earnings.Reset();
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                    if Earnings.Find('-') then
                        repeat
                            Assignmatrix.Reset();
                            Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                            Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                            Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.Find('-') then
                                InsuranceRelief := InsuranceRelief + Assignmatrix.Amount;
                        until Earnings.Next() = 0;

                    NHIFRelief := 0;
                    // Calculate insurance relief;
                    Earnings.Reset();
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"NHIF Relief");
                    if Earnings.Find('-') then
                        repeat
                            Assignmatrix.Reset();
                            Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                            Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                            Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.Find('-') then
                                NHIFRelief := NHIFRelief + Assignmatrix.Amount;
                        until Earnings.Next() = 0;

                    // Housing Levy Relief
                    Earnings.Reset();
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Housing Levy Relief");
                    if Earnings.Find('-') then
                        repeat
                            Assignmatrix.Reset();
                            Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                            Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                            Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.Find('-') then
                                HousingLevyRelief := HousingLevyRelief + Assignmatrix.Amount;
                        until Earnings.Next() = 0;

                    // Personal Relief
                    PersonalRelief := 0;
                    Earnings.Reset();
                    Earnings.SetCurrentKey("Earning Type");
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Tax Relief");
                    if Earnings.FindSet() then
                        repeat
                            Assignmatrix.Reset();
                            Assignmatrix.SetRange(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SetRange(Type, Assignmatrix.Type::Earning);
                            Assignmatrix.SetRange(Assignmatrix.Code, Earnings.Code);
                            Assignmatrix.SetRange(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.FindFirst() then
                                PersonalRelief := PersonalRelief + Assignmatrix.Amount;
                        until Earnings.Next() = 0;
                end;
                //   Message('here4');

                // Get PAYE
                if not Employee."Secondary Employee" then
                    FinalTax := FinalTax - (PersonalRelief + InsuranceRelief + MortgageRelief + NHIFRelief + HousingLevyRelief)
                else
                    FinalTax := FinalTax;

                if FinalTax < 0 then
                    FinalTax := 0;
            end else
                FinalTax := 0;

    end;

    procedure CheckIfPartime(Emp: Code[10]): Integer
    var
        Employee: Record Employee;
        EmpContract: Record "Employment Contract";
    begin
        if Employee.Get(Emp) then
            if EmpContract.Get(Employee."Nature of Employment") then
                exit(EmpContract."Employee Type");
    end;

    procedure CheckOneThirdRule(EmpNo: Code[20]; PayP: Date; var NetPay: Decimal; var TotalEarnings: Decimal; var TotalDeductions: Decimal; var ExemptionDeductions: Decimal; var Ratio: Decimal): Boolean
    var
        EmpRec: Record Employee;
        HRSetup: Record "Human Resources Setup";
        ExemptDeductions: Decimal;
    begin
        HRSetup.Get();
        if HRSetup."Enforce a third rule" then begin
            HRSetup.TestField("Net pay ratio to Earnings");
            ExemptDeductions := 0;
            TotalEarnings := 0;
            TotalDeductions := 0;

            EmpRec.Reset();
            EmpRec.SetRange("No.", EmpNo);
            EmpRec.SetRange("Pay Period Filter", PayP);
            if EmpRec.Find('-') then
                if not EmpRec."Exempt from third rule" then begin
                    EmpRec.CalcFields("Total Allowances", "Total Deductions");
                    if EmpRec."Total Allowances" <> 0 then begin
                        GetOneThirdExemptDeductions(EmpNo, PayP, ExemptDeductions);
                        if (EmpRec."Total Allowances" - (Abs(EmpRec."Total Deductions") - ExemptDeductions)) /
                            (EmpRec."Total Allowances") >= HRSetup."Net pay ratio to Earnings" then
                            exit(true)
                        else begin
                            NetPay := EmpRec."Total Allowances" * HRSetup."Net pay ratio to Earnings";
                            TotalEarnings := EmpRec."Total Allowances";
                            TotalDeductions := Abs(EmpRec."Total Deductions");
                            ExemptionDeductions := ExemptDeductions;
                            Ratio := (TotalEarnings - (TotalDeductions - ExemptionDeductions)) / (TotalEarnings);
                            Ratio := Round(Ratio);
                            exit(false);
                        end;
                    end;
                end else
                    exit(true);
        end else
            exit(true);

        /* AssignMat.Reset();
        AssignMat.SetRange("Employee No", EmpNo);
        AssignMat.SetRange("Payroll Period", PayP);
        if AssignMat.Find('-') then;
        begin
            AssignMat.SetRange(Type, AssignMat.Type::Payment);
            AssignMat.CalcSums(Amount);
            Earnin := AssignMat.Amount;
            Message(Format(Earnin));
        end;

        begin
            AssignMat.SetRange(Type, AssignMat.Type::Deduction);
            AssignMat.CalcSums(Amount);
            Deduc := AssignMat.Amount;
            Message(Format(Deduc));
        end;
        Message(Format(Earnin + Deduc));
        if ((Earnin + Deduc) > (AssignMat."Basic Pay" / HRSetup."Net pay ratio to Earnings")) then
            Message('Insert') else
            Message('Reduce Deductions'); */
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Exponent: Integer;
        Hundreds: Integer;
        NoTextIndex: Integer;
        Ones: Integer;
        Tens: Integer;
        DashLbl: Label '-';
        HundredLbl: Label 'HUNDRED';
        ZeroLbl: Label 'ZERO';
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, HundredLbl);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        AddToNoText(NoText, NoTextIndex, PrintExponent, DashLbl);
        AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        //FORMAT(No * 100) + '/100');
        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    procedure GetActingEmployees(var Acting: Record "Employee Acting Position")
    var
        TodayDate: Date;
        Counter: Integer;
    begin
        TodayDate := Today;

        Acting.Reset();
        Acting.SetFilter("Start Date", '<=%1', TodayDate);
        Acting.SetFilter("End Date", '>=%1', TodayDate);
        if Acting.Find('-') then begin
            Counter := Acting.Count;
            Message(Format(Counter));
        end;
    end;

    procedure GetCurrentBasicPay(EmpNo: Code[20]; PayPeriod: Date): Decimal
    var
        AssignmentMatrix: Record "Assignment Matrix";
        Earnings: Record Earnings;
    begin
        Earnings.Reset();
        Earnings.SetRange("Basic Salary Code", true);
        if Earnings.FindFirst() then begin
            AssignmentMatrix.Reset();
            AssignmentMatrix.SetRange(Code, Earnings.Code);
            AssignmentMatrix.SetRange("Employee No", EmpNo);
            AssignmentMatrix.SetRange("Payroll Period", PayPeriod);
            AssignmentMatrix.SetCurrentKey("Employee No", Code, "Payroll Period");
            if AssignmentMatrix.FindFirst() then
                exit((AssignmentMatrix.Amount * 12 / 100));
        end;
    end;

    procedure GetCurrentPay(EmpNo: Code[20]; PayPeriod: Date; "Code": Code[10]): Decimal
    var
        AssignmentMatrix: Record "Assignment Matrix";
    begin
        AssignmentMatrix.Reset();
        AssignmentMatrix.SetRange(Code, Code);
        AssignmentMatrix.SetRange("Employee No", EmpNo);
        AssignmentMatrix.SetRange("Payroll Period", PayPeriod);
        AssignmentMatrix.SetCurrentKey("Employee No", Code, "Payroll Period");
        if AssignmentMatrix.FindFirst() then
            exit(AssignmentMatrix.Amount);
    end;

    procedure GetEmpName(EmpCode: Code[20]): Text
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpCode) then
            exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;

    procedure GetOneThirdExemptDeductions(EmpNo: Code[20]; Period: Date; var ExemptDeductions: Decimal): Boolean
    var
        AssignMat: Record "Assignment Matrix";
        Ded: Record Deductions;
    begin
        Ded.Reset();
        Ded.SetRange("Exempt from a third rule", true);
        if Ded.FindSet() then begin
            repeat
                AssignMat.Reset();
                AssignMat.SetRange("Employee No", EmpNo);
                AssignMat.SetRange(Type, AssignMat.Type::Deduction);
                AssignMat.SetRange("Payroll Period", Period);
                AssignMat.SetRange(Code, Ded.Code);
                if AssignMat.FindFirst() then
                    ExemptDeductions := ExemptDeductions + AssignMat.Amount;
            until Ded.Next() = 0;
            ExemptDeductions := Abs(ExemptDeductions);
        end else
            ExemptDeductions := 0;
    end;

    procedure GetIntReceivableAccount(LoanNo: Code[50]): Code[20]
    var
        LoanProductType: Record "Loan Product Type-Payroll";
        LoanApp: Record "Payroll Loan Application";
    begin
        if LoanApp.Get(LoanNo) then
            if LoanProductType.Get(LoanApp."Loan Product Type") then begin
                LoanProductType.TestField("Interest Receivable Account");
                exit(CopyStr(LoanProductType."Interest Receivable Account", 1, 20));
            end;
    end;

    procedure GetMonthWorked(No: Code[20]) Months: Integer
    var
        Calender: Record Date;
        Employee: Record Employee;
        EndDate: Date;
        StartDate: Date;
    begin
        if Employee.Get(No) then begin
            StartDate := Employee."Contract Start Date";
            EndDate := Employee."Contract End Date";
            if (StartDate <> 0D) and (EndDate > StartDate) then begin
                Calender.Reset();
                Calender.SetRange("Period Type", Calender."Period Type"::Month);
                Calender.SetRange("Period Start", StartDate, EndDate);
                Months := Calender.Count;
                exit(Months);
            end;
        end;
    end;

    procedure GetCurrentPayPeriodDate(): Date
    var
        PayPeriod: Record "Payroll Period";
        PayStartDate: Date;
        PayPeriodtext: Text;
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.FindLast() then begin
            PayPeriodtext := PayPeriod.Name;
            PayStartDate := PayPeriod."Starting Date";
            exit(PayStartDate);
        end else
            Error('Please define at least one open Payroll Period');
    end;

    procedure GetPayrollApprovalCode(PayDate: Date): Code[50]
    var
        PayApproval: Record "Payroll Approval";
    begin
        PayApproval.Reset();
        PayApproval.SetRange("Payroll Period", PayDate);
        if PayApproval.FindFirst() then
            exit(PayApproval.Code);
    end;

    procedure GetPayrollRounding(var RoundPrecision: Decimal; var RoundDirection: Text)
    var
        HRSetup: Record "Human Resources Setup";
    begin
        HRSetup.Get();
        HRSetup.TestField("Payroll Rounding Precision");
        RoundPrecision := HRSetup."Payroll Rounding Precision";

        case HRSetup."Payroll Rounding Type" of
            HRSetup."Payroll Rounding Type"::Down:
                RoundDirection := '<';
            HRSetup."Payroll Rounding Type"::Nearest:
                RoundDirection := '=';
            HRSetup."Payroll Rounding Type"::Up:
                RoundDirection := '>';
        end;
    end;

    procedure GetPrevMonth(PayPeriod: Date; EmplNo: Code[10])
    begin
    end;

    procedure GetPureFormula(EmpCode: Code[20]; Payperiod: Date; strFormula: Text[250]) Formula: Text[250]
    var
        StartCopy: Boolean;
        TransCode: Code[10];
        TransCodeAmount: Decimal;
        i: Integer;
        Char: Text[1];
        Where: Text[30];
        Which: Text[30];
        FinalFormula: Text[250];
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;
            if StartCopy then TransCode := CopyStr((TransCode + Char), 1, MaxStrLen(TransCode));
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := CopyStr((FinalFormula + Char), 1, MaxStrLen(FinalFormula));
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := GetCurrentPay(EmpCode, Payperiod, TransCode);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    procedure GetQuatersEmp("Code": Code[20])
    begin
    end;

    procedure GetResult(strFormula: Text[250]) Results: Decimal
    begin
        //Results :=
        //AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;

    procedure GetTaxBracket(TaxableAmount: Decimal; Employee: Record Employee) GetTaxBracket: Decimal
    var
        TaxTable: Record "Brackets";
        HRSetup: Record "Human Resources Setup";
        EndTax: Boolean;
        TaxCode: Code[20];
        AmountRemaining: Decimal;
        Tax: Decimal;
        TotalTax: Decimal;
    begin
        //Added to cater for employees taxed elsewhere
        HRSetup.Get();
        TaxCode := GetTaxCode();
        AmountRemaining := TaxableAmount;
        AmountRemaining := Round(AmountRemaining, 0.01);
        EndTax := false;
        TaxTable.Reset();
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else
                    //  Message('here1');
                    if (Round((TaxableAmount), 1) >= TaxTable."Upper Limit") and (Employee."Min Tax Rate" <= TaxTable.Percentage) then begin
                        //    Message('here12');
                        //Tax:=ROUND((TaxTable."Taxable Amount"*TaxTable.Percentage/100),1);
                        Tax := (TaxTable."Taxable Amount" * TaxTable.Percentage / 100);
                        TotalTax := TotalTax + Tax;
                    end
                    else
                        if (Employee."Min Tax Rate" <= TaxTable.Percentage) then begin
                            //   Message('here13');
                            //Deducted 1 here and got the xact figures just chek incase this may have issues
                            //Only the amount in the last Tax band had issues.
                            case true of
                                (Tax = 0) and (Employee."Min Tax Rate" <> 0):
                                    AmountRemaining := AmountRemaining;
                                else
                                    AmountRemaining := AmountRemaining - TaxTable."Lower Limit";
                            end;
                            //  Message('amount rem is %1', AmountRemaining);

                            Tax := AmountRemaining * (TaxTable.Percentage / 100);
                            //   Message('tax is %1', Tax);

                            EndTax := true;
                            TotalTax := TotalTax + Tax;
                        end;
            until (TaxTable.Next() = 0) or EndTax = true;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        GetTaxBracket := TotalTax;
    end;

    procedure GetTaxCode() TaxCode: Code[20]
    var
        Deductions: Record Deductions;
        NoPAYEDeductionErr: Label 'No PAYE Deduction has been defined';
    begin
        Deductions.Reset();
        Deductions.SetRange("PAYE Code", true);
        Deductions.SetFilter("Deduction Table", '<>%1', ' ');
        if Deductions.FindFirst() then
            exit(Deductions."Deduction Table")
        else
            Error(NoPAYEDeductionErr);
    end;

    procedure GetUserGroup(UserIDs: Code[10]; var PGroup: Code[20])
    var
        UserSetup: Record "User Setup";
        NotSetupInPayrollErr: Label 'You haven''t been setup in the payroll';
    begin
        if UserSetup.Get(UserIDs) then begin
            PGroup := UserSetup."Employee No.";
            Message('pgroup is ' + PGroup);
            if PGroup = '' then
                Error(NotSetupInPayrollErr);
        end;
    end;

    procedure GetYearlyBonus(EmployeeNo: Code[20])
    var
        AssMatrix: Record "Assignment Matrix";
        "Actions": Record "Disciplinary Actions";
        Earn: Record Earnings;
        EmployeeRec: Record Employee;
        Cases: Record "Employee Disciplinary Cases";
        YearlyBonus: Decimal;
        NoofWarnings: Integer;
    begin
        if EmployeeRec.Get(EmployeeNo) then begin
            Cases.Reset();
            Cases.SetRange("Employee No", EmployeeNo);
            if Cases.Find('-') then
                if Actions.Get(Cases."Action Taken") then
                    if Actions."Warning Letter" then
                        //EXIT(Cases.COUNT);
                        NoofWarnings := Cases.Count;
            //MESSAGE(FORMAT(NoofWarnings));
        end;

        AssMatrix.Reset();
        AssMatrix.SetRange("Employee No", EmployeeNo);
        AssMatrix.SetRange(Type, AssMatrix.Type::Earning);
        if AssMatrix.Find('-') then
            if Earn.Get(AssMatrix.Code) then begin
                if Earn."Yearly Bonus" = true then begin
                    YearlyBonus := AssMatrix.Amount;
                    //MESSAGE(FORMAT(YearlyBonus));
                    if NoofWarnings = 1 then
                        AssMatrix.Amount := (AssMatrix.Amount * 0.75);
                    if NoofWarnings = 2 then
                        AssMatrix.Amount := (AssMatrix.Amount * 0.5);
                    if NoofWarnings = 3 then
                        AssMatrix.Amount := (AssMatrix.Amount * 0.25);
                    if NoofWarnings > 3 then
                        AssMatrix.Amount := (AssMatrix.Amount * 0.0);
                end;
                AssMatrix.Modify();
                Message('%1', YearlyBonus);
            end;
    end;

    procedure InitLoanLedgerEntry(var Loans: Record "Payroll Loan Application")
    var
        LoanLedgEntry: Record "Loan Ledger Entry-Payroll";
    begin
        LoanLedgEntry.Init();
        LoanLedgEntry."Entry No." := GetNextLoanEntryNo();
        LoanLedgEntry."Loan Customer Type" := Loans."Loan Customer Type";
        LoanLedgEntry."Employee No." := Loans."Employee No";
        LoanLedgEntry."Debtor's Code" := Loans."Debtors Code";
        LoanLedgEntry."Document No." := Loans."Loan No";
        LoanLedgEntry."Loan No." := Loans."Loan Application No.";
        LoanLedgEntry."Posting Date" := Loans."Application Date";
        LoanLedgEntry."User ID" := CopyStr(UserId(), 1, MaxStrLen(LoanLedgentry."User ID"));
        case Loans."Transaction Type" of
            Loans."Transaction Type"::"Loan Application":
                begin
                    LoanLedgEntry."Loan No." := Loans."Loan No";
                    LoanLedgEntry.Validate("Transaction Type", LoanLedgEntry."Transaction Type"::Principal);
                    LoanLedgEntry.Amount := Loans."Approved Amount";
                    LoanLedgEntry."Payment Mode" := Loans."Payment Method";
                    LoanLedgEntry."Payment Reference No." := Loans."Payment Refrence No.";
                    LoanLedgEntry.Description := 'Loan Application Loan No. ' + Loans."Loan No" + ' for ' + Loans."Employee No" + ' - ' + Loans."Employee Name";
                end;
            Loans."Transaction Type"::"Loan Settlement":
                begin
                    LoanLedgEntry."Loan No." := Loans."Loan Application No.";
                    LoanLedgEntry.Validate("Transaction Type", LoanLedgEntry."Transaction Type"::Settlement);
                    LoanLedgEntry.Amount := -Loans."Settlement Amount";
                    LoanLedgEntry."Payment Mode" := Loans."Payment Method";
                    LoanLedgEntry."Payment Reference No." := Loans."Payment Refrence No.";
                    LoanLedgEntry.Description := 'Loan Settlement Loan No. ' + Loans."Loan Application No." + ' for ' + Loans."Employee No" + ' - ' + Loans."Employee No";
                end;
        end;
        LoanLedgEntry."Shortcut Dimension 1 Code" := Loans."Shortcut Dimension 1 Code";
        LoanLedgEntry.Validate("Shortcut Dimension 1 Code");
        LoanLedgEntry."Shortcut Dimension 2 Code" := Loans."Shortcut Dimension 2 Code";
        LoanLedgEntry.Validate("Shortcut Dimension 2 Code");
        LoanLedgEntry.Insert();
    end;

    procedure InitLoanRepayment(var LoanRec: Record "Payroll Loan Application")
    var
        LoanRepayment: Record "Loan Repayment-Payroll";
    begin
        LoanRepayment.Init();
        LoanRepayment."Loan No." := LoanRec."Loan No";
        LoanRepayment."Start Date" := LoanRec."Issued Date";
        LoanRepayment."End Date" := CalcDate('<-1M>', CalcDate((Format(LoanRec.Instalment) + 'M'), LoanRec."Issued Date"));
        LoanRepayment."No. of Periods" := LoanRec.Instalment;
        LoanRepayment."Customer No." := LoanRec."Debtors Code";
        LoanRepayment."Repayment Amount" := LoanRec.Repayment;
        if not LoanRepayment.Get(LoanRepayment."Loan No.", LoanRepayment."Start Date") then
            LoanRepayment.Insert()
        else begin
            LoanRepayment.Init();
            LoanRepayment."Loan No." := LoanRec."Loan No";
            LoanRepayment."Start Date" := LoanRec."Issued Date";
            LoanRepayment."End Date" := CalcDate('<-1M>', CalcDate((Format(LoanRec.Instalment) + 'M'), LoanRec."Issued Date"));
            LoanRepayment."No. of Periods" := LoanRec.Instalment;
            LoanRepayment."Customer No." := LoanRec."Debtors Code";
            LoanRepayment."Repayment Amount" := LoanRec.Repayment;
            LoanRepayment.Modify();
        end;
    end;

    procedure InsertAssignMatrix(Header: Record "Import Earn & Ded Header")
    var
        AssignMatrix: Record "Assignment Matrix";
        Lines: Record "Import Earn & Ded Lines";
    begin

        Lines.Reset();
        Lines.SetRange(No, Header.No);
        if Lines.Find('-') then
            repeat
                AssignMatrix.Init();
                AssignMatrix.Type := Header.Type;
                AssignMatrix.Code := Header.Code;
                AssignMatrix."Payroll Period" := Header."Pay Period";
                AssignMatrix.Validate(Code);
                AssignMatrix."Reference No" := '';
                AssignMatrix."Employee No" := Lines."Employee No";
                if AssignMatrix.Type = AssignMatrix.Type::Deduction then
                    AssignMatrix.Amount := -Lines.Amount
                else
                    AssignMatrix.Amount := Lines.Amount;
                if not AssignMatrix.Get(Lines."Employee No", Header.Type, Header.Code, Header."Pay Period", AssignMatrix."Reference No") then
                    AssignMatrix.Insert()
                else begin
                    AssignMatrix.Type := Header.Type;
                    AssignMatrix.Code := Header.Code;
                    AssignMatrix."Payroll Period" := Header."Pay Period";
                    AssignMatrix.Validate(Code);
                    AssignMatrix."Reference No" := '';
                    AssignMatrix."Employee No" := Lines."Employee No";
                    if AssignMatrix.Type = AssignMatrix.Type::Deduction then
                        AssignMatrix.Amount := -Lines.Amount
                    else
                        AssignMatrix.Amount := Lines.Amount;
                    AssignMatrix.Modify();
                end;
            until Lines.Next() = 0;
    end;

    procedure PayPertimers(EmplyeeNo: Code[20]; EDCode: Code[20])
    var
        AssignmentMatrix: Record "Assignment Matrix";
        PartimePayments: Record "Employee Pay Requests";
        ReferenceNo: Code[10];
        Amnt: Decimal;
    begin
        PartimePayments.Reset();
        PartimePayments.SetRange(Status, PartimePayments.Status::Approved);
        PartimePayments.SetRange(Date, 0D, Today);
        PartimePayments.SetRange("Employee No.", EmplyeeNo);
        PartimePayments.SetRange("ED Code", EDCode);
        if PartimePayments.Find('-') then
            repeat
                //PartimePayments.CALCSUMS(Amount);
                Amnt := PartimePayments.Amount;
                ReferenceNo := '';
                if Amnt = 0 then exit;
                if not AssignmentMatrix.Get(EmplyeeNo, AssignmentMatrix.Type::Earning, EDCode, GetCurrentPayPeriodDate(), ReferenceNo) then begin
                    AssignmentMatrix.Init();
                    AssignmentMatrix."Employee No" := EmplyeeNo;
                    AssignmentMatrix.Type := AssignmentMatrix.Type::Earning;
                    AssignmentMatrix.Code := EDCode;
                    AssignmentMatrix.Validate(Code);
                    AssignmentMatrix."Payroll Period" := GetCurrentPayPeriodDate();
                    AssignmentMatrix.Amount := Amnt;
                    AssignmentMatrix.Insert();
                end else
                    AssignmentMatrix.Amount := Amnt;
                AssignmentMatrix.Modify();
                // PartimePayments.RESET;
                // PartimePayments.SETRANGE(Status,PartimePayments.Status::Approved);
                // PartimePayments.SETRANGE(Date,0D,TODAY);
                // PartimePayments.SETRANGE("Employee No.",EmplyeeNo);
                PartimePayments.ModifyAll(Status, PartimePayments.Status::Paid);
            until PartimePayments.Next() = 0;
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
        Amttoround: Decimal;
        DecPosistion: Integer;
        SecNo: Integer;
        amttext: Text[30];
        Decvalue: Text[30];
        FirstNoText: Text[30];
        holdamt: Text[30];
        SecNoText: Text[30];
        Wholeamt: Text[30];
    begin
        Evaluate(amttext, Format(Amount));
        DecPosistion := StrPos(amttext, '.');
        if DecPosistion > 0 then begin
#pragma warning disable AA0139
            Wholeamt := CopyStr(amttext, 1, DecPosistion - 1);
            Decvalue := CopyStr(amttext, DecPosistion + 1, 2);
            if StrLen(Decvalue) = 1 then
                holdamt := Decvalue + '0';
            if StrLen(Decvalue) > 1 then begin
                FirstNoText := CopyStr(Decvalue, 1, 1);
                SecNoText := CopyStr(Decvalue, 2, 1);
                Evaluate(SecNo, Format(SecNoText));
                if SecNo >= 5 then
                    holdamt := FirstNoText + '5'
                else
                    holdamt := FirstNoText + '0'
            end;
            amttext := Wholeamt + '.' + holdamt;
#pragma warning restore AA0139
            Evaluate(Amttoround, Format(amttext));
        end else begin
            Evaluate(amttext, Format(Amount));
            Evaluate(Amttoround, Format(amttext));
        end;
        Amount := Amttoround;
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

    procedure PostInternalLoan(LoanApp: Record "Payroll Loan Application")
    var
        AssMatrix: Record "Assignment Matrix";
        Emp: Record Employee;
        GLEntry: Record "G/L Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        CashSetup: Record "Human Resources Setup";
        PreviewShedule: Record "Payroll Repayment Schedule";
        LoanBatch: Code[10];
        LoanTemplate: Code[10];
        InterestAmt: Decimal;
        LineNo: Integer;
    begin
        //Insert Loan Deduction
        if LoanApp."Issued Date" = 0D then
            Error('You must specify the issue date before issuing the loan');

        if LoanApp."Approved Amount" = 0 then
            Error('You must specify the Approved amount before issuing the loan');

        if LoanApp."Interest Rate" <> 0 then
            InterestAmt := (LoanApp."Approved Amount" * (LoanApp."Interest Rate" / 100));

        LoanApp.TestField("Loan Status", LoanApp."Loan Status"::Approved);

        if LoanApp."Loan Customer Type" = LoanApp."Loan Customer Type"::Staff then
            if not LoanApp."Opening Loan" then begin
                Emp.Get(LoanApp."Employee No");
                AssMatrix.Init();
                AssMatrix."Employee No" := LoanApp."Employee No";
                AssMatrix.Type := AssMatrix.Type::Deduction;
                AssMatrix."Reference No" := LoanApp."Loan No";
                if LoanApp."Deduction Code" = '' then
                    Error('Loan %1 must be associated with a deduction', LoanApp."Loan Product Type")
                else
                    AssMatrix.Code := LoanApp."Deduction Code";
                AssMatrix."Payroll Period" := LoanApp."Issued Date";
                AssMatrix.Description := LoanApp.Description;
                AssMatrix."Payroll Group" := Emp."Posting Group";
                AssMatrix."Department Code" := Emp."Global Dimension 1 Code";
                case LoanApp."Interest Calculation Method" of
                    LoanApp."Interest Calculation Method"::"Sacco Reducing Balance":
                        begin
                            PreviewShedule.Reset();
                            PreviewShedule.SetRange("Loan No", LoanApp."Loan No");
                            PreviewShedule.SetRange("Repayment Date", LoanApp."Issued Date");
                            if PreviewShedule.FindFirst() then begin
                                //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                                AssMatrix.Amount := LoanApp.Repayment;
                                AssMatrix."Loan Interest" := PreviewShedule."Monthly Interest";
                            end;
                        end;
                    LoanApp."Interest Calculation Method"::"Flat Rate":
                        begin
                            PreviewShedule.Reset();
                            PreviewShedule.SetRange("Loan No", LoanApp."Loan No");
                            PreviewShedule.SetRange("Repayment Date", LoanApp."Issued Date");
                            if PreviewShedule.FindFirst() then begin
                                //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                                AssMatrix.Amount := LoanApp.Repayment;
                                ;
                                AssMatrix."Loan Interest" := PreviewShedule."Monthly Interest";
                            end;
                        end;
                    LoanApp."Interest Calculation Method"::Amortised:
                        begin
                            PreviewShedule.Reset();
                            PreviewShedule.SetRange("Loan No", LoanApp."Loan No");
                            PreviewShedule.SetRange("Repayment Date", LoanApp."Issued Date");
                            if PreviewShedule.FindFirst() then begin
                                //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                                AssMatrix.Amount := LoanApp.Repayment;
                                AssMatrix."Loan Interest" := PreviewShedule."Monthly Interest";
                            end;
                        end
                    else begin
                        AssMatrix.Amount := LoanApp.Repayment;
                        AssMatrix."Loan Interest" := InterestAmt;
                    end;
                end;
                AssMatrix."Next Period Entry" := true;
                AssMatrix."Loan Repay" := true;
                AssMatrix.Validate(AssMatrix.Amount);
                AssMatrix.Validate("Loan Interest");
                if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, LoanApp."Deduction Code", LoanApp."Issued Date", LoanApp."Loan No") then
                    AssMatrix.Insert()
                else begin
                    Emp.Get(LoanApp."Employee No");
                    AssMatrix."Employee No" := LoanApp."Employee No";
                    AssMatrix.Type := AssMatrix.Type::Deduction;
                    AssMatrix."Reference No" := LoanApp."Loan No";
                    if LoanApp."Deduction Code" = '' then
                        Error('Loan %1 must be associated with a deduction', LoanApp."Loan Product Type")
                    else
                        AssMatrix.Code := LoanApp."Deduction Code";
                    AssMatrix."Payroll Period" := LoanApp."Issued Date";
                    AssMatrix.Description := LoanApp.Description;
                    AssMatrix."Payroll Group" := Emp."Posting Group";
                    AssMatrix."Department Code" := Emp."Global Dimension 1 Code";
                    case LoanApp."Interest Calculation Method" of
                        LoanApp."Interest Calculation Method"::"Sacco Reducing Balance":
                            begin
                                PreviewShedule.Reset();
                                PreviewShedule.SetRange("Loan No", LoanApp."Loan No");
                                PreviewShedule.SetRange("Repayment Date", LoanApp."Issued Date");
                                if PreviewShedule.FindFirst() then begin
                                    AssMatrix.Amount := PreviewShedule."Principal Repayment";
                                    AssMatrix."Loan Interest" := PreviewShedule."Monthly Interest";
                                end;
                            end;
                        LoanApp."Interest Calculation Method"::"Flat Rate":
                            begin
                                PreviewShedule.Reset();
                                PreviewShedule.SetRange("Loan No", LoanApp."Loan No");
                                PreviewShedule.SetRange("Repayment Date", LoanApp."Issued Date");
                                if PreviewShedule.FindFirst() then begin
                                    AssMatrix.Amount := PreviewShedule."Principal Repayment";
                                    AssMatrix."Loan Interest" := PreviewShedule."Monthly Interest";
                                end;
                            end;
                        LoanApp."Interest Calculation Method"::Amortised:
                            begin
                                PreviewShedule.Reset();
                                PreviewShedule.SetRange("Loan No", LoanApp."Loan No");
                                PreviewShedule.SetRange("Repayment Date", LoanApp."Issued Date");
                                if PreviewShedule.FindFirst() then begin
                                    //AssMatrix.Amount:=PreviewShedule."Monthly Repayment";
                                    AssMatrix.Amount := PreviewShedule."Principal Repayment";
                                    AssMatrix."Loan Interest" := PreviewShedule."Monthly Interest";
                                end;
                            end
                        else begin
                            AssMatrix.Amount := LoanApp.Repayment;
                            AssMatrix."Loan Interest" := InterestAmt;
                        end;
                    end;
                    AssMatrix."Next Period Entry" := true;
                    AssMatrix."Loan Repay" := true;
                    AssMatrix.Validate(AssMatrix.Amount);
                    AssMatrix.Validate("Loan Interest");
                    AssMatrix.Modify();
                end;

                //Opening Loan
            end else begin
                Emp.Get(LoanApp."Employee No");
                AssMatrix.Init();
                AssMatrix."Employee No" := LoanApp."Employee No";
                AssMatrix.Type := AssMatrix.Type::Deduction;
                AssMatrix.Code := LoanApp."Deduction Code";
                AssMatrix."Payroll Period" := LoanApp."Issued Date";
                AssMatrix."Reference No" := LoanApp."Loan No";
                AssMatrix.Description := LoanApp.Description;
                AssMatrix."Payroll Group" := Emp."Posting Group";
                AssMatrix."Department Code" := Emp."Global Dimension 1 Code";
                case LoanApp."Interest Calculation Method" of
                    LoanApp."Interest Calculation Method"::"Sacco Reducing Balance":
                        begin
                            if not LoanApp.Suggested then
                                AssMatrix.Amount := LoanApp.Repayment
                            else
                                AssMatrix.Amount := LoanApp."Suggested Repayment Amount";
                            AssMatrix."Loan Interest" := InterestAmt;
                        end;
                    LoanApp."Interest Calculation Method"::"Flat Rate":
                        begin
                            AssMatrix.Amount := LoanApp."Flat Rate Principal";
                            AssMatrix."Loan Interest" := LoanApp."Flat Rate Interest";
                        end
                    else begin
                        AssMatrix.Amount := LoanApp.Repayment;
                        AssMatrix."Loan Interest" := InterestAmt;
                    end;
                end;
                AssMatrix.Amount := LoanApp.Repayment + InterestAmt;
                AssMatrix.Validate(AssMatrix.Amount);
                AssMatrix.Validate("Loan Interest");
                AssMatrix."Next Period Entry" := true;
                AssMatrix."Loan Repay" := true;
                if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, LoanApp."Deduction Code", LoanApp."Issued Date", LoanApp."Loan No") then
                    AssMatrix.Insert()

                else begin
                    Emp.Get(LoanApp."Employee No");
                    AssMatrix."Employee No" := LoanApp."Employee No";
                    AssMatrix.Type := AssMatrix.Type::Deduction;
                    AssMatrix.Code := LoanApp."Deduction Code";
                    AssMatrix."Payroll Period" := LoanApp."Issued Date";
                    AssMatrix."Reference No" := LoanApp."Loan No";
                    AssMatrix.Description := LoanApp.Description;
                    AssMatrix."Payroll Group" := Emp."Posting Group";
                    AssMatrix."Department Code" := Emp."Global Dimension 1 Code";
                    case LoanApp."Interest Calculation Method" of
                        LoanApp."Interest Calculation Method"::"Sacco Reducing Balance":
                            begin
                                AssMatrix.Amount := LoanApp.Repayment;
                                AssMatrix."Loan Interest" := InterestAmt;
                            end;
                        LoanApp."Interest Calculation Method"::"Flat Rate":
                            begin
                                AssMatrix.Amount := LoanApp."Flat Rate Principal";
                                AssMatrix."Loan Interest" := LoanApp."Flat Rate Interest";
                            end
                        else begin
                            AssMatrix.Amount := LoanApp.Repayment;
                            AssMatrix."Loan Interest" := InterestAmt;
                        end;
                    end;
                    AssMatrix.Amount := LoanApp.Repayment + InterestAmt;
                    AssMatrix.Validate(AssMatrix.Amount);
                    AssMatrix.Validate("Loan Interest");
                    AssMatrix."Next Period Entry" := true;
                    AssMatrix."Loan Repay" := true;
                    AssMatrix.Modify();
                end;
            end;
        //Init Loan Ledger Entry
        InitLoanLedgerEntry(LoanApp);

        //Post Loan
        CashSetup.Get();
        //CashSetup.TestField("Loan Batch Template");
        //CashSetup.TestField("Loan Journal Template");
        LoanTemplate := 'GENERAL';//CashSetup."Loan Journal Template";
        LoanBatch := CopyStr(LoanApp."Loan No", 1, MaxStrLen(LoanBatch));   //CashSetup."Loan Batch Template";

        LoanApp.TestField("Payment Date");

        //Delete existing records in batch
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", LoanTemplate);
        GenJournalLine.SetRange("Journal Batch Name", LoanBatch);
        GenJournalLine.DeleteAll();

        //Initialise Loan Batch
        GenJournalBatch.Init();
        if CashSetup.Get() then;
        GenJournalBatch."Journal Template Name" := CopyStr(LoanTemplate, 1, MaxStrLen(GenJournalBatch."Journal Template Name"));
        GenJournalBatch.Name := CopyStr(LoanBatch, 1, MaxStrLen(GenJournalBatch.Name));
        if not GenJournalBatch.Get(GenJournalBatch."Journal Template Name", GenJournalBatch.Name) then
            GenJournalBatch.Insert();

        //Debit Customer Loan
        LineNo := LineNo + 1000;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Journal Template Name" := LoanTemplate;
        GenJournalLine."Journal Batch Name" := LoanBatch;
        GenJournalLine."Document No." := LoanApp."Loan No";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine.Validate("Account Type");
        if LoanApp."Loan Customer Type" = LoanApp."Loan Customer Type"::Staff then
            GenJournalLine."Account No." := LoanApp."Debtors Code"
        else
            GenJournalLine."Account No." := LoanApp."Employee No";
        GenJournalLine.Validate("Account No.");
        GenJournalLine."Posting Date" := LoanApp."Payment Date";
        GenJournalLine.Description := GetLoanProductName(LoanApp."Loan Product Type") + '-' + LoanApp."Employee No" + '(' + Format(LoanApp."Issued Date") + ')';
        GenJournalLine.Amount := LoanApp."Amount Requested";
        GenJournalLine.Validate(Amount);
        GenJournalLine."Payroll Loan No." := LoanApp."Loan No";
        GenJournalLine."Payroll Loan Transaction Type" := GenJournalLine."Payroll Loan Transaction Type"::"Principal Due";
        GenJournalLine."Shortcut Dimension 1 Code" := LoanApp."Shortcut Dimension 1 Code";
        GenJournalLine.Validate("Shortcut Dimension 1 Code");
        GenJournalLine."Shortcut Dimension 2 Code" := LoanApp."Shortcut Dimension 2 Code";
        GenJournalLine.Validate("Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();

        //Credit Bank Account
        LineNo := LineNo + 1000;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Journal Template Name" := LoanTemplate;
        GenJournalLine."Journal Batch Name" := LoanBatch;
        GenJournalLine."Document No." := LoanApp."Loan No";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account"; // GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine.Validate("Account Type");
        GenJournalLine."Account No." := CopyStr(LoanApp."Paying Bank", 1, MaxStrLen(GenJournalLine."Account No."));
        GenJournalLine.Validate("Account No.");
        GenJournalLine."Posting Date" := LoanApp."Payment Date";
        GenJournalLine.Description := GetLoanProductName(LoanApp."Loan Product Type") + '-' + LoanApp."Employee No" + '(' + Format(LoanApp."Issued Date") + ')';
        GenJournalLine.Amount := -LoanApp."Amount Requested";
        GenJournalLine.Validate(Amount);
        GenJournalLine."Payroll Loan No." := LoanApp."Loan No";
        GenJournalLine."Payroll Loan Transaction Type" := GenJournalLine."Payroll Loan Transaction Type"::"Principal Due";
        GenJournalLine."Shortcut Dimension 1 Code" := LoanApp."Shortcut Dimension 1 Code";
        GenJournalLine.Validate("Shortcut Dimension 1 Code");
        GenJournalLine."Shortcut Dimension 2 Code" := LoanApp."Shortcut Dimension 2 Code";
        GenJournalLine.Validate("Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();

        //Post Entries
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", LoanTemplate);
        GenJournalLine.SetRange("Journal Batch Name", LoanBatch);
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

        //Init Loan Repayment
        InitLoanRepayment(LoanApp);

        //Modify Loan as Issued
        GLEntry.Reset();
        GLEntry.SetRange("Document No.", LoanApp."Loan No");
        GLEntry.SetRange(Reversed, false);
        if not GLEntry.IsEmpty() then begin
            LoanApp."Loan Status" := LoanApp."Loan Status"::Issued;
            LoanApp."Initial Instalments" := LoanApp.Instalment;
            LoanApp.Modify();
            Message('Loan %1 issued and posted successfully', LoanApp."Loan No");
        end;

    end;

    procedure PostLoanInterest(IntHeader: Record "Loan Interest Header")
    var
        GLEntry: Record "G/L Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnLine: Record "Gen. Journal Line";
        HRSetup: Record "Human Resources Setup";
        LoanInterestLines: Record "Loan Interest Lines";
        LineNo: Integer;
    begin
        IntHeader.TestField(Posted, false);
        IntHeader.TestField("Posting Date");

        HRSetup.Get();
        HRSetup.TestField("Loan Interest Template");

        GenJournalBatch.Init();
        GenJournalBatch."Journal Template Name" := HRSetup."Loan Interest Template";
        GenJournalBatch.Name := CopyStr(IntHeader."No.", 1, MaxStrLen(GenJournalBatch.Name));
        if not GenJournalBatch.Get(HRSetup."Loan Interest Template", IntHeader."No.") then
            GenJournalBatch.Insert();

        GenJnLine.SetRange("Journal Template Name", HRSetup."Loan Interest Template");
        GenJnLine.SetRange("Journal Batch Name", IntHeader."No.");
        GenJnLine.DeleteAll();

        LoanInterestLines.Reset();
        LoanInterestLines.SetRange("Document No.", IntHeader."No.");
        if LoanInterestLines.Find('-') then begin
            repeat
                LoanInterestLines.TestField("Debtor Code");
                LineNo := LineNo + 10000;
                GenJnLine.Init();
                GenJnLine."Journal Template Name" := HRSetup."Loan Interest Template";
                GenJnLine."Journal Batch Name" := CopyStr(IntHeader."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
                GenJnLine."Line No." := LineNo;
                GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                GenJnLine."Account No." := CopyStr(LoanInterestLines."Debtor Code", 1, MaxStrLen(GenJnLine."Account No."));
                GenJnLine.Validate(GenJnLine."Account No.");
                GenJnLine."Posting Date" := IntHeader."Posting Date";
                GenJnLine."Document No." := IntHeader."No.";
                GenJnLine."External Document No." := LoanInterestLines."Loan No.";
                GenJnLine.Description := IntHeader.Description + StrSubstNo('-%1', LoanInterestLines."Loan No.");
                GenJnLine.Amount := LoanInterestLines."Interest Due";
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Shortcut Dimension 1 Code" := IntHeader."Shortcut Dimension 1 Code";
                GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                GenJnLine."Shortcut Dimension 2 Code" := IntHeader."Shortcut Dimension 2 Code";
                GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                GenJnLine."Dimension Set ID" := IntHeader."Dimension Set ID";
                GenJnLine."Payroll Loan No." := LoanInterestLines."Loan No.";
                GenJnLine."Payroll Loan Transaction Type" := GenJnLine."Payroll Loan Transaction Type"::"Interest Due";
                GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
                GenJnLine."Bal. Account No." := GetIntReceivableAccount(LoanInterestLines."Loan No.");
                GenJnLine."Period Reference" := IntHeader."Period Reference";
                GenJnLine.Validate("Bal. Account No.");
                if GenJnLine.Amount <> 0 then
                    GenJnLine.Insert();
            until LoanInterestLines.Next() = 0;

            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", HRSetup."Loan Interest Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", IntHeader."No.");
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);

            GLEntry.Reset();
            GLEntry.SetRange("Document No.", IntHeader."No.");
            GLEntry.SetRange("Posting Date", IntHeader."Posting Date");
            if not GLEntry.IsEmpty() then begin
                IntHeader.Posted := true;
                IntHeader."Date Posted" := Today;
                IntHeader."Time Posted" := Time;
                IntHeader."Posted By" := CopyStr(UserId, 1, MaxStrLen(IntHeader."Posted By"));
                IntHeader.Modify();
            end;
        end;
    end;

    procedure PostPayrollRequest(PaymentReq: Record "Payroll Requests")
    var
        AssignMatrix: Record "Assignment Matrix";
        AssignMatrix2: Record "Assignment Matrix";
        Earnings: Record Earnings;
        Employee: Record Employee;
        LeaveApplication: Record "Leave Application";
        PayrollRequestLines: Record "Payroll Request Lines";
        CurrentPayrollDate: Date;
        AssType: Enum "Payroll Transaction Type";
    begin
        PaymentReq.TestField(Status, PaymentReq.Status::Approved);
        CurrentPayrollDate := GetCurrentPayPeriodDate();

        case PaymentReq.Type of
            PaymentReq.Type::Earning:
                AssType := AssType::Earning;
            PaymentReq.Type::Deduction:
                AssType := AssType::Deduction;
        end;

        case PaymentReq.Applies of
            PaymentReq.Applies::Specific:

                //Special Condition;
                if PaymentReq."Special Condition" <> PaymentReq."Special Condition"::" " then begin
                    if PaymentReq."Special Condition" = PaymentReq."Special Condition"::Suspend then begin
                        Message(PaymentReq."Employee No.");
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Employee No", PaymentReq."Employee No.");
                        AssignMatrix.SetRange("Payroll Period", CurrentPayrollDate);
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                        if AssignMatrix.FindFirst() then
                            repeat
                                if Earnings.Get(AssignMatrix.Code) then begin
                                    AssignMatrix.Amount := AssignMatrix.Amount * Earnings."Supension Earnings Percentage" / 100;
                                    AssignMatrix."Reason For Chage" := PaymentReq.Remarks;
                                    AssignMatrix.Modify();
                                    if Employee.Get(PaymentReq."Employee No.") then
                                        Employee."Payroll Suspenstion Date" := CurrentPayrollDate;
                                    Employee.Modify();
                                end;
                            until AssignMatrix.Next() = 0;
                    end else
                        if PaymentReq."Special Condition" = PaymentReq."Special Condition"::"Re-Instatement" then begin
                            //Delete the current ones
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange("Employee No", PaymentReq."Employee No.");
                            AssignMatrix.SetRange("Payroll Period", CurrentPayrollDate);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                            AssignMatrix.DeleteAll();
                            //Get the last supension date and re-instate
                            if Employee.Get(PaymentReq."Employee No.") then begin
                                AssignMatrix.Reset();
                                AssignMatrix.SetRange("Employee No", PaymentReq."Employee No.");
                                AssignMatrix.SetRange("Payroll Period", CalcDate('<-1M>', Employee."Payroll Suspenstion Date"));
                                AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                                if AssignMatrix.FindFirst() then begin
                                    AssignMatrix2.Init();
                                    AssignMatrix2."Employee No" := PaymentReq."Employee No.";
                                    AssignMatrix2.Type := AssignMatrix.Type;
                                    AssignMatrix2.Code := AssignMatrix.Code;
                                    AssignMatrix."Reference No" := PaymentReq."No.";
                                    AssignMatrix2."Payroll Period" := CurrentPayrollDate;
                                    AssignMatrix2."Reason For Chage" := PaymentReq.Remarks;
                                    AssignMatrix2.Amount := AssignMatrix.Amount * CalculateMonths(Employee."Payroll Suspenstion Date", CurrentPayrollDate);
                                    AssignMatrix2.TransferFields(AssignMatrix);
                                    AssignMatrix2.Insert();
                                end;
                            end;
                        end;
                    //Non Special
                end else begin
                    //Gratuity
                    if PaymentReq.Gratuity then
                        if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, CurrentPayrollDate, PaymentReq."No.") then begin
                            AssignMatrix.Amount := PaymentReq.Amount;
                            AssignMatrix.Modify();
                        end
                        else begin
                            AssignMatrix.Init();
                            AssignMatrix."Employee No" := PaymentReq."Employee No.";
                            AssignMatrix."Payroll Period" := CurrentPayrollDate;
                            case PaymentReq.Type of
                                PaymentReq.Type::Earning:
                                    AssignMatrix.Type := AssignMatrix.Type::Earning;
                                PaymentReq.Type::Deduction:
                                    AssignMatrix.Type := AssignMatrix.Type::Deduction;
                            end;
                            AssignMatrix.Code := PaymentReq.Code;
                            AssignMatrix.Validate(Code);
                            AssignMatrix."Reference No" := PaymentReq."No.";
                            if PaymentReq.Advance then
                                AssignMatrix.Amount := PaymentReq."Monthly Repayment"
                            else
                                AssignMatrix.Amount := PaymentReq.Amount;
                            AssignMatrix.Insert();
                        end;
                    //Locum
                    if PaymentReq.Locum then
                        if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, CurrentPayrollDate, PaymentReq."No.") then begin
                            AssignMatrix.Amount := PaymentReq.Amount;
                            AssignMatrix.Modify();
                        end
                        else begin
                            AssignMatrix.Init();
                            AssignMatrix."Employee No" := PaymentReq."Employee No.";
                            AssignMatrix."Payroll Period" := CurrentPayrollDate;
                            case PaymentReq.Type of
                                PaymentReq.Type::Earning:
                                    AssignMatrix.Type := AssignMatrix.Type::Earning;
                                PaymentReq.Type::Deduction:
                                    AssignMatrix.Type := AssignMatrix.Type::Deduction;
                            end;
                            AssignMatrix.Code := PaymentReq.Code;
                            AssignMatrix.Validate(Code);
                            AssignMatrix."Reference No" := PaymentReq."No.";
                            if PaymentReq.Advance then
                                AssignMatrix.Amount := PaymentReq."Monthly Repayment"
                            else
                                AssignMatrix.Amount := PaymentReq.Amount;
                            AssignMatrix.Insert();
                        end;
                    // Locum

                    if not (PaymentReq.Locum) and not (PaymentReq.Gratuity) then
                        if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, CurrentPayrollDate, PaymentReq."No.") then begin
                            AssignMatrix.Amount := PaymentReq.Amount;
                            AssignMatrix.Modify();
                        end
                        else begin
                            AssignMatrix.Init();
                            AssignMatrix."Employee No" := PaymentReq."Employee No.";
                            AssignMatrix."Payroll Period" := CurrentPayrollDate;
                            case PaymentReq.Type of
                                PaymentReq.Type::Earning:
                                    AssignMatrix.Type := AssignMatrix.Type::Earning;
                                PaymentReq.Type::Deduction:
                                    AssignMatrix.Type := AssignMatrix.Type::Deduction;
                            end;
                            AssignMatrix.Code := PaymentReq.Code;
                            AssignMatrix.Validate(Code);
                            AssignMatrix."Reference No" := PaymentReq."No.";
                            if PaymentReq.Advance then
                                AssignMatrix.Amount := PaymentReq."Monthly Repayment"
                            else
                                AssignMatrix.Amount := PaymentReq.Amount;
                            AssignMatrix.Insert();
                        end;

                    if PaymentReq."Leave Allowance" then
                        if LeaveApplication.Get(PaymentReq."Leave Application Document") then begin
                            LeaveApplication.Validate("Leave Allowance Paid", true);
                            LeaveApplication.Modify();
                        end;

                end;//Non special
                    //Specific
                    //All Employees
            PaymentReq.Applies::All:
                begin
                    PayrollRequestLines.Reset();
                    PayrollRequestLines.SetRange("No.", PaymentReq."No.");
                    if PayrollRequestLines.FindSet() then
                        repeat
                            if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, CurrentPayrollDate, PaymentReq."No.") then begin
                                AssignMatrix.Amount := PayrollRequestLines."New Value";
                                AssignMatrix.Modify();
                            end
                            else begin
                                AssignMatrix.Init();
                                AssignMatrix."Employee No" := PayrollRequestLines."Employee No.";
                                AssignMatrix.Code := PaymentReq.Code;
                                AssignMatrix.Validate(Code);
                                AssignMatrix.Type := AssType;
                                AssignMatrix."Payroll Period" := CurrentPayrollDate;
                                AssignMatrix."Reference No" := PaymentReq."No.";
                                AssignMatrix.Amount := PayrollRequestLines."New Value";
                                AssignMatrix.Insert();
                            end;
                        until PayrollRequestLines.Next() = 0;
                end;
            //A group of employees
            PaymentReq.Applies::Group:
                begin
                    PayrollRequestLines.Reset();
                    PayrollRequestLines.SetRange("No.", PaymentReq."No.");
                    if PayrollRequestLines.FindSet() then
                        repeat
                            if AssignMatrix.Get(PaymentReq."Employee No.", AssType, PaymentReq.Code, CurrentPayrollDate, PaymentReq."No.") then begin
                                AssignMatrix.Amount := PayrollRequestLines."New Value";
                                AssignMatrix.Modify();
                            end
                            else begin
                                AssignMatrix.Init();
                                AssignMatrix."Employee No" := PayrollRequestLines."Employee No.";
                                AssignMatrix.Code := PaymentReq.Code;
                                AssignMatrix.Validate(Code);
                                AssignMatrix.Type := AssType;
                                AssignMatrix."Payroll Period" := CurrentPayrollDate;
                                AssignMatrix."Reference No" := PaymentReq."No.";
                                AssignMatrix.Amount := PayrollRequestLines."New Value";
                                AssignMatrix.Insert();
                            end;
                        until PayrollRequestLines.Next() = 0;
                end;
        end;

        PaymentReq.Status := PaymentReq.Status::Posted;
        PaymentReq."Posted By" := CopyStr(UserId(), 1, MaxStrLen(PaymentReq."Posted By"));
        PaymentReq."Posted At" := CurrentDateTime();
        PaymentReq.Modify();
        Message('Posted to payroll successfully!');
    end;

    procedure ReverseTrusteePayment(TrusteeRev: Record "Trustee Payment Reversal")
    var
        AssignMatrix: Record "Assignment Matrix";
        GLEntry: Record "G/L Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnline: Record "Gen. Journal Line";
        HRSetup: Record "Human Resources Setup";
        TrustRevLines: Record "Trustee Reversal Lines";
        AccNo: Code[20];
        AccType: Enum "Gen. Journal Account Type";
        LineNo: Integer;
    begin
        TrusteeRev.TestField(Posted, false);
        TrusteeRev.TestField("Posting Date");
        TrusteeRev.TestField("Bank Account");

        HRSetup.Get();
        HRSetup.TestField("Trustee Reversal Template");

        GenJournalBatch.Init();
        GenJournalBatch."Journal Template Name" := HRSetup."Trustee Reversal Template";
        GenJournalBatch.Name := CopyStr(TrusteeRev."No.", 1, MaxStrLen(GenJournalBatch.Name));
        if not GenJournalBatch.Get(HRSetup."Trustee Reversal Template", TrusteeRev."No.") then
            GenJournalBatch.Insert();

        GenJnline.SetRange("Journal Template Name", HRSetup."Trustee Reversal Template");
        GenJnline.SetRange("Journal Batch Name", TrusteeRev."No.");
        GenJnline.DeleteAll();

        TrustRevLines.Reset();
        TrustRevLines.SetRange("Document No.", TrusteeRev."No.");
        if TrustRevLines.Find('-') then begin
            repeat
                TrustRevLines.CalcFields("Total Allowances", "Total Deductions", "Net Pay");

                //Reverse Paye
                AssignMatrix.Reset();
                AssignMatrix.SetRange("Employee Type", AssignMatrix."Employee Type"::Trustee);
                AssignMatrix.SetRange("Employee No", TrustRevLines."Trustee No");
                AssignMatrix.SetRange("Payroll Period", TrustRevLines."Pay Period");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SetRange(Paye, true);
                if AssignMatrix.Find('-') then
                    repeat
                        LineNo := LineNo + 10000;
                        GenJnline.Init();
                        GenJnline."Journal Template Name" := HRSetup."Trustee Reversal Template";
                        GenJnline."Journal Batch Name" := CopyStr(TrusteeRev."No.", 1, MaxStrLen(GenJnline."Journal Batch Name"));
                        GenJnline."Line No." := LineNo;
                        GenJnline."Account Type" := GenJnline."Account Type"::"G/L Account";
                        GenJnline."Account No." := CopyStr(GetGrossPayableAccount(TrustRevLines."Trustee No"), 1, MaxStrLen(GenJnline."Account No."));
                        GenJnline.Validate(GenJnline."Account No.");
                        GenJnline."Posting Date" := TrusteeRev."Posting Date";
                        GenJnline."Document No." := TrusteeRev."No.";
                        GenJnline.Description := CopyStr(('Reversal of ' + AssignMatrix.Description + '-' + TrustRevLines."Trustee Name" + ' Period-' + Format(TrustRevLines."Pay Period")), 1, MaxStrLen(GenJnline.Description));
                        GenJnline.Amount := AssignMatrix.Amount;
                        GenJnline.Validate(GenJnline.Amount);
                        GetNetPayableAccount(AssignMatrix.Type, AssignMatrix.Code, AccType, AccNo);
                        GenJnline."Bal. Account Type" := AccType;
                        GenJnline."Bal. Account No." := AccNo;
                        GenJnline.Validate("Bal. Account No.");
                        if GenJnline.Amount <> 0 then
                            GenJnline.Insert();
                    until AssignMatrix.Next() = 0;

                //Reverse bank
                LineNo := LineNo + 10000;
                GenJnline.Init();
                GenJnline."Journal Template Name" := HRSetup."Trustee Reversal Template";
                GenJnline."Journal Batch Name" := CopyStr(TrusteeRev."No.", 1, MaxStrLen(GenJnline."Journal Batch Name"));
                GenJnline."Line No." := LineNo;
                GenJnline."Account Type" := GenJnline."Account Type"::"Bank Account";
                GenJnline."Account No." := TrusteeRev."Bank Account";
                GenJnline.Validate(GenJnline."Account No.");
                GenJnline."Posting Date" := TrusteeRev."Posting Date";
                GenJnline."Document No." := TrusteeRev."No.";
                GenJnline.Description := CopyStr(('Reversal of Net Pay' + '-' + TrustRevLines."Trustee Name" + ' Period-' + Format(TrustRevLines."Pay Period")), 1, MaxStrLen(GenJnline.Description));
                GenJnline.Amount := TrustRevLines."Net Pay";
                GenJnline.Validate(GenJnline.Amount);
                GenJnline."Bal. Account Type" := GenJnline."Bal. Account Type"::"G/L Account";
                GenJnline."Bal. Account No." := GetGrossPayableAccount(TrustRevLines."Trustee No");
                GenJnline.Validate("Bal. Account No.");
                if GenJnline.Amount <> 0 then
                    GenJnline.Insert();

            until TrustRevLines.Next() = 0;

            //Post
            GenJnline.Reset();
            GenJnline.SetRange(GenJnline."Journal Template Name", HRSetup."Trustee Reversal Template");
            GenJnline.SetRange(GenJnline."Journal Batch Name", TrusteeRev."No.");
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnline);

            GLEntry.Reset();
            GLEntry.SetRange("Document No.", TrusteeRev."No.");
            if not GLEntry.IsEmpty() then begin
                TrusteeRev.Posted := true;
                TrusteeRev."Posted Date-Time" := CurrentDateTime;
                TrusteeRev."Posted By" := CopyStr(UserId, 1, MaxStrLen(TrusteeRev."Posted By"));
                TrusteeRev.Modify();

                TrustRevLines.Reset();
                TrustRevLines.SetRange("Document No.", TrusteeRev."No.");
                if TrustRevLines.Find('-') then
                    repeat
                        //Delete entries
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Employee Type", AssignMatrix."Employee Type"::Trustee);
                        AssignMatrix.SetRange("Employee No", TrustRevLines."Trustee No");
                        AssignMatrix.SetRange("Payroll Period", TrustRevLines."Pay Period");
                        AssignMatrix.DeleteAll();
                    until TrustRevLines.Next() = 0;
            end;

        end;
    end;

    procedure SendAllowancesToPayroll(DocNo: Code[20])
    var
        Allowance: Record "Allowance Register";
        AllowanceLine: Record "Allowance Register Line";
        AllowanceLineRec: Record "Allowance Register Line";
        AssignmentMatrixX: Record "Assignment Matrix";
        AllowanceCode: Code[20];
        MustBeOneLineAllowanceErr: Label 'There must be at least one line in Board sitting allowance register line %1.', Comment = '%1 = Document No';
    begin
        Allowance.Get(DocNo);

        AllowanceLine.Reset();
        AllowanceLine.SetRange("Document No.", DocNo);
        if AllowanceLine.FindSet() then
            repeat
                AllowanceLine.TestField("Earning Code");
                AllowanceCode := AllowanceLine."Earning Code";

                AssignmentMatrixX.Reset();
                AssignmentMatrixX.SetRange("Employee No", AllowanceLine."Employee No.");
                AssignmentMatrixX.SetRange("Payroll Period", AllowanceLine."Payroll Period");
                AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Earning);
                AssignmentMatrixX.SetRange(Code, AllowanceCode);
                if not AssignmentMatrixX.FindFirst() then begin
                    AllowanceLineRec.Reset();
                    AllowanceLineRec.SetRange("Document No.", DocNo);
                    AllowanceLineRec.SetRange("Employee No.", AllowanceLine."Employee No.");
                    if AllowanceLineRec.FindFirst() then begin
                        AllowanceLineRec.CalcSums(Amount);
                        AssignmentMatrixX.Init();
                        AssignmentMatrixX.Validate("Employee No", AllowanceLine."Employee No.");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Earning;
                        AssignmentMatrixX.Validate(Code, AllowanceCode);
                        AssignmentMatrixX.Amount := AllowanceLineRec.Amount;
                        AssignmentMatrixX.Insert();
                    end;
                end else begin
                    AllowanceLineRec.Reset();
                    AllowanceLineRec.SetRange("Document No.", DocNo);
                    AllowanceLineRec.SetRange("Employee No.", AllowanceLine."Employee No.");
                    if AllowanceLineRec.FindFirst() then begin
                        AllowanceLineRec.CalcSums(Amount);
                        AssignmentMatrixX.Validate("Employee No", AllowanceLine."Employee No.");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Earning;
                        AssignmentMatrixX.Validate(Code, AllowanceCode);
                        AssignmentMatrixX.Amount := AllowanceLineRec.Amount;
                        AssignmentMatrixX.Imprest := true;
                        AssignmentMatrixX.Modify();
                    end;
                end;

            until AllowanceLine.Next() = 0
        else
            Error(MustBeOneLineAllowanceErr, DocNo);

        Allowance."Date Posted" := Today;
        Allowance."Posted By" := CopyStr(UserId, 1, MaxStrLen(Allowance."Posted By"));
        Allowance.Status := Allowance.Status::Posted;
        Allowance.Modify();
    end;

    procedure SendBulkPayslipMail(PaymentPeriod: Date; Mail: Text)
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Payslip: Report "New Payslipx";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        NewBodyLbl: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your Payslip for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>%3</Strong>', Comment = '%1 = Employee Name, %2 = Pay Period, %3 = Sender Name';
        Receipient: List of [Text];
        AttachOutstr: OutStream;
        Base64Txt: Text;
        FileName: Text;
        FormattedBody: Text;
        PayPeriodText: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        HRSetup.Get();

        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        PayPeriodText := Format(PaymentPeriod, 0, '<Month Text> <Year4>');

        SenderName := HRSetup."General Payslip Message";
        SenderAddress := HRSetup."Human Resource Emails";
        Receipient.Add(Employee."E-Mail");
        Subject := 'Payslip for  Period - ' + PayPeriodText;
        TimeNow := Format(Time);
        FileName := PayPeriodText + '-' + Employee."No." + '.pdf';

        FormattedBody := StrSubstNo(NewBodyLbl, Employee."First Name", PayPeriodText, HRSetup."General Payslip Message");
        EmailMessage.Create(Receipient, Subject, FormattedBody, true);

        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetRange("Pay Period Filter", PaymentPeriod);
        Employee.SetRange("E-Mail", '<>%1', '');
        if Employee.FindSet() then
            repeat
                Clear(Payslip);
                Payslip.SetTableView(Employee);
                TempBlob.CreateOutStream(AttachOutstr);
                if Payslip.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
                    TempBlob.CreateInStream(AttachInstr);
                    Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                    EmailMessage.AddAttachment(CopyStr(FileName, 1, 250), 'application/pdf', Base64Txt);
                end;

                Email.Send(EmailMessage);
            until Employee.Next() = 0;

    end;

    /* procedure SendImprestToPayroll(DocNo: Code[20])
    var
        AssignmentMatrixX: Record "Assignment Matrix";
        Deductions: Record Deductions;
        Deduction: Record "Imprest Deduction";
        DeductionLine: Record "Imprest Deduction Line";
        DeductionLineRec: Record "Imprest Deduction Line";
        Imprest: Record Payments;
        DeductionCode: Code[20];
        Text001: Label 'There must be at least one line in Imprest Deduction %1.';
        Text002: Label 'You have to define a Deduction Code for Imprest in the Deductions.';
    begin
        Deduction.Get(DocNo);
        DeductionLine.Reset();
        DeductionLine.SetRange("Document No.", DocNo);
        if DeductionLine.FindFirst() then begin
            Deductions.Reset();
            Deductions.SetRange(Imprest, true);
            if Deductions.FindFirst() then
                DeductionCode := Deductions.Code
            else
                Error(Text002);
            repeat
                AssignmentMatrixX.Reset();
                AssignmentMatrixX.SetRange("Employee No", DeductionLine."Employee No.");
                AssignmentMatrixX.SetRange("Payroll Period", DeductionLine."Payroll Period");
                AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Deduction);
                AssignmentMatrixX.SetRange(Code, DeductionCode);
                if not AssignmentMatrixX.FindFirst() then begin
                    DeductionLineRec.Reset();
                    DeductionLineRec.SetRange("Document No.", DocNo);
                    DeductionLineRec.SetRange("Employee No.", DeductionLine."Employee No.");
                    if DeductionLineRec.FindFirst() then begin
                        DeductionLineRec.CalcSums(Amount);
                        AssignmentMatrixX.Init();
                        AssignmentMatrixX.Validate("Employee No", DeductionLine."Employee No.");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Deduction;
                        AssignmentMatrixX.Validate(Code, DeductionCode);
                        AssignmentMatrixX.Amount := -DeductionLineRec.Amount;
                        AssignmentMatrixX.Imprest := true;
                        AssignmentMatrixX.Insert();
                    end;
                end else begin
                    DeductionLineRec.Reset();
                    DeductionLineRec.SetRange("Document No.", DocNo);
                    DeductionLineRec.SetRange("Employee No.", DeductionLine."Employee No.");
                    if DeductionLineRec.FindFirst() then begin
                        DeductionLineRec.CalcSums(Amount);
                        AssignmentMatrixX.Validate("Employee No", DeductionLine."Employee No.");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Deduction;
                        AssignmentMatrixX.Validate(Code, DeductionCode);
                        AssignmentMatrixX.Amount := -DeductionLineRec.Amount;
                        AssignmentMatrixX.Imprest := true;
                        AssignmentMatrixX.Modify();
                    end;
                end;

                Imprest.Reset();
                Imprest.SetRange("Payment Type", Imprest."Payment Type"::Imprest);
                Imprest.SetRange("No.", DeductionLine."Imprest No");
                if Imprest.FindFirst() then begin
                    Imprest."Payroll Transfered" := true;
                    Imprest.Modify();
                end;
            until DeductionLine.Next() = 0;
        end else
            Error(Text001, DocNo);

        Deduction."Date Posted" := Today;
        Deduction."Posted By" := UserId;
        Deduction.Status := Deduction.Status::Released;
        Deduction.Modify();
    end; */

    procedure SendPayslipMail(StaffNo: Code[20]; PaymentPeriod: Date; Mail: Text)
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Payslip: Report "New Payslipx";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        NewBodyLbl: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your Payslip for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>%3</Strong>', Comment = '%1 = Employee Name, %2 = Pay Period, %3 = Sender Name';
        Receipient: List of [Text];
        AttachOutstr: OutStream;
        Base64Txt: Text;
        FileName: Text;
        FormattedBody: Text;
        PayPeriodText: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        HRSetup.Get();

        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        PayPeriodText := Format(PaymentPeriod, 0, '<Month Text> <Year4>');

        SenderName := HRSetup."General Payslip Message";
        SenderAddress := HRSetup."Human Resource Emails";
        Receipient.Add(Employee."E-Mail");
        Subject := 'Payslip for  Period - ' + PayPeriodText;
        TimeNow := Format(Time);
        FileName := PayPeriodText + '-' + Employee."No." + '.pdf';

        FormattedBody := StrSubstNo(NewBodyLbl, Employee."First Name", PayPeriodText, HRSetup."General Payslip Message");
        EmailMessage.Create(Receipient, Subject, FormattedBody, true);

        Employee.Reset();
        Employee.SetRange("No.", StaffNo);
        Employee.SetRange("Pay Period Filter", PaymentPeriod);
        if Employee.FindFirst() then begin
            Clear(Payslip);
            Payslip.SetTableView(Employee);
            TempBlob.CreateOutStream(AttachOutstr);
            if Payslip.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
                TempBlob.CreateInStream(AttachInstr);
                Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                EmailMessage.AddAttachment(CopyStr(FileName, 1, 250), 'application/pdf', Base64Txt);
            end;
        end;

        Email.Send(EmailMessage);
    end;

    procedure SuggestLoanInterestLines(IntHeader: Record "Loan Interest Header")
    var
        Customer: Record Customer;
        IntLines: Record "Loan Interest Lines";
        LoanTypeRec: Record "Loan Product Type-Payroll";
        LoanHeader: Record "Payroll Loan Application";
        LoanBal: Decimal;
        RoundPrecisionDec: Decimal;
        LineNo: Integer;
        RoundDirectionCode: Text;
    begin
        //clear lines
        IntLines.SetRange("Document No.", IntHeader."No.");
        IntLines.DeleteAll();

        LoanHeader.Reset();
        LoanHeader.SetRange("Loan Status", LoanHeader."Loan Status"::Issued);
        LoanHeader.SetRange("Transaction Type", LoanHeader."Transaction Type"::"Loan Application");
        if LoanHeader.Find('-') then begin
            LineNo := 0;
            repeat
                LoanTypeRec.Get(LoanHeader."Loan Product Type");
                LoanTypeRec.TestField("Rounding Precision");

                LoanHeader.TestField("Debtors Code");

                case LoanTypeRec.Rounding of
                    LoanTypeRec.Rounding::Nearest:
                        RoundDirectionCode := '=';
                    LoanTypeRec.Rounding::Down:
                        RoundDirectionCode := '<';
                    LoanTypeRec.Rounding::Up:
                        RoundDirectionCode := '>';
                end;

                RoundPrecisionDec := LoanTypeRec."Rounding Precision";
                LoanBal := 0;

                //Get Loan Balance
                if Customer.Get(LoanHeader."Debtors Code") then begin
                    Customer.SetRange("Payroll Loan No. Filter", LoanHeader."Loan No");
                    Customer.SetRange("Date Filter", 0D, IntHeader."Posting Date");
                    //Customer.SETRANGE("Date Filter",0D,IntHeader."Period Reference");
                    Customer.SetFilter("Payroll Loan Trans Type Filter", '%1|%2', Customer."Payroll Loan Trans Type Filter"::"Principal Due", Customer."Payroll Loan Trans Type Filter"::"Principal Repayment");
                    Customer.CalcFields("Net Change", "Net Change (LCY)");
                    LoanBal := Customer."Net Change (LCY)";
                end;

                if (LoanHeader."Approved Amount" > 0) and (LoanBal > 0) then begin
                    LineNo := LineNo + 10000;
                    IntLines.Init();
                    IntLines."Document No." := IntHeader."No.";
                    IntLines."Line No." := LineNo;
                    IntLines."Loan No." := LoanHeader."Loan No";
                    IntLines."Employee No." := LoanHeader."Employee No";
                    IntLines.Validate("Employee No.");
                    IntLines."Period Reference" := IntHeader."Period Reference";
                    IntLines."Loan Amount" := LoanHeader."Approved Amount";
                    IntLines."Loan Balance" := LoanBal;
                    case LoanHeader."Interest Calculation Method" of
                        LoanHeader."Interest Calculation Method"::Amortised,
                      LoanHeader."Interest Calculation Method"::"Reducing Balance",
                      LoanHeader."Interest Calculation Method"::"Sacco Reducing Balance":
                            IntLines."Interest Due" := Round(LoanBal / 100 / 12 * LoanHeader."Interest Rate", RoundPrecisionDec, RoundDirectionCode);
                        LoanHeader."Interest Calculation Method"::"Flat Rate":
                            IntLines."Interest Due" := Round(LoanHeader."Flat Rate Interest" / 12, RoundPrecisionDec, RoundDirectionCode);
                    end;
                    IntLines.Insert();
                end;
            until LoanHeader.Next() = 0;
        end;
    end;

    procedure ValidateFormulaAmounts(AssignRec: Record "Assignment Matrix")
    var
        AssignmentMatrixX: Record "Assignment Matrix";
        Deductions: Record Deductions;
        Earnings: Record Earnings;
        ValidateAmountTxt: Label 'You have earnings or deductions that depend on changing this amount.\Do you wish to update them?';
    begin
        if AssignRec.Amount > 0 then
            if AssignRec."Basic Salary Code" or AssignRec."House Allowance Code" or AssignRec."Commuter Allowance Code" or AssignRec."Salary Arrears Code" or AssignRec."Insurance Code" then begin
                AssignmentMatrixX.Reset();
                AssignmentMatrixX.SetRange(AssignmentMatrixX."Employee No", AssignRec."Employee No");
                AssignmentMatrixX.SetRange(AssignmentMatrixX."Payroll Period", AssignRec."Payroll Period");
                if AssignmentMatrixX.Find('-') then
                    repeat
                        //Deductions
                        Deductions.Reset();
                        Deductions.SetRange(Code, AssignmentMatrixX.Code);
                        Deductions.SetFilter("Calculation Method", '%1|%2|%3', Deductions."Calculation Method"::"% of Basic Pay",
                                              Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance",
                                              Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears");
                        if not Deductions.IsEmpty() then
                            if Confirm(ValidateAmountTxt, false) then begin
                                AssignmentMatrixX.Validate(Code);
                                AssignmentMatrixX.Modify();
                            end;

                        //Earnings
                        Earnings.Reset();
                        Earnings.SetRange(Code, AssignmentMatrixX.Code);
                        Earnings.SetFilter("Calculation Method", '%1|%2', Earnings."Calculation Method"::"% of Basic pay",
                                              Earnings."Calculation Method"::"% of Insurance Amount");
                        if not Earnings.IsEmpty() then begin
                            AssignmentMatrixX.Validate(Code);
                            AssignmentMatrixX.Modify();
                        end;
                    until AssignmentMatrixX.Next() = 0;
            end;
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    var
        TooLongErr: Label '%1 results in a written number that is too long.', Comment = '%1 = AddText';
    begin
        PrintExponent := true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(TooLongErr, AddText);
        end;
        NoText[NoTextIndex] := CopyStr((DelChr(NoText[NoTextIndex] + ' ' + AddText, '<')), 1, 80);
    end;

    local procedure GetGrossPayableAccount(EmpCode: Code[50]): Code[20]
    var
        Employee: Record Employee;
        PostingGroup: Record "Employee HR Posting Group";
    begin
        if Employee.Get(EmpCode) then begin
            Employee.TestField("Posting Group");
            if PostingGroup.Get(Employee."Posting Group") then begin
                PostingGroup.TestField("Salary Account");
                exit(PostingGroup."Salary Account");
            end else
                Error('Posting group %1 not set up under Emp Posting Groups', Employee."Posting Group");
        end;
    end;

    local procedure GetLoanProductName(LoanType: Code[50]): Text
    var
        LoanProductType: Record "Loan Product Type-Payroll";
    begin
        if LoanProductType.Get(LoanType) then
            exit(LoanProductType.Description);
    end;

    local procedure GetNetPayableAccount(PayType: Enum "Payroll Transaction Type"; AssgnCode: Code[50]; var AccType: Enum "Gen. Journal Account Type"; var AccNo: Code[20]): Code[50]
    var
        Deductions: Record Deductions;
        Earnings: Record Earnings;
    begin
        case PayType of
            PayType::Earning:

                if Earnings.Get(AssgnCode) then begin
                    Earnings.TestField("Account No.");
                    AccType := Earnings."Account Type";
                    AccNo := Earnings."Account No.";
                end;
            PayType::Deduction:

                if Deductions.Get(AssgnCode) then begin
                    Deductions.TestField("Account No.");
                    AccType := Deductions."Account Type";
                    AccNo := Deductions."Account No.";
                end;
        end;
    end;

    local procedure GetNextLoanEntryNo() LoanLedgEntryNo: Integer;
    var
        LoanLedgerEntry: Record "Loan Ledger Entry-Payroll";
    begin
        LoanLedgerEntry.LockTable();

        if LoanLedgerEntry.FindLast() then
            LoanLedgEntryNo := LoanLedgerEntry."Entry No." + 1
        else
            LoanLedgEntryNo := 1;
    end;

    procedure CheckIfPayrollPeriodUnderApproval(PayPeriod: Date)
    var
        HRSetup: Record "Human Resources Setup";
        PayrollApproval: Record "Payroll Approval";
        PayrollApprovalErr: Label 'Payroll Period %1 is already undergoing approval and hence cannot be calculated again', Comment = '%1 = Pay Period';
    begin
        HRSetup.Get();

        if HRSetup."Prevent PayrollRun on Approval" then begin
            PayrollApproval.Reset();
            PayrollApproval.SetRange("Payroll Period", PayPeriod);
            if PayrollApproval.FindFirst() then
                if PayrollApproval.Status in [PayrollApproval.Status::"Pending Approval",
                                            PayrollApproval.Status::Approved] then
                    Error(PayrollApprovalErr, PayPeriod);
        end;
    end;

    procedure GeneratePayrollEFT(PayPeriod: Date): Boolean
    var
        EmployeeRec: Record Employee;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        XlsxInStream: InStream;
        DialogTitleTok: Label 'Generate EFT as Xlsx';
        FileNameTok: Label 'Pay_%1_%2.xlsx', Comment = '%1 = Pay Period. %2 = Current Date', Locked = true;
        XlsxFilterTok: Label 'Xlsx Files (*.xlsx)|*.xlsx';
        XlsxOutStream: OutStream;
        FileName: Text;
    begin
        CreateEFTHeader(TempExcelBuffer);

        EmployeeRec.Reset();
        EmployeeRec.SetFilter("Employee Type", '<>%1', EmployeeRec."Employee Type"::"Board Member");
        EmployeeRec.SetRange(Status, EmployeeRec.Status::Active);
        if EmployeeRec.Findset() then
            repeat
                EmployeeRec.SetRange("Pay Period Filter", PayPeriod);
                EmployeeRec.CalcFields("Net Pay");
                if EmployeeRec."Net Pay" <> 0 then begin
                    EmployeeRec.TestField("Employee's Bank");
                    EmployeeRec.TestField("Bank Branch");
                    EmployeeRec.TestField("Bank Account Number");
                    CreateEFTLine(EmployeeRec, TempExcelBuffer, PayPeriod);
                end;
            until EmployeeRec.Next() = 0;

        TempExcelBuffer.CreateNewBook(CopyStr(EmployeeRec.TableCaption(), 1, 250));
        TempExcelBuffer.WriteSheet(EmployeeRec.TableCaption(), CompanyName(), UserId());
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(XlsxOutStream, TextEncoding::UTF8);
        TempExcelBuffer.SaveToStream(XlsxOutStream, true);
        TempBlob.CreateInStream(XlsxInStream, TextEncoding::UTF8);

        FileName := StrSubstNo(FileNameTok, Format(PayPeriod, 0, '<Month,2><Year4>'), CurrentDateTime());
        exit(File.DownloadFromStream(XlsxInStream, DialogTitleTok, '', XlsxFilterTok, FileName));
    end;

    local procedure CreateEFTHeader(var TempExcelBuffer: Record "Excel Buffer")
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('Ref_No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Account_No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bank_Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('RTGS(Y/N)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Address 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Address 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 3', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 4', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateEFTLine(Employee: Record Employee; var TempExcelBuffer: Record "Excel Buffer"; PayPeriod: Date)
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Employee.FullName(), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Employee."Net Pay", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Employee."Bank Account Number", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StrSubstNo(Employee."Employee's Bank" + Employee."Bank Branch"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Y', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Employee.Address, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Employee."Address 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn((Format(PayPeriod, 0, '<Month Text><Year4>') + ' Salary'), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure PostAllowances(AllowanceRegister: Record "Allowance Register"; PreviewJournal: Boolean)
    var
        AllowanceRegisterLine: Record "Allowance Register Line";
        Deductions: Record Deductions;
        Earnings: Record Earnings;
        Employee: Record Employee;
        GLEntry: Record "G/L Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        HRSetup: Record "Human Resources Setup";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNo: Integer;
    begin
        AllowanceRegister.TestField(Status, AllowanceRegister.Status::Approved);

        HRSetup.Get();
        HRSetup.TestField("Payroll Journal Template");

        Deductions.SetRange("PAYE Code", true);
        if not Deductions.FindFirst() then
            Error('Please define PAYE Code')
        else
            Deductions.TestField("Account No.");

        GenJournalLine.Setrange("Journal Template Name", HRSetup."Payroll Journal Template");
        GenJournalLine.Setrange("Journal Batch Name", AllowanceRegister."No.");
        GenJournalLine.DeleteAll();

        GenJournalBatch.Init();
        GenJournalBatch."Journal Template Name" := CopyStr(HRSetup."Payroll Journal Template", 1, MaxStrLen(GenJournalBatch."Journal Template Name"));
        GenJournalBatch.Name := CopyStr(AllowanceRegister."No.", 1, MaxStrLen(GenJournalBatch.Name));
        if not GenJournalBatch.Get(HRSetup."Payroll Journal Template", AllowanceRegister."No.") then
            GenJournalBatch.Insert();

        AllowanceRegisterLine.Reset();
        AllowanceRegisterLine.SetRange("Document No.", AllowanceRegister."No.");
        if AllowanceRegisterLine.FindSet() then begin
            repeat
                Employee.Get(AllowanceRegisterLine."Employee No.");

                Earnings.Get(AllowanceRegisterLine."Earning Code");
                //Earnings.TestField("Account No.");

                //Gross Amount
                LineNo := LineNo + 10000;
                GenJournalLine.Init();
                GenJournalLine."Journal Template Name" := CopyStr(HRSetup."Payroll Journal Template", 1, MaxStrLen(GenJournalLine."Journal Template Name"));
                GenJournalLine."Journal Batch Name" := CopyStr(AllowanceRegister."No.", 1, MaxStrLen(GenJournalLine."Journal Batch Name"));
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := AllowanceRegister."No.";
                GenJournalLine."Posting Date" := Today();
                GenJournalLine.Validate("Account Type", AllowanceRegisterLine."Account Type");
                GenJournalLine.Validate("Account No.", AllowanceRegisterLine."Account No.");
                GenJournalLine.Validate(Description, CopyStr((Employee."No." + ' ' + AllowanceRegisterLine.Remarks + ' ' + AllowanceRegisterLine."Earning Description" + '-' + format(AllowanceRegisterLine."Date of Activity")), 1, 100));
                GenJournalLine.Validate(Amount, AllowanceRegisterLine.Amount);
                GenJournalLine.Validate("Shortcut Dimension 1 Code", Employee."Global Dimension 1 Code");
                GenJournalLine.Validate("Shortcut Dimension 2 Code", Employee."Global Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert();

                //Net Amount
                LineNo := LineNo + 10000;
                GenJournalLine.Init();
                GenJournalLine."Journal Template Name" := CopyStr(HRSetup."Payroll Journal Template", 1, MaxStrLen(GenJournalLine."Journal Template Name"));
                GenJournalLine."Journal Batch Name" := CopyStr(AllowanceRegister."No.", 1, MaxStrLen(GenJournalLine."Journal Batch Name"));
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := AllowanceRegister."No.";
                GenJournalLine."Posting Date" := Today();
                GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::Vendor);
                GenJournalLine.Validate("Account No.", AllowanceRegisterLine."Account No.");
                GenJournalLine.Validate(Description, CopyStr((AllowanceRegisterLine.Remarks + ' ' + AllowanceRegisterLine."Earning Description" + '-' + format(AllowanceRegisterLine."Date of Activity")), 1, 100));
                GenJournalLine.Validate(Amount, -AllowanceRegisterLine."Net Amount");
                GenJournalLine.Validate("Shortcut Dimension 1 Code", Employee."Global Dimension 1 Code");
                GenJournalLine.Validate("Shortcut Dimension 2 Code", Employee."Global Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert();

                //PAYE Amount
                LineNo := LineNo + 10000;
                GenJournalLine.Init();
                GenJournalLine."Journal Template Name" := CopyStr(HRSetup."Payroll Journal Template", 1, MaxStrLen(GenJournalLine."Journal Template Name"));
                GenJournalLine."Journal Batch Name" := CopyStr(AllowanceRegister."No.", 1, MaxStrLen(GenJournalLine."Journal Batch Name"));
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := AllowanceRegister."No.";
                GenJournalLine."Posting Date" := Today();
                GenJournalLine.Validate("Account Type", Deductions."Account Type");
                GenJournalLine.Validate("Account No.", Deductions."Account No.");
                GenJournalLine.Validate(Description, CopyStr((Employee."No." + ' ' + AllowanceRegisterLine.Remarks + ' ' + Deductions.Description + ' for ' + AllowanceRegisterLine."Earning Description" + '-' + format(AllowanceRegisterLine."Date of Activity")), 1, 100));
                GenJournalLine.Validate(Amount, -AllowanceRegisterLine."PAYE Amount");
                GenJournalLine.Validate("Shortcut Dimension 1 Code", Employee."Global Dimension 1 Code");
                GenJournalLine.Validate("Shortcut Dimension 2 Code", Employee."Global Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert();

            until AllowanceRegisterLine.Next() = 0;

            GenJournalLine.Setrange("Journal Template Name", HRSetup."Payroll Journal Template");
            GenJournalLine.Setrange("Journal Batch Name", AllowanceRegister."No.");
            if PreviewJournal then begin
                Commit();
                GenJnlPost.Preview(GenJournalLine);
            end else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", AllowanceRegister."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                AllowanceRegister.Validate(Status, AllowanceRegister.Status::Posted);
                AllowanceRegister.Validate("Posted By", UserId());
                AllowanceRegister.Validate("Date Posted", Today());
                AllowanceRegister.Modify();

                AllowanceRegisterLine.Reset();
                AllowanceRegisterLine.SetRange("Document No.", AllowanceRegister."No.");
                if AllowanceRegisterLine.FindSet() then
                    repeat
                        AllowanceRegisterLine.Validate(Posted, true);
                    until AllowanceRegisterLine.Next() = 0;
            end;
        end;
    end;

    procedure GetPayrollAmount(EmpCode: Code[20]; EarnDedCode: Code[50]; Type: Enum "Payroll Transaction Type") Amount: Decimal
    var
        AssgnMatrix: Record "Assignment Matrix";
        Deductions: Record Deductions;
        Earnings: Record Earnings;
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        OtherEarnings: Record "Other Earnings";
        Formula: Code[250];
        PayrollPeriod: Date;
        TotalOtherEarnings: Decimal;
    begin
        Employee.Get(EmpCode);
        PayrollPeriod := GetCurrentPayPeriodDate();

        case Type of
            Type::Earning:
                begin
                    Earnings.Get(EarnDedCode);

                    case Earnings."Calculation Method" of
                        Earnings."Calculation Method"::"Flat amount":
                            Amount := Earnings."Flat Amount";

                        // % Of Basic Pay
                        Earnings."Calculation Method"::"% of Basic pay":
                            begin
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                Employee.CalcFields("Basic Pay", "Basic Arrears");
                                Earnings.TestField(Percentage);
                                Amount := Earnings.Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");
                                Amount := PayrollRounding(Amount);
                            end;

                        // % Of Basic after Tax
                        Earnings."Calculation Method"::"% of Basic after tax":

                            if HRSetup."Company overtime hours" <> 0 then
                                Amount := PayrollRounding(Amount);

                        // Based on Hourly Rate
                        Earnings."Calculation Method"::"Based on Hourly Rate":
                            ;
                        /*
Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
if Payments."Overtime Factor"<>0 then
Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
Amount:=PayrollRounding(Amount);
*/

                        // Based on Daily Rate
                        Earnings."Calculation Method"::"Based on Daily Rate":
                            ;
                        /*
Amount:=Employee."Driving Licence"*Employee."days worked";
Amount:=PayrollRounding(Amount);
*/

                        // % Of Insurance Amount
                        Earnings."Calculation Method"::"% of Insurance Amount":
                            begin
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                Employee.CalcFields("Insurance Premium");
                                Amount := Abs((Earnings.Percentage / 100) * (Employee."Insurance Premium"));
                                Amount := PayrollRounding(Amount);
                            end;

                        // % F Gross Pay
                        Earnings."Calculation Method"::"% of Gross pay":
                            begin
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                Employee.CalcFields("Basic Pay", "Total Allowances");
                                Amount := ((Earnings.Percentage / 100) * (Employee."Total Allowances"));
                                Amount := PayrollRounding(Amount);
                            end;

                        // % of Taxable Income
                        Earnings."Calculation Method"::"% of Taxable income":
                            begin
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                Employee.CalcFields("Taxable Allowance");
                                Amount := ((Earnings.Percentage / 100) * (Employee."Taxable Allowance"));
                                Amount := PayrollRounding(Amount);
                            end;

                        //Formula
                        Earnings."Calculation Method"::Formula:
                            begin
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                Formula := GetPureFormula(EmpCode, PayrollPeriod, Earnings.Formula);
                                Amount := GetResult(Formula);
                            end;

                        //% of Other Earnings
                        Earnings."Calculation Method"::"% of Other Earnings":
                            begin
                                TotalOtherEarnings := 0;
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                OtherEarnings.Reset();
                                OtherEarnings.SetRange("Main Earning", Earnings.Code);
                                if OtherEarnings.FindSet() then
                                    repeat
                                        AssgnMatrix.Reset();
                                        AssgnMatrix.SetRange(AssgnMatrix.Code, OtherEarnings."Earning Code");
                                        AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", PayrollPeriod);
                                        AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Earning);
                                        AssgnMatrix.SetRange(AssgnMatrix."Employee No", EmpCode);
                                        if AssgnMatrix.FindFirst() then
                                            TotalOtherEarnings += Abs(AssgnMatrix.Amount);
                                    until OtherEarnings.Next() = 0;
                                Earnings.TestField(Percentage);
                                Amount := ((TotalOtherEarnings / 100) * Earnings.Percentage);
                                Amount := PayrollRounding(Amount);
                            end;

                        //% of Annual Basic
                        Earnings."Calculation Method"::"% of Annual Basic":
                            begin
                                Employee.SetRange("Pay Period Filter", PayrollPeriod);
                                Employee.CalcFields("Basic Pay");
                                Amount := ((Earnings.Percentage / 100) * (Employee."Basic Pay" * 12));
                                Amount := PayrollRounding(Amount);
                            end

                        else
                            if Earnings."Leave Allowance" = true then begin
                                if Employee.Get(EmpCode) then
                                    if Employee."Employment Type" = Employee."Employment Type"::Permanent then
                                        Amount := ((Employee."Basic Pay" * 12) * (Earnings.Percentage / 100))
                                    else
                                        if Employee."Employment Type" = Employee."Employment Type"::Contract then
                                            Amount := ((Employee."Basic Pay" * GetMonthWorked(EmpCode)) * (Earnings.Percentage / 100));
                            end;
                    end;
                end;

            Type::Deduction:

                Deductions.Get(EarnDedCode);
        end;

        exit(Amount);
    end;

    procedure GetActingAllowance(ActingRec: Record "Employee Acting Position"; var DiffAmt: Decimal; var StepsAmt: Decimal) Amount: Decimal
    var
        Earnings: Record Earnings;
        Employee, RelievedEmployee : Record Employee;
        SalaryPointer, SalaryPointerCopy : Record "Salary Pointer";
        ScaleBenefits: Record "Scale Benefits";
        ActingAmount: Array[2] of Decimal;
    begin
        Clear(ActingAmount);

        Employee.Get(ActingRec."Acting Employee No.");
        RelievedEmployee.Get(ActingRec."Relieved Employee");

        Earnings.SetRange("Basic Salary Code", true);
        Earnings.FindFirst();

        Employee.TestField("Salary Scale");
        Employee.TestField("Present Pointer");

        RelievedEmployee.TestField("Salary Scale");
        RelievedEmployee.TestField("Present Pointer");

        ActingRec.CalcFields("Current Benefits");
        ActingRec.CalcFields("New Benefits");

        ActingAmount[1] := (ActingRec."New Benefits" - ActingRec."Current Benefits") / 2;

        SalaryPointer.Reset();
        SalaryPointer.SetRange("Salary Scale", Employee."Salary Scale");
        SalaryPointer.SetRange("Salary Pointer", Employee."Present Pointer");
        if SalaryPointer.FindFirst() then begin
            SalaryPointerCopy.Copy(SalaryPointer);
            SalaryPointerCopy.Next(2);

            if ScaleBenefits.Get(SalaryPointerCopy."Salary Scale", SalaryPointerCopy."Salary Scale", Earnings.Code) then
                ActingAmount[2] := ScaleBenefits.Amount;
        end;

        DiffAmt := ActingAmount[1];
        StepsAmt := ActingAmount[2];

        if ActingAmount[1] > ActingAmount[2] then
            Amount := ActingAmount[1]
        else
            Amount := ActingAmount[2];

        exit(Amount);
    end;

    procedure InsertAllEmployeesOnAllowanceRegister(AllowanceRegister: Record "Allowance Register")
    var
        AllowanceRegisterLines: Record "Allowance Register Line";
        Employee: Record Employee;
    begin
        case AllowanceRegister."Employee Type" of
            AllowanceRegister."Employee Type"::Staff:
                begin
                    Employee.Reset();
                    Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
                    Employee.SetRange(Status, Employee.Status::Active);
                    If Employee.FindSet() then
                        repeat
                            AllowanceRegisterLines.Init();
                            AllowanceRegisterLines."Document No." := AllowanceRegister."No.";
                            AllowanceRegisterLines."Employee Type" := AllowanceRegister."Employee Type";
                            AllowanceRegisterLines.Validate("Employee No.", Employee."No.");
                            AllowanceRegisterLines.Validate("Earning Code", AllowanceRegister."Earning Code");
                            AllowanceRegisterLines.Validate("Date of Activity", AllowanceRegister."Date of Activity");
                            AllowanceRegisterLines.Validate(Remarks, AllowanceRegister.Description);
                            AllowanceRegisterLines.Insert();
                        until Employee.Next() = 0;
                end;
            AllowanceRegister."Employee Type"::"Board Member":
                begin
                    Employee.Reset();
                    Employee.SetRange("Employee Type", Employee."Employee Type"::"Board Member");
                    Employee.SetRange(Status, Employee.Status::Active);
                    If Employee.FindSet() then
                        repeat
                            AllowanceRegisterLines.Init();
                            AllowanceRegisterLines."Document No." := AllowanceRegister."No.";
                            AllowanceRegisterLines."Employee Type" := AllowanceRegister."Employee Type";
                            AllowanceRegisterLines.Validate("Employee No.", Employee."No.");
                            AllowanceRegisterLines.Insert();
                        until Employee.Next() = 0;
                end;
        end;
    end;

    procedure DefaultEarningsDeductionsAssignment(EmployeeRec: Record Employee)
    var
        AssMatrix: Record "Assignment Matrix";
        Ded: Record Deductions;
        ScaleBenefits: Record "Scale Benefits";
        Begindate: Date;
        PayAmount: Decimal;
        PreviousPeriodAmount: Decimal;
        AssignPointerErr: Label 'Please select the present salary pointer or assign a pointer with scale benefits defined for employee %1 %2';
        NoOpenPayPeriodErr: Label 'There''s no open pay period open';
    begin
        //if Confirm(Text001, false, "No.", "First Name" + ' ' + "Middle Name" + ' ' + "Last Name") then begin
        //Insert Earnings Based on the Salary Scales
        PreviousPeriodAmount := 0;
        PayAmount := 0;
        Begindate := GetCurrentPayPeriodDate();

        if Begindate <> 0D then begin
            EmployeeRec.Testfield("Salary Scale");
            EmployeeRec.Testfield("Present Pointer");

            ScaleBenefits.Reset();
            ScaleBenefits.SetRange("Salary Scale", EmployeeRec."Salary Scale");
            ScaleBenefits.SetRange("Salary Pointer", EmployeeRec."Present Pointer");
            if ScaleBenefits.FindSet() then
                repeat
                    AssMatrix.Init();
                    AssMatrix."Employee No" := EmployeeRec."No.";
                    AssMatrix.Type := AssMatrix.Type::Earning;
                    AssMatrix."Payroll Period" := Begindate;
                    AssMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
                    AssMatrix.Code := ScaleBenefits."ED Code";
                    AssMatrix.Description := ScaleBenefits."ED Description";
                    AssMatrix.Validate(Code);

                    //Check if staff has a special amount not defined in the Scale benefits excluding Basic Pay
                    PreviousPeriodAmount := 0;
                    PayAmount := 0;
                    if not ScaleBenefits."Basic Salary Code" then begin
                        PreviousPeriodAmount := GetPreviousAmount(EmployeeRec."No.", ScaleBenefits."ED Code", Begindate);
                        if (PreviousPeriodAmount <> 0) and (PreviousPeriodAmount <> ScaleBenefits.Amount) then
                            PayAmount := PreviousPeriodAmount
                        else
                            PayAmount := ScaleBenefits.Amount;
                    end else
                        PayAmount := ScaleBenefits.Amount;

                    AssMatrix.Validate(Amount, PayAmount);

                    if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period", AssMatrix."Reference No") then
                        AssMatrix.Insert()
                    else begin
                        AssMatrix.Code := ScaleBenefits."ED Code";
                        AssMatrix.Validate(Code);
                        AssMatrix.Validate(Amount, PayAmount);
                        AssMatrix.Modify();
                    end;
                until ScaleBenefits.Next() = 0
            else
                Error(AssignPointerErr, EmployeeRec."No.", EmployeeRec.FullName());

            // Insert Deductions assigned to every employee
            Ded.Reset();
            Ded.SetRange("Applies to All", true);
            Ded.SetRange("Check Probation End Date", false);
            if Ded.FindSet() then
                repeat
                    AssMatrix.Init();
                    AssMatrix."Employee No" := EmployeeRec."No.";
                    AssMatrix.Type := AssMatrix.Type::Deduction;
                    AssMatrix."Payroll Period" := Begindate;
                    AssMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
                    AssMatrix.Code := Ded.Code;
                    AssMatrix.Validate(Code);
                    if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period", AssMatrix."Reference No") then
                        AssMatrix.Insert()
                    else begin
                        AssMatrix.Code := Ded.Code;
                        AssMatrix.Validate(Code);
                        AssMatrix.Modify();
                    end;
                until Ded.Next() = 0;

            // Insert to confirmed employees only
            Ded.Reset();
            Ded.SetRange("Applies to All", true);
            Ded.SetRange("Check Probation End Date", true);
            if Ded.FindSet() then
                repeat
                    if EmployeeRec."End Of Probation Date" <= Today() then begin
                        AssMatrix.Init();
                        AssMatrix."Employee No" := EmployeeRec."No.";
                        AssMatrix.Type := AssMatrix.Type::Deduction;
                        AssMatrix."Payroll Period" := Begindate;
                        AssMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
                        AssMatrix.Code := Ded.Code;
                        AssMatrix.Validate(Code);
                        if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period", AssMatrix."Reference No") then
                            AssMatrix.Insert()
                        else begin
                            AssMatrix.Code := Ded.Code;
                            AssMatrix.Validate(Code);
                            AssMatrix.Modify();
                        end;
                    end;
                until Ded.Next() = 0;
        end else
            Error(NoOpenPayPeriodErr);
    end;

    procedure DisburseSalaryAdvance(PaymentReq: Record "Payroll Requests")
    var
        Deductions: Record Deductions;
        Employees: Record Employee;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        LoanBatch: Code[50];
        LoanTemplate: Code[50];
        FosaAcc: Code[250];
        LineNo: Integer;
    begin
        if Employees.Get(PaymentReq."Employee No.") then
            Employees.TestField("Vendor No.");

        Deductions.Get(PaymentReq.Code);
        Deductions.TestField("Account No.");

        FosaAcc := Employees."Vendor No.";

        LoanTemplate := 'GENERAL';
        LoanBatch := PaymentReq."No.";

        //Delete Exixting Lines
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", LoanTemplate);
        GenJournalLine.SetRange("Journal Batch Name", LoanBatch);
        GenJournalLine.DeleteAll();

        //Initialise Batch
        GenJournalBatch.Init();
        GenJournalBatch."Journal Template Name" := LoanTemplate;
        GenJournalBatch.Name := LoanBatch;
        if not GenJournalBatch.Get(GenJournalBatch."Journal Template Name", GenJournalBatch.Name) then
            GenJournalBatch.Insert();


        //Credit Fosa Account
        LineNo := LineNo + 1000;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Journal Template Name" := LoanTemplate;
        GenJournalLine."Journal Batch Name" := LoanBatch;
        GenJournalLine."Document No." := PaymentReq."No.";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
        GenJournalLine.Validate("Account Type");
        GenJournalLine."Account No." := FosaAcc;
        GenJournalLine.Validate("Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Staff Advance' + FosaAcc;
        GenJournalLine.Amount := -PaymentReq.Amount;
        GenJournalLine.Validate(Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();


        //Debit ControlAccount
        LineNo := LineNo + 1000;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Journal Template Name" := LoanTemplate;
        GenJournalLine."Journal Batch Name" := LoanBatch;
        GenJournalLine."Document No." := PaymentReq."No.";
        GenJournalLine."Account Type" := Deductions."Account Type";
        GenJournalLine.Validate("Account Type");
        GenJournalLine."Account No." := Deductions."Account No.";
        GenJournalLine.Validate("Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'StaffAdvance' + PaymentReq."No.";
        GenJournalLine.Amount := PaymentReq.Amount;
        GenJournalLine.Validate(Amount);
        GenJournalLine."Payroll Loan No." := PaymentReq."No.";
        GenJournalLine."Payroll Loan Transaction Type" := GenJournalLine."Payroll Loan Transaction Type"::"Principal Due";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();

        //Post Entries
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", LoanTemplate);
        GenJournalLine.SetRange("Journal Batch Name", LoanBatch);
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

        PaymentReq."Advance Disbursed" := true;
        PaymentReq."Advance Disbursed At" := CurrentDateTime();
        PaymentReq."Advance Disbursed By" := UserId();
        PaymentReq.Modify();
    end;

    procedure GetNextSalaryScale(Employee: Record Employee; var NextScale: Code[20]; var NextPointer: Code[20])
    var
        SalaryPointer: Record "Salary Pointer";
        SalaryScale: Record "Salary Scale";
        MaxPointerMsg: Label 'Employee No. %1 - %2 is on the maximum allowable step for their job group. Please assign a new step manually and adjust their next increment date to be the following year';
    begin
        NextScale := '';
        NextPointer := '';

        Employee.TestField("Salary Scale");
        Employee.TestField("Present Pointer");
        Employee.TestField("Date Of Join");

        if SalaryScale.Get(Employee."Salary Scale") then begin
            SalaryScale.TestField("Minimum Pointer");
            SalaryScale.TestField("Maximum Pointer");

            //Check if employee max pointer achieved
            if Employee."Present Pointer" = SalaryScale."Maximum Pointer" then begin
                if GuiAllowed then
                    Message(MaxPointerMsg, Employee."No.", Employee.FullName());

                /*SalaryScale.Next(-1);
                NextScale := SalaryScale.Scale;
                NextPointer := SalaryScale."Minimum Pointer";*/
            end else
                if SalaryPointer.Get(Employee."Salary Scale", Employee."Present Pointer") then begin
                    SalaryPointer.Next();
                    NextScale := SalaryPointer."Salary Scale";
                    NextPointer := SalaryPointer."Salary Pointer";
                end;
        end;
    end;

    procedure UpdateSalaryIncrementDetails(Employee: Record Employee; PayPeriod: Date)
    var
        SalaryPointerIncrement: Record "Salary Pointer Increment";
    begin
        if not SalaryPointerIncrement.Get(Employee."No.", PayPeriod) then begin
            SalaryPointerIncrement."Employee No." := Employee."No.";
            SalaryPointerIncrement."Payroll Period" := PayPeriod;
            SalaryPointerIncrement.Validate("Increment Date", Employee."Last Increment Date");
            SalaryPointerIncrement."Previous Scale" := Employee."Previous Salary Scale";
            SalaryPointerIncrement."Previous Pointer" := Employee.Previous;
            SalaryPointerIncrement."Present Scale" := Employee."Salary Scale";
            SalaryPointerIncrement."Present Pointer" := Employee."Present Pointer";
            SalaryPointerIncrement."Processed By" := UserId();
            SalaryPointerIncrement.Insert();
        end;
    end;

    procedure CheckIfIncrementEffectedInCurrentYear(Employee: Record Employee; CurrentYear: Integer): Boolean
    var
        SalaryPointerIncrement: Record "Salary Pointer Increment";
    begin
        SalaryPointerIncrement.Reset();
        SalaryPointerIncrement.SetRange("Employee No.", Employee."No.");
        SalaryPointerIncrement.SetRange("Increment Year", CurrentYear);
        exit(SalaryPointerIncrement.FindFirst());
    end;

    local procedure GetPreviousAmount(EmpCode: Code[20]; PayCode: Code[20]; CurrentPeriod: Date): Decimal
    var
        AssignmentMatrix: Record "Assignment Matrix";
    begin
        AssignmentMatrix.Reset();
        AssignmentMatrix.SetRange("Employee No", EmpCode);
        AssignmentMatrix.SetFilter("Payroll Period", '<>%1', CurrentPeriod);
        AssignmentMatrix.SetRange(Code, PayCode);
        if AssignmentMatrix.FindLast() then
            exit(AssignmentMatrix.Amount);

        exit(0);
    end;

    procedure CheckIfPayrollApproved(PayPeriod: Date): Boolean
    var
        PayrollApproval: Record "Payroll Approval";
    begin
        PayrollApproval.Reset();
        PayrollApproval.SetRange("Payroll Period", PayPeriod);
        if PayrollApproval.FindFirst() then begin
            if PayrollApproval.Status in [PayrollApproval.Status::Approved] then
                exit(true)
            else
                exit(false);
        end else
            exit(false);
    end;
}


