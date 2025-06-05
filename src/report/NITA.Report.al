report 52099 "NITA"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeNITA.rdl';
    Caption = 'NITA';
    dataset
    {
        dataitem("Payroll PeriodX"; "Payroll Period")
        {
            RequestFilterFields = "Pay Period Filter", "Deductions Code Filter";

            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(Tel; Tel)
            {
            }
            column(Address; Address)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(Payroll_PeriodX_Name; Name)
            {
            }
            column(Payroll_PeriodX__Starting_Date_; UpperCase(Format("Starting Date", 0, '<month text> <year4>')))
            {
            }
            column(Payroll_PeriodCaption; Payroll_PeriodCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(TEL_NOCaption; TEL_NOCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
            {
            }
            column(ADDRESSCaptions; ADDRESSCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
            {
            }
            column(EMPLOYERCaption; EMPLOYERCaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(MONTHLY_EARNINGS_REPORTCaption; MONTHLY_EARNINGS_REPORTCaptionLbl)
            {
            }
            column(Payroll_PeriodX_Starting_Date; "Starting Date")
            {
            }
            column(Payroll_PeriodX_Earnings_Code_Filter; "Payroll PeriodX"."Deductions Code Filter")
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
            dataitem(Deductions; Deductions)
            {
                DataItemLink = Code = field("Deductions Code Filter"), "Pay Period Filter" = field("Starting Date");
                DataItemTableView = sorting(Code);

                column(Earnings_Description; Description)
                {
                }
                column(Earnings_Code; Code)
                {
                }
                column(Earnings_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                dataitem("Assignment Matrix-X"; "Assignment Matrix")
                {
                    DataItemLink = Code = field(Code), "Payroll Period" = field("Pay Period Filter");
                    DataItemTableView = sorting("Employee No", Type, Code, "Payroll Period", "Reference No") where(Type = const(Deduction), "Employee type" = filter(<> Trustee));

                    column(Assignment_Matrix_X__Assignment_Matrix_X__Amount; Amount)
                    {
                    }
                    column(LastName; LastName)
                    {
                    }
                    column(Assignment_Matrix_X__Assignment_Matrix_X___Employee_No_; "Employee No")
                    {
                    }
                    column(FirstName; FirstName)
                    {
                    }
                    column(TotalAmount; TotalAmount)
                    {
                    }
                    column(Counter; Counter)
                    {
                    }
                    column(Total_AmountCaption; Total_AmountCaptionLbl)
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
                    column(ID_No; GetIDNo("Employee No"))
                    {
                    }
                    column(KRA_Pin; GetKRAPin("Employee No"))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        if Emp.Get("Assignment Matrix-X"."Employee No") then begin
                            NhifNo := Emp."NHIF No";
                            FirstName := Emp."First Name";
                            LastName := Emp."Last Name";
                            TotalAmount := TotalAmount + "Assignment Matrix-X".Amount;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Assignment Matrix-X".SetRange("Payroll Period", "Payroll PeriodX"."Starting Date");
                        if CompInfoSetup.Get() then;

                    end;
                }
            }

            trigger OnPreDataItem()
            begin

                "Payroll PeriodX".SetFilter("Starting Date", "Payroll PeriodX".GetFilter("Pay Period Filter"));
            end;

            trigger OnAfterGetRecord()
            begin
                GetDefaults(PayApprovalCode);

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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    trigger OnInitReport()
    begin

    end;

    trigger OnPostReport()
    begin

    end;

    var
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        Emp: Record Employee;
        CompInfoSetup: Record "Employee Earnings History";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Payroll: Codeunit Payroll;
        CompPINNo: Code[20];
        EmployerNHIFNo: Code[20];
        NhifNo: Code[20];
        Approver: array[10] of Code[50];
        PayApprovalCode: Code[50];
        DateSpecified: Date;
        ApproverDate: array[10] of DateTime;
        TotalAmount: Decimal;
        Counter: Integer;
        ADDRESSCaptionLbl: Label 'ADDRESS';
        AmountCaptionLbl: Label 'Amount';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        MONTHLY_EARNINGS_REPORTCaptionLbl: Label 'MONTHLY DEDUCTIONS REPORT';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        PageCaptionLbl: Label 'Page';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        Payroll_PeriodCaptionLbl: Label 'Payroll Period';
        PERIODCaptionLbl: Label 'PERIOD';
        TEL_NOCaptionLbl: Label 'TEL NO';
        Total_AmountCaptionLbl: Label 'Total Amount';
        FirstName: Text[30];
        LastName: Text[30];
        Tel: Text[30];
        Address: Text[90];

    procedure GetDefaults(var PayAppCode: Code[50])
    begin
        PayApprovalCode := PayAppCode;
    end;

    procedure GetIDNo(EmployeeNo: Code[20]): Code[50]
    begin
        if Emp.Get(EmployeeNo) then
            exit(Emp."ID No.");
    end;

    procedure GetKRAPin(EmpNo: Code[20]): Code[50]
    begin
        if Emp.Get(EmpNo) then
            exit(Emp."PIN Number");
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





