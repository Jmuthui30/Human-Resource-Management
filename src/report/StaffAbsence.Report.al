report 52105 "Staff Absence"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/Staff Absence.rdl';
    Caption = 'Staff Absence';
    dataset
    {
        dataitem("Employee Absence"; "Employee Absence")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr; CompanyInfo.Address)
            {
            }
            column(CompanyCIty; CompanyInfo.City)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(Employee_No_; "Employee No.")
            {
            }
            column(Cause_of_Absence_Code; "Cause of Absence Code")
            {
            }
            column(Description; Description)
            {
            }
            column(From_Date; "From Date")
            {
            }
            column(To_Date; "To Date")
            {
            }
            column(Quantity; Quantity)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the ActionName action';
                }
            }
        }
    }

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}





