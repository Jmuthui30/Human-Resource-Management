report 52076 "P9A Report-Trustees"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/P9AReportTrustees.rdl';
    UseRequestPage = true;
    Caption = 'P9A Report-Trustees';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where("Employee Type" = filter("Board Member"));
            RequestFilterFields = "Secondary Employee";

            column(First_Name________Middle_Name_; "First Name" + ' ' + "Middle Name")
            {
            }
            column(Employee__Last_Name_; "Last Name")
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(V30__; '30%')
            {
            }
            column(Actual_; 'Actual')
            {
            }
            column(Fixed_; 'Fixed')
            {
            }
            column(Employee__PIN_Number_; Employee."PIN Number")
            {
            }
            column(FORMAT_StringDate_0___year4___; Format(StringDate, 0, '<year4>'))
            {
            }
            column(CoPin; CoPin)
            {
            }
            column(Employee_Employee__No__; Employee."No.")
            {
            }
            column(Employers_Name_Caption; Employers_Name_CaptionLbl)
            {
            }
            column(Employee_s_Main_Name_Caption; Employee_s_Main_Name_CaptionLbl)
            {
            }
            column(Employee_s_Other_Names_Caption; Employee_s_Other_Names_CaptionLbl)
            {
            }
            column(Employers_PIN_Caption; Employers_PIN_CaptionLbl)
            {
            }
            column(Employee_s_PIN_Caption; Employee_s_PIN_CaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(Gross_SalaryCaption; Gross_SalaryCaptionLbl)
            {
            }
            column(BenefitsCaption; BenefitsCaptionLbl)
            {
            }
            column(QuartersCaption; QuartersCaptionLbl)
            {
            }
            column(Total_A_B_CCaption; Total_A_B_CCaptionLbl)
            {
            }
            column(Defined_Contribution_Retr__SchemeCaption; Defined_Contribution_Retr__SchemeCaptionLbl)
            {
            }
            column(Taxable_AmountCaption; Taxable_AmountCaptionLbl)
            {
            }
            column(Personal_ReliefCaption; Personal_ReliefCaptionLbl)
            {
            }
            column(P_A_Y_E_TAXCaption; P_A_Y_E_TAXCaptionLbl)
            {
            }
            column(KENYA_REVENUE_AUTHORITYCaption; KENYA_REVENUE_AUTHORITYCaptionLbl)
            {
            }
            column(INCOME_TAX_DEPARTMENTCaption; INCOME_TAX_DEPARTMENTCaptionLbl)
            {
            }
            column(INCOME_TAX_DEDUCTION_CARD_YEAR_Caption; INCOME_TAX_DEDUCTION_CARD_YEAR_CaptionLbl)
            {
            }
            column(Tax_ChargedCaption; Tax_ChargedCaptionLbl)
            {
            }
            column(Owner_OccupiedCaption; Owner_OccupiedCaptionLbl)
            {
            }
            column(Retr__Contribution__Caption; Retr__Contribution__CaptionLbl)
            {
            }
            column(ACaption; ACaptionLbl)
            {
            }
            column(BCaption; BCaptionLbl)
            {
            }
            column(CCaption; CCaptionLbl)
            {
            }
            column(DCaption; DCaptionLbl)
            {
            }
            column(F__Standard_Amount_Caption; F__Standard_Amount_CaptionLbl)
            {
            }
            column(G___Lowest_of_E_F_Caption; G___Lowest_of_E_F_CaptionLbl)
            {
            }
            column(HCaption; HCaptionLbl)
            {
            }
            column(JCaption; JCaptionLbl)
            {
            }
            column(KCaption; KCaptionLbl)
            {
            }
            column(LCaption; LCaptionLbl)
            {
            }
            column(MCaption; MCaptionLbl)
            {
            }
            column(ECaption; ECaptionLbl)
            {
            }
            column(InterestCaption; InterestCaptionLbl)
            {
            }
            column(Column_D_GCaption; Column_D_GCaptionLbl)
            {
            }
            column(Occupied_InterestCaption; Occupied_InterestCaptionLbl)
            {
            }
            column(Non_CashCaption; Non_CashCaptionLbl)
            {
            }
            column(Value_OfCaption; Value_OfCaptionLbl)
            {
            }
            column(Personal_File_No_Caption; Personal_File_No_CaptionLbl)
            {
            }
            column(Insurance_ReliefCaption; Insurance_ReliefCaptionLbl)
            {
            }
            dataitem("Payroll Period Trustees"; "Payroll Period Trustees")
            {
                DataItemTableView = sorting("Starting Date") order(ascending);

                column(StartingDate_PayrollPeriodTrustees; "Starting Date")
                {
                }
                column(Payroll_PeriodX_Name; Name)
                {
                }
                column(BenefitsVar; BenefitsVar)
                {
                }
                column(QuartersVar; QuartersVar)
                {
                }
                column(Employee__Taxable_Allowance__Employee__Basic_Pay__BenefitsVar_QuartersVar; Employee."Taxable Allowance" + BenefitsVar + QuartersVar)
                {
                }
                column(RetirementVar; RetirementVar)
                {
                }
                column(TaxableAmount; TaxableAmount - Abs(DefinedContrMin) - Abs(OccupierVar))
                {
                }
                column(Relief; Relief)
                {
                }
                column(InsuranceRelief; InsuranceRelief)
                {
                }
                column(ABS_Employee__Cumm__PAYE__; Abs(Employee."Cumm. PAYE"))
                {
                }
                column(PensionLimit; PensionLimit)
                {
                }
                column(Employee__Total_Allowances_; Employee."Total Allowances")
                {
                }
                column(ABS_Employee__Cumm__PAYE___Relief_InsuranceRelief; Abs(Employee."Cumm. PAYE") + Relief + InsuranceRelief)
                {
                }
                column(ABS_OccupierVar_; Abs(OccupierVar))
                {
                }
                column(V30PerPension_; "30PerPension")
                {
                }
                column(ABS_DefinedContrMin__ABS_OccupierVar_; Abs(DefinedContrMin) + Abs(OccupierVar))
                {
                }
                column(TotBasic; TotBasic)
                {
                }
                column(TotalBenefits; TotalBenefits)
                {
                }
                column(TotQuarter; TotQuarter)
                {
                }
                column(TotGross; TotGross)
                {
                }
                column(V30PerPension__Control188; "30PerPension")
                {
                }
                column(ABS_RetirementVar_; Abs(RetirementVar))
                {
                }
                column(TaxableAmount_Control196; TaxableAmount)
                {
                }
                column(ABS_Employee__Cumm__PAYE___Relief_InsuranceRelief_Control198; Abs(Employee."Cumm. PAYE") + Relief + InsuranceRelief)
                {
                }
                column(Relief_Control200; Relief)
                {
                }
                column(InsuranceRelief_Control202; InsuranceRelief)
                {
                }
                column(ABS_Employee__Cumm__PAYE___Control204; Abs(Employee."Cumm. PAYE"))
                {
                }
                column(OccupierVar; OccupierVar)
                {
                }
                column(TotRet; TotRet)
                {
                }
                column(ABS_Employee__Cumm__PAYE___Control164; Abs(Employee."Cumm. PAYE"))
                {
                }
                column(TaxableAmount_Control166; TaxableAmount)
                {
                }
                column(P9A_; 'P9A')
                {
                }
                column(PensionLimit_Control1000000000; PensionLimit)
                {
                }
                column(CERTIFICATE_OF_PAY_AND_TAXCaption; CERTIFICATE_OF_PAY_AND_TAXCaptionLbl)
                {
                }
                column(NAME; NAME)
                {
                }
                column(ADDRESS; ADDRESS)
                {
                }
                column(SIGNATURE; SIGNATURE)
                {
                }
                column(DATESTAMP; "DATESTAMP")
                {
                }
                column(NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTIONCaption; NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTIONCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(L_R__NO__OF_OWNER_OCCUPIED_HOUSE; L_R__NO__OF_OWNER_OCCUPIED_HOUSE)
                {
                }
                column(DATE_OF_OCCUPATION; DATE_OF_OCCUPATION)
                {
                }
                column(TOTALSCaption; TOTALSCaptionLbl)
                {
                }
                column(V1; V1)
                {
                }
                column(Name_and_address_of_old_employer; Name_and_address_of_old_employer)
                {
                }
                column(DataItem33; V2)
                {
                }
                column(Name_and_address_of_new_employer; Name_and_address_of_new_employer)
                {
                }
                column(V3; V3)
                {
                }
                column(DataItem37; V4)
                {
                }
                column(YearCaption; YearCaptionLbl)
                {
                }
                column(Amount_Kenya_Pounds_Caption; Amount_Kenya_Pounds_CaptionLbl)
                {
                }
                column(Tax__Shs_Caption; Tax__Shs_CaptionLbl)
                {
                }
                column(Reference_No; Reference_No)
                {
                }
                column(TOTAL_TAX__COL_M__KshsCaption; TOTAL_TAX__COL_M__KshsCaptionLbl)
                {
                }
                column(TOTAL_CHARGEABLE_PAY__COL_H__KshsCaption; TOTAL_CHARGEABLE_PAY__COL_H__KshsCaptionLbl)
                {
                }
                column(Payroll_PeriodX_Starting_Date; "Starting Date")
                {
                }
                column(Payroll_PeriodX_P_A_Y_E; "P.A.Y.E")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TaxableAmount := 0;
                    "30PerPension" := 0;
                    PensionLimit := 0;
                    RetirementVar := 0;
                    OccupierVar := 0;
                    TaxableAmount := 0;
                    InsuranceRelief := 0;
                    Relief := 0;

                    if Employee."Pays tax?" then begin
                        Employee.SetRange("Pay Period Filter", "Starting Date");
                        Employee.CalcFields("Taxable Allowance", "Tax Deductible Amount", "Total Allowances", Employee."Cumm. PAYE", Employee."Cumm. Secondary  PAYE");
                        Employee.CalcFields(Employee."Taxable Allowance", "Tax Deductible Amount", Employee."Taxable Income");
                        Employee.CalcFields("Total Allowances", "Total Deductions", Employee."Retirement Contribution");
                        Employee.CalcFields("Total Savings");
                        Employee.CalcFields("Basic Pay", "Retirement Contribution", "Home Savings");
                        Employee.CalcFields("Benefits-Non Cash", "Owner Occupier");
                    end;

                    "30PerPension" := 30 / 100 * Employee."Basic Pay";
                    RetirementVar := Abs(Employee."Retirement Contribution");
                    if RetirementVar <> 0 then
                        PensionLimit := HRSetup."Pension Limit Amount";
                    TaxableAmount := Employee."Taxable Income";
                    // Get Owner Occupier
                    /*
                    Earn.Reset();
                    Earn.SetCurrentKey(Earn."Earning Type");
                    Earn.SetRange(Earn."Earning Type",Earn."Earning Type"::"Owner Occupier");
                    if Earn.Find('-') then begin
                      AssMatrix.Reset();
                      AssMatrix.SetRange(AssMatrix.Type,AssMatrix.Type::Payment);
                      AssMatrix.SetRange(AssMatrix."Employee No",Employee."No.");
                      AssMatrix.SetRange(AssMatrix."Payroll Period","Starting Date");
                      AssMatrix.SetRange(Code,Earn.Code);
                      if AssMatrix.Find('-') then
                       OccupierVar:=AssMatrix.Amount;
                    end;
                    */
                    //Owner occupier occupied interest
                    Ded.Reset();
                    //Ded.SETRANGE(Ded."Tax deductible",TRUE);
                    Ded.SetRange(Ded."Owner Occupied Interest", true);
                    if Ded.Find('-') then
                        repeat
                            AssMatrix.Reset();
                            AssMatrix.SetRange("Payroll Period", "Starting Date");
                            AssMatrix.SetRange(Type, AssMatrix.Type::Deduction);
                            AssMatrix.SetRange(Code, Ded.Code);
                            AssMatrix.SetRange("Employee No", Employee."No.");
                            if AssMatrix.Find('-') then
                                repeat
                                    OccupierVar := OccupierVar + Abs(AssMatrix.Amount);
                                until AssMatrix.Next() = 0;
                        until
                        Ded.Next() = 0;
                    if OccupierVar > 0 then
                        if HRSetup."Owner Occupied Interest Limit" < OccupierVar then
                            OccupierVar := HRSetup."Owner Occupied Interest Limit";
                    //End of owner occupied interest


                    // Get Personal Relief

                    Earn.Reset();
                    Earn.SetCurrentKey(Earn."Earning Type");
                    Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Tax Relief");
                    if Earn.Find('-') then begin
                        AssMatrix.Reset();
                        AssMatrix.SetRange(AssMatrix.Type, AssMatrix.Type::Earning);
                        AssMatrix.SetRange(AssMatrix."Employee No", Employee."No.");
                        AssMatrix.SetRange(AssMatrix."Payroll Period", "Starting Date");
                        AssMatrix.SetRange(Code, Earn.Code);
                        if AssMatrix.Find('-') then
                            Relief := AssMatrix.Amount;
                    end;

                    // Get Insurance Relief

                    Earn.Reset();
                    Earn.SetCurrentKey(Earn."Earning Type");
                    Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Insurance Relief");
                    if Earn.Find('-') then begin
                        AssMatrix.Reset();
                        AssMatrix.SetRange(AssMatrix.Type, AssMatrix.Type::Earning);
                        AssMatrix.SetRange(AssMatrix."Employee No", Employee."No.");
                        AssMatrix.SetRange(AssMatrix."Payroll Period", "Starting Date");
                        AssMatrix.SetRange(Code, Earn.Code);
                        if AssMatrix.Find('-') then
                            InsuranceRelief := AssMatrix.Amount;
                    end;

                    /*****Calculate the totals*******************************/
                    TotBasic := TotBasic + Employee."Total Allowances";
                    //TotNonQuarter:=TotQuarter+Employee."Total Allowances";
                    //TotQuarter:=TotQuarter+QuartersVar;
                    TotGross := TotGross + Employee."Basic Pay" + Employee."Taxable Allowance" + QuartersVar + BenefitsVar;
                    TotPercentage := TotPercentage + ((30 / 100) * (Employee."Basic Pay" + Employee."Total Allowances" +
                   QuartersVar
                      + BenefitsVar));
                    TotActual := TotActual + RetirementVar;
                    TotFixed := TotFixed + PensionLimit;
                    TotTaxable := TotTaxable + TaxableAmount;
                    TotTax := TotTax + IncomeTax;
                    TotRelief := TotRelief + Relief;
                    TotPAYE := TotPAYE + PAYE;
                    grandPAYE := grandPAYE + PAYE;
                    TotOcc := TotOcc + Abs(OccupierVar);
                    //TotRet:=TotRet+ABS(DefinedContrMin)+ABS(OccupierVar);
                    TaxablePound := TaxableAmount / 20;
                    TaxablePound := Round(TaxablePound, 1, '<');
                    TotPound := TotPound + TaxablePound;
                    TotalBenefits := TotalBenefits + BenefitsVar;
                    DefinedContrMin := RetirementVar;

                    if DefinedContrMin > PensionLimit
                      then
                        DefinedContrMin := PensionLimit;

                    NoOfMonths := NoOfMonths + 1;
                    TotRet := TotRet + Abs(DefinedContrMin) + Abs(OccupierVar);

                end;

                trigger OnPreDataItem()
                begin
                    "Payroll Period Trustees".SetRange("Payroll Period Trustees"."Starting Date", StringDate, EndDate);

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotBasic := 0;
                TotNonQuarter := 0;
                TotQuarter := 0;
                TotGross := 0;
                TotPercentage := 0;
                TotActual := 0;
                TotFixed := 0;
                TotTaxable := 0;
                TotTax := 0;
                TotRelief := 0;
                TotPAYE := 0;
                NoOfMonths := 0;
                TotalBenefits := 0;
                TotOcc := 0;
                TotRet := 0;
                TotPound := 0;
                grandPAYE := 0;
                //"Total Quarters":=0;
                CompanyRec.Get();
                HRSetup.Get();
                CoPin := CompanyRec."Company PIN No.";
            end;

            trigger OnPreDataItem()
            begin
                GetDefaults(StringDate, EndDate);

                if (StringDate = 0D) or (EndDate = 0D) then
                    Error('Please specify the correct period on the option of the request form');

                //Employee.SETFILTER("Home Ownership Status",'<>%1', Employee."Home Ownership Status"::"Home Savings");
                CUser := UserId;
                //GetGroup.GetUserGroup(CUser,GroupCode);
                //SETRANGE(Employee."Posting Group",GroupCode);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Period2)
                {
                    field("Start Date"; StringDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the StringDate field';
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the EndDate field';
                    }
                }
            }
        }

        actions
        {
        }
    }
    labels
    {
    }

    var
        AssMatrix: Record "Assignment Matrix";
        CompanyRec: Record "Company Information";
        Ded: Record Deductions;
        Earn: Record Earnings;
        HRSetup: Record "Human Resources Setup";
        TaxCode: Code[10];
        CUser: Code[50];
        EndDate: Date;
        StringDate: Date;
        "30PerPension": Decimal;
        AmountRemaining: Decimal;
        BenefitsVar: Decimal;
        DefinedContrMin: Decimal;
        grandPAYE: Decimal;
        IncomeTax: Decimal;
        InsuranceRelief: Decimal;
        OccupierVar: Decimal;
        PAYE: Decimal;
        PensionLimit: Decimal;
        QuartersVar: Decimal;
        Relief: Decimal;
        RetirementVar: Decimal;
        TaxableAmount: Decimal;
        TaxablePound: Decimal;
        TotActual: Decimal;
        TotalBenefits: Decimal;
        TotBasic: Decimal;
        TotFixed: Decimal;
        TotGross: Decimal;
        TotNonQuarter: Decimal;
        TotOcc: Decimal;
        TotPAYE: Decimal;
        TotPercentage: Decimal;
        TotPound: Decimal;
        TotQuarter: Decimal;
        TotRelief: Decimal;
        TotRet: Decimal;
        TotTax: Decimal;
        TotTaxable: Decimal;
        NoOfMonths: Integer;
        ACaptionLbl: Label 'A';
        ADDRESS: Label 'ADDRESS.....................................................................................................................................';
        Amount_Kenya_Pounds_CaptionLbl: Label 'Amount(Kenya Pounds)';
        BCaptionLbl: Label 'B';
        BenefitsCaptionLbl: Label 'Benefits';
        CCaptionLbl: Label 'C';
        CERTIFICATE_OF_PAY_AND_TAXCaptionLbl: Label 'CERTIFICATE OF PAY AND TAX';
        Column_D_GCaptionLbl: Label 'Column D-G';
        DATE_OF_OCCUPATION: Label 'DATE OF OCCUPATION ...................................................................................';
        DATESTAMP: Label 'DATE & STAMP   ......................................................................................................................';
        DCaptionLbl: Label 'D';
        Defined_Contribution_Retr__SchemeCaptionLbl: Label 'Defined Contribution Retr. Scheme';
        ECaptionLbl: Label 'E';
        Employee_s_Main_Name_CaptionLbl: Label 'Employee''s Main Name:';
        Employee_s_Other_Names_CaptionLbl: Label 'Employee''s Other Names:';
        Employee_s_PIN_CaptionLbl: Label 'Employee''s PIN:';
        Employers_Name_CaptionLbl: Label 'Employers Name:';
        Employers_PIN_CaptionLbl: Label 'Employers PIN:';
        EmptyStringCaptionLbl: Label '...................................................................................................................................';
        F__Standard_Amount_CaptionLbl: Label 'F (Standard Amount)';
        G___Lowest_of_E_F_CaptionLbl: Label 'G  (Lowest of E+F)';
        Gross_SalaryCaptionLbl: Label 'Gross Salary';
        HCaptionLbl: Label 'H';
        INCOME_TAX_DEDUCTION_CARD_YEAR_CaptionLbl: Label 'INCOME TAX DEDUCTION CARD YEAR:';
        INCOME_TAX_DEPARTMENTCaptionLbl: Label 'INCOME TAX DEPARTMENT';
        Insurance_ReliefCaptionLbl: Label 'Insurance Relief';
        InterestCaptionLbl: Label ' Interest';
        JCaptionLbl: Label 'J';
        KCaptionLbl: Label 'K';
        KENYA_REVENUE_AUTHORITYCaptionLbl: Label 'KENYA REVENUE AUTHORITY';
        L_R__NO__OF_OWNER_OCCUPIED_HOUSE: Label 'L.R. NO. OF OWNER OCCUPIED HOUSE ................................................................';
        LCaptionLbl: Label 'L';
        MCaptionLbl: Label 'M';
        MonthCaptionLbl: Label 'Month';
        Name_and_address_of_new_employer: Label '     Name and address of new employer.................................................................';
        Name_and_address_of_old_employer: Label '      Name and address of old employer..................................................................';
        NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTIONCaptionLbl: Label 'NAMES OF MORTGAGE FINANCIAL INSTITUTION';
        Non_CashCaptionLbl: Label 'Non-Cash';
        Occupied_InterestCaptionLbl: Label ' Occupied Interest';
        Owner_OccupiedCaptionLbl: Label 'Owner Occupied';
        P_A_Y_E_TAXCaptionLbl: Label 'P.A.Y.E TAX';
        Personal_File_No_CaptionLbl: Label 'Personal File No.';
        Personal_ReliefCaptionLbl: Label 'Personal Relief';
        QuartersCaptionLbl: Label 'Quarters';
        Reference_No: Label 'Reference No:  .....................................................';
        Retr__Contribution__CaptionLbl: Label 'Retr. Contribution &';
        SIGNATURE: Label 'SIGNATURE   ....................................................................................................................................';
        Tax__Shs_CaptionLbl: Label 'Tax (Shs)';
        Tax_ChargedCaptionLbl: Label 'Tax Charged';
        Taxable_AmountCaptionLbl: Label 'Taxable Amount';
        Total_A_B_CCaptionLbl: Label 'Total A+B+C';
        TOTAL_CHARGEABLE_PAY__COL_H__KshsCaptionLbl: Label 'TOTAL CHARGEABLE PAY (COL H) Kshs';
        TOTAL_TAX__COL_M__KshsCaptionLbl: Label 'TOTAL TAX (COL M) Kshs';
        TOTALSCaptionLbl: Label 'TOTALS';
        V1: Label '(1) Date employee commenced if during the year...............................................';
        V2: Label '(2) Date left if during the year....................................................................................';
        V3: Label '(3) Where housing is provided,State monthly rent..............................................';
        V4: Label '(4) Where any of the pay relates to a period other than this year e.g gratuity, give details.......................';
        Value_OfCaptionLbl: Label 'Value Of';
        YearCaptionLbl: Label 'Year';
        CoPin: Text[30];

    procedure GetDefaults(var StartingDate: Date; var EndingDate: Date)
    begin
        // StringDate:=StartingDate;
        // EndingDate:=EndDate;
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
}





