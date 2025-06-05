report 52036 "Employees Removed"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeesRemoved.rdlc';
    Caption = 'Employees Removed';
    dataset
    {
        dataitem("Payroll Period"; "Payroll Period")
        {
            RequestFilterFields = "Pay Period Filter";

            column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; StrSubstNo('PERIOD: %1', UpperCase(Format(Thismonth, 0, '<month text> <year4>'))))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(Payroll_PeriodX__Starting_Date_; UpperCase(Format("Starting Date", 0, '<month text> <year4>')))
            {
            }
            column(Payroll_PeriodX_Name; Name)
            {
            }
            column(EMPLOYEES_REMOVED_FROM_PAYROLLCaption; EMPLOYEES_REMOVED_FROM_PAYROLLCaptionLbl)
            {
            }
            column(Control1000000021Caption; Control1000000021CaptionLbl)
            {
            }
            column(Payroll_PeriodX_Starting_Date; "Starting Date")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee type" = filter(<> "Board Member"));

                column(Employee__No__; "No.")
                {
                }
                column(First_Name_______Middle_Name________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
                {
                }
                column(Counter; Counter)
                {
                }
                column(Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    FoundThismonth := false;
                    FoundLastmonth := false;

                    AssignMat.Reset();
                    AssignMat.SetRange(AssignMat."Employee No", Employee."No.");
                    AssignMat.SetRange(AssignMat."Payroll Period", Thismonth);
                    if AssignMat.Find('+') then
                        FoundThismonth := true;


                    AssignMat.Reset();
                    AssignMat.SetRange(AssignMat."Employee No", Employee."No.");
                    AssignMat.SetRange(AssignMat."Payroll Period", LastMonth);
                    if AssignMat.Find('+') then
                        FoundLastmonth := true;

                    if FoundThismonth and FoundLastmonth then
                        CurrReport.Skip();

                    if not FoundThismonth and not FoundLastmonth then
                        CurrReport.Skip();


                    if not FoundLastmonth and FoundThismonth then
                        CurrReport.Skip();
                    Counter := Counter + 1;
                end;

                trigger OnPreDataItem()
                begin
                    Thismonth := "Payroll Period"."Starting Date";
                    LastMonth := CalcDate('-1M', "Payroll Period"."Starting Date");
                    Counter := 0;

                    Employee.SetRange("Pay Period Filter", "Payroll Period"."Starting Date");
                end;
            }

            trigger OnPreDataItem()
            begin
                "Payroll Period".SetFilter("Starting Date", "Payroll Period".GetFilter("Pay Period Filter"));
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
        AssignMat: Record "Assignment Matrix";
        FoundLastmonth: Boolean;
        FoundThismonth: Boolean;
        LastMonth: Date;
        Thismonth: Date;
        Counter: Integer;
        Control1000000021CaptionLbl: Label 'Label1000000021';
        EMPLOYEES_REMOVED_FROM_PAYROLLCaptionLbl: Label 'EMPLOYEES REMOVED FROM PAYROLL';
        NameCaptionLbl: Label 'Name';
}





