report 52063 "NHIF"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/NHIF.rdl';
    Caption = 'NHIF';
    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix")
        {
            DataItemTableView = sorting("Employee No", Type, Code, "Payroll Period", "Reference No") where(Type = const(Deduction), "Employee type" = filter(<> trustee), NHIF = const(true));
            RequestFilterFields = "Payroll Period", "Code";

            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Address; Address)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME_Control1000000006; CompanyName)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4_____Control1000000009; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(EmployerNHIFNo_Control1000000007; EmployerNHIFNo)
            {
            }
            column(ABS__Assignment_Matrix_X1__Amount_; Abs("Assignment Matrix-X".Amount))
            {
            }
            column(Emp__ID_Number_; Emp."ID No.")
            {
            }
            column(YEAR; YEAR)
            {
            }
            column(Emp__NHIF_No__; Emp."NHIF No")
            {
            }
            column(FirstName_____Emp__Middle_Name______LastName; FirstName + ' ' + Emp."Middle Name" + ' ' + LastName)
            {
            }
            column(Assignment_Matrix_X1__Assignment_Matrix_X1___Employee_No_; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Assignment_Matrix_X__Payroll_Group_; "Payroll Group")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Counter; Counter)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(ID_PassportCaption; ID_PassportCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(Date_of_BirthCaption; Date_of_BirthCaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
            {
            }
            column(MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaption; MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaptionLbl)
            {
            }
            column(TEL_NOCaption; TEL_NOCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
            {
            }
            column(EMPLOYERCaption; EMPLOYERCaptionLbl)
            {
            }
            column(ADDRESSCaption; ADDRESSCaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(AmountCaption_Control1000000005; AmountCaption_Control1000000005Lbl)
            {
            }
            column(PageCaption_Control44; PageCaption_Control44Lbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(ID_PassportCaption_Control1000000049; ID_PassportCaption_Control1000000049Lbl)
            {
            }
            column(Date_of_BirthCaption_Control1000000051; Date_of_BirthCaption_Control1000000051Lbl)
            {
            }
            column(NHIF_No_Caption_Control1000000053; NHIF_No_Caption_Control1000000053Lbl)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaption; NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption_Control1000000055; Name_of_EmployeeCaption_Control1000000055Lbl)
            {
            }
            column(EMPLOYER_NOCaption_Control1000000008; EMPLOYER_NOCaption_Control1000000008Lbl)
            {
            }
            column(Payroll_No_Caption_Control1000000056; Payroll_No_Caption_Control1000000056Lbl)
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
            column(IdNo; IdNo)
            {
            }
            column(OtherNames; OtherNames)
            {
            }
            column(CompName; CompName)
            {
            }
            column(LastName; LastName)
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }

            trigger OnAfterGetRecord()
            begin

                GetDefaults(PayApprovalCode);

                if Emp.Get("Assignment Matrix-X"."Employee No") then begin
                    NhifNo := Emp."NHIF No";
                    FirstName := Emp."First Name";
                    LastName := Emp."Last Name";
                    OtherNames := Emp."First Name" + ' ' + Emp."Middle Name";
                    IdNo := Emp."ID No.";
                    //YEAR:=Emp."Birth Date";
                    TotalAmount := TotalAmount + Abs("Assignment Matrix-X".Amount);
                end;
                Counter := Counter + 1;

                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID", Database::"Payroll Approval");
                if PayApprovalCode <> '' then
                    ApprovalEntries.SetRange("Document No.", PayApprovalCode)
                else
                    ApprovalEntries.SetRange("Document No.", Payroll.GetPayrollApprovalCode(DateSpecified));
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[1] := ApprovalEntries."Sender ID";
                            ApproverDate[1] := ApprovalEntries."Date-Time Sent for Approval";
                            if UserSetup.Get(Approver[1]) then
                                UserSetup.CalcFields(Signature);
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then
                                UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next() = 0;
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
        DateSpecified := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X"."Payroll Period");
        //NHIFCODE := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X".Code);

        CompInfoSetup.Get();
        CompName := CompInfoSetup.Name;

        HRSetup.Get();
        HRSetup.TestField("Company NHIF No");

        EmployerNHIFNo := HRSetup."Company NHIF No";
        //CompPINNo:=CompInfoSetup."Company PIN No.";
        Address := CompInfoSetup.Address;
        Tel := CompInfoSetup."Phone No.";
    end;

    var
        ApprovalEntries: Record "Approval Entry";
        CompInfoSetup: Record "Company Information";
        Emp: Record Employee;
        HRSetup: Record "Human Resources Setup";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Payroll: Codeunit Payroll;
        CompPINNo: Code[20];
        EmployerNHIFNo: Code[20];
        IdNo: Code[20];
        NhifNo: Code[20];
        Approver: array[10] of Code[50];
        PayApprovalCode: Code[50];
        DateSpecified: Date;
        YEAR: Date;
        ApproverDate: array[10] of DateTime;
        TotalAmount: Decimal;
        Counter: Integer;
        ADDRESSCaptionLbl: Label 'ADDRESS';
        AmountCaption_Control1000000005Lbl: Label 'Amount';
        AmountCaptionLbl: Label 'Amount';
        Date_of_BirthCaption_Control1000000051Lbl: Label 'Date of Birth';
        Date_of_BirthCaptionLbl: Label 'Date of Birth';
        EMPLOYER_NOCaption_Control1000000008Lbl: Label 'EMPLOYER NO';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        ID_PassportCaption_Control1000000049Lbl: Label 'ID/Passport';
        ID_PassportCaptionLbl: Label 'ID/Passport';
        MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaptionLbl: Label 'MONTHLY PAYROLL (BY-PRODUCT) RETURNS TO NHIF';
        Name_of_EmployeeCaption_Control1000000055Lbl: Label 'Name of Employee';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl: Label 'NATIONAL HOSPITAL INSURANCE FUND REPORT';
        NHIF_No_Caption_Control1000000053Lbl: Label 'NHIF No.';
        NHIF_No_CaptionLbl: Label 'NHIF No.';
        PageCaption_Control44Lbl: Label 'Page';
        PageCaptionLbl: Label 'Page';
        Payroll_No_Caption_Control1000000056Lbl: Label 'Payroll No.';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        PERIODCaptionLbl: Label 'PERIOD';
        TEL_NOCaptionLbl: Label 'TEL NO';
        UserCaptionLbl: Label 'User';
        CompName: Text;
        OtherNames: Text;
        FirstName: Text[30];
        LastName: Text[30];
        Tel: Text[30];
        Address: Text[90];

    procedure GetDefaults(var PayAppCode: Code[50])
    begin
        PayApprovalCode := PayAppCode;
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

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;
}





