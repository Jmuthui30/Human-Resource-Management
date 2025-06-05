report 52093 "Trustee Payroll Reconciliation"
{
    ApplicationArea = All;
    Caption = 'Payroll Reconciliation';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrusteePayrollReconciliation.rdl';

    dataset
    {
        dataitem(Earnings; Earnings)
        {
            DataItemTableView = sorting(Code) where("Non-Cash Benefit" = const(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Pay Period Filter";

            column(CompInfo_Picture; CompInfo.Picture)
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
            column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; StrSubstNo('PERIOD: %1', UpperCase(Format(Thismonth, 0, '<month text> <year4>'))))
            {
            }
            column(Earnings_Description; Description)
            {
            }
            column(PAYROLL_RECONCILIATION_DETAILED_REPORTCaption; PAYROLL_RECONCILIATION_DETAILED_REPORTCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(Current_PeriodCaption; Current_PeriodCaptionLbl)
            {
            }
            column(Last_PeriodCaption; Last_PeriodCaptionLbl)
            {
            }
            column(DifferenceCaption; DifferenceCaptionLbl)
            {
            }
            column(Earnings_Code; Code)
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee Type" = const("Board Member"));

                column(Employee__No__; "No.")
                {
                }
                column(EmpName; EmpName)
                {
                }
                column(ThisMonthVal; ThisMonthVal)
                {
                }
                column(LastMonthVal; LastMonthVal)
                {
                }
                column(Difference; Difference)
                {
                }
                column(ThisMonthVal_Control1000000043; ThisMonthVal)
                {
                }
                column(LastMonthVal_Control1000000044; LastMonthVal)
                {
                }
                column(Difference_Control1000000045; Difference)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LastMonthVal := 0;
                    Difference := 0;
                    ThisMonthVal := 0;
                    EmpName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    //Last Month
                    Assignmat.Reset();
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Earning);
                    Assignmat.SetRange(Assignmat.Code, Earnings.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    if Assignmat.Find('+') then
                        LastMonthVal := Assignmat.Amount;

                    //CurrentMonth
                    Assignmat.Reset();
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Earning);
                    Assignmat.SetRange(Assignmat.Code, Earnings.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
                    if Assignmat.Find('+') then
                        ThisMonthVal := Assignmat.Amount;
                    Difference := ThisMonthVal - LastMonthVal;
                    if Difference = 0 then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals(Difference, LastMonthVal, ThisMonthVal);
                end;
            }
        }
        dataitem(Deductions; Deductions)
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = true;

            column(Deductions_Description; Description)
            {
            }
            column(Deductions_Code; Code)
            {
            }
            dataitem(EmpDed; Employee)
            {
                DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee Type" = filter("Board Member"));

                column(EmpDed__No__; "No.")
                {
                }
                column(EmpName_Control1000000035; EmpName)
                {
                }
                column(ThisMonthVal_Control1000000036; ThisMonthVal)
                {
                }
                column(LastMonthVal_Control1000000037; LastMonthVal)
                {
                }
                column(Difference_Control1000000038; Difference)
                {
                }
                column(ThisMonthVal_Control1000000039; ThisMonthVal)
                {
                }
                column(LastMonthVal_Control1000000040; LastMonthVal)
                {
                }
                column(Difference_Control1000000041; Difference)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LastMonthVal := 0;
                    Difference := 0;
                    ThisMonthVal := 0;
                    EmpName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    //Last Month
                    Assignmat.Reset();
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, Deductions.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    if Assignmat.Find('+') then
                        LastMonthVal := Assignmat.Amount + Assignmat."Loan Interest";

                    //CurrentMonth
                    Assignmat.Reset();
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, Deductions.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
                    if Assignmat.Find('+') then
                        ThisMonthVal := Assignmat.Amount + Assignmat."Loan Interest";
                    Difference := ThisMonthVal - LastMonthVal;
                    if Difference = 0 then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals(Difference, LastMonthVal, ThisMonthVal);
                end;
            }
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
        CompInfo.Get();
        CompInfo.CalcFields(Picture);

        Thismonth := Earnings.GetRangeMin(Earnings."Pay Period Filter");
        Lastmonth := CalcDate('-1M', Thismonth);
    end;

    var
        Assignmat: Record "Assignment Matrix";
        CompInfo: Record "Company Information";
        Lastmonth: Date;
        Thismonth: Date;
        Difference: Decimal;
        LastMonthVal: Decimal;
        ThisMonthVal: Decimal;
        Current_PeriodCaptionLbl: Label 'Current Period';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DifferenceCaptionLbl: Label 'Difference';
        EmployeeCaptionLbl: Label 'Employee';
        Last_PeriodCaptionLbl: Label 'Last Period';
        PAYROLL_RECONCILIATION_DETAILED_REPORTCaptionLbl: Label 'PAYROLL RECONCILIATION DETAILED REPORT';
        EmpName: Text[230];
}





