report 52092 "Trustee Pension Report"
{
    ApplicationArea = All;
    Caption = 'Pension Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrusteePensionReport.rdlc';

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix")
        {
            DataItemTableView = sorting("Employee No", Type, Code, "Payroll Period", "Reference No") order(ascending) where(Type = const(Deduction), Code = const('D009'), "Employee type" = filter(Trustee));
            RequestFilterFields = "Payroll Period", "Code";
            RequestFilterHeading = 'NSSF';
            column(Comp_Name; CompRec.Name)
            {
            }
            column(Address; CompRec.Address)
            {
            }
            column(City; CompRec.City)
            {
            }
            column(Phone_No; CompRec."Phone No.")
            {
            }
            column(Logo; CompRec.Picture)
            {
            }
            column(Post_Code; CompRec."Post Code")
            {
            }
            column(Email; CompRec."E-Mail")
            {
            }
            column(Website; CompRec."Home Page")
            {
            }
            column(Country; CompRec."Country/Region Code")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUND__; 'NATIONAL SOCIAL SECURITY FUND ')
            {
            }
            /*             column(CurrReport_PAGENO; CurrReport.PageNo)
                        {
                        } */
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CoNssf; CoNssf)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUND___Control28; 'NATIONAL SOCIAL SECURITY FUND ')
            {
            }
            column(P_O__BOX_30599__; 'P.O. BOX 30599 ')
            {
            }
            column(NAIROBI__; 'NAIROBI ')
            {
            }
            column(Assignment_Matrix_X__Employee_No_; "Employee No")
            {
            }
            column(Name; Name)
            {
            }
            column(ID_No; IDNo)
            {
            }
            column(Emp_Nssf_No; NSSFNo)
            {
            }
            column(ABS_Amount_; Abs(Amount))
            {
            }
            column(ABS__Employer_Amount___; Abs(EmployerAmt))
            {
            }
            column(Emp__Social_Security_No__; Emp."Social Security No.")
            {
            }
            column(ABS__Employer_Amount____ABS_Amount__ABS_EmpVoluntary_; Abs("Employer Amount") + Abs(Amount) + Abs(EmpVoluntary))
            {
            }
            column(ABS_EmpVoluntary_; Abs(EmpVoluntary))
            {
            }
            column(EmployeeTotal; EmployeeTotal)
            {
            }
            column(EmployerTotal; EmployerTotal)
            {
            }
            column(SumTotal; SumTotal)
            {
            }
            column(ABS_EmpVoluntary__Control1000000013; Abs(EmpVoluntary))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(COMPANY_NSSF_No_Caption; COMPANY_NSSF_No_CaptionLbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(CONTRIBUTIONS_RETURN_FORMCaption; CONTRIBUTIONS_RETURN_FORMCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(Employee_VoluntaryCaption; Employee_VoluntaryCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(Approving_OfficerCaption; Approving_OfficerCaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption_Control1000000006; DESIGNATION____________________________________________________________Caption_Control1000000006Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000007; DATE_____________________________________________________________________Caption_Control1000000007Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000008; NAME_________________________________________________________________________Caption_Control1000000008Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000009; SIGNATURE___________________________________________________________Caption_Control1000000009Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            column(Assignment_Matrix_X_Type; Type)
            {
            }
            column(Assignment_Matrix_X_Code; Code)
            {
            }
            column(Assignment_Matrix_X_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X_Reference_No; "Reference No")
            {
            }
            column(Gross_Pay; GetGrossPay("Employee No"))
            {
            }

            trigger OnAfterGetRecord()
            begin

                if Emp.Get("Employee No") then begin
                    Name := Emp."First Name" + ' ' + Emp."Last Name";
                    IDNo := Emp."ID No.";
                    NSSFNo := Emp."Social Security No.";
                    Emp.SetRange(Emp."Pay Period Filter", "Assignment Matrix-X"."Payroll Period");
                    Emp.CalcFields(Emp."Basic Pay");
                    if BeginDate = DateSpecified then
                        BasicPay := Emp."Basic Pay"
                    else
                        BasicPay := Emp."Basic Pay";
                    SSFNo := Emp."Social Security No.";
                end;
                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Earning then
                    if Payment.Get("Assignment Matrix-X".Code) then
                        GroupHeader := Payment.Description;



                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Deduction then begin
                    if Deduction.Get("Assignment Matrix-X".Code) then begin
                        GroupHeader := Deduction.Description;
                        //******Get Voluntary Contributions***********//
                        Deduction.SetRange(Deduction."Voluntary Code", "Assignment Matrix-X".Code);
                        Deduction.SetRange(Deduction."Pay Period Filter", "Assignment Matrix-X"."Payroll Period");
                        Deduction.SetRange(Deduction."Employee Filter", "Assignment Matrix-X"."Employee No");
                        Deduction.CalcFields("Voluntary Amount");
                        EmpVoluntary := Deduction."Voluntary Amount";
                    end;
                    EmployerAmt := "Assignment Matrix-X"."Employer Amount";
                end;





                TotalBasic := TotalBasic + BasicPay;
                EmployerTotal := EmployerTotal + Abs("Assignment Matrix-X"."Employer Amount");
                EmployeeTotal := EmployeeTotal + Abs("Assignment Matrix-X".Amount);
                SumTotal := SumTotal + Abs("Assignment Matrix-X"."Employer Amount") + Abs("Assignment Matrix-X".Amount) + Abs(EmpVoluntary);
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Code);
                //"Assignment Matrix-X".SETRANGE("Assignment Matrix-X".Retirement,TRUE);
                "Assignment Matrix-X".SetRange("Assignment Matrix-X".Type, "Assignment Matrix-X".Type::Deduction);
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

        CompRec.Get();
        CompRec.CalcFields(Picture);
        HRSetup.Get();
        CoNssf := HRSetup."Company NSSF No";
        GetPayPeriod();
        DateSpecified := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X"."Payroll Period");
        if PayPeriod.Get(DateSpecified) then
            PayPeriodText := PayPeriod.Name;
        nssfcode := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X".Code);
    end;

    var
        CompRec: Record "Company Information";
        Deduction: Record Deductions;
        Payment: Record Earnings;
        Emp: Record Employee;
        HRSetup: Record "Human Resources Setup";
        PayPeriod: Record "Payroll Period Trustees";
        nssfcode: Code[10];
        IDNo: Code[20];
        NSSFNo: Code[20];
        SSFNo: Code[30];
        BeginDate: Date;
        DateSpecified: Date;
        BasicPay: Decimal;
        EmployeeTotal: Decimal;
        EmployerAmt: Decimal;
        EmployerTotal: Decimal;
        EmpVoluntary: Decimal;
        SumTotal: Decimal;
        TotalBasic: Decimal;
        LastFieldNo: Integer;
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
        COMPANY_NSSF_No_CaptionLbl: Label 'COMPANY NSSF No.';
        CONTRIBUTIONS_RETURN_FORMCaptionLbl: Label 'CONTRIBUTIONS RETURN FORM';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DATE_____________________________________________________________________Caption_Control1000000007Lbl: Label 'DATE ....................................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        DESIGNATION____________________________________________________________Caption_Control1000000006Lbl: Label 'DESIGNATION ...........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        Employee_VoluntaryCaptionLbl: Label 'Employee Voluntary';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        NAME_________________________________________________________________________Caption_Control1000000008Lbl: Label 'NAME  .......................................................................';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        NameCaptionLbl: Label 'Name';
        No_CaptionLbl: Label 'No.';
        NSSF_No_CaptionLbl: Label 'NSSF No.';
        PERIODCaptionLbl: Label 'PERIOD';
        SIGNATURE___________________________________________________________Caption_Control1000000009Lbl: Label 'SIGNATURE ..........................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        Total_AmountCaptionLbl: Label 'Total Amount';
        TotalCaptionLbl: Label 'Total';
        UserCaptionLbl: Label 'User';
        CoNssf: Text[30];
        GroupHeader: Text[30];
        PayPeriodText: Text[30];
        Name: Text[250];


    procedure GetGrossPay(EmpNo: Code[20]): Decimal
    var
        AssMatrix: Record "Assignment Matrix";
        Gpay: Decimal;
    begin
        AssMatrix.Reset();
        AssMatrix.SetRange(Type, AssMatrix.Type::Earning);
        AssMatrix.SetRange("Payroll Period", DateSpecified);
        AssMatrix.SetRange("Employee No", EmpNo);
        //AssMatrix.SETRANGE(Taxable,TRUE);
        AssMatrix.SetRange("Basic Salary Code", true);
        if AssMatrix.Find('-') then begin
            AssMatrix.CalcSums(Amount);
            Gpay := AssMatrix.Amount;
        end;
        exit(Gpay);
    end;


    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            BeginDate := PayPeriod."Starting Date";
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













