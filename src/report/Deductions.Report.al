report 52055 "Deductions"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/Deductions.rdl';
    Caption = 'Deductions';
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
                    DataItemTableView = sorting("Employee No", Type, Code, "Payroll Period", "Reference No") where(Type = const(Deduction));

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
        CompanyInfo: Record "Company Information";
        Emp: Record Employee;
        CompInfoSetup: Record "Employee Earnings History";
        CompPINNo: Code[20];
        EmployerNHIFNo: Code[20];
        NhifNo: Code[20];
        DateSpecified: Date;
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
}





