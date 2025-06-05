report 52059 "Acting Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ActingReport.rdl';
    Caption = 'Acting Report';
    dataset
    {
        dataitem("Employee Acting Position"; "Employee Acting Position")
        {
            DataItemTableView = sorting(No) where("Document Type" = const(Acting));

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
            column(Employee_No; "Employee Acting Position"."Acting Employee No.")
            {
            }
            column(NewScale; "Employee Acting Position"."New Scale")
            {
            }
            column(New_Pointer; "Employee Acting Position"."New Pointer")
            {
            }
            column(New_Benefits; "Employee Acting Position"."New Benefits")
            {
            }
            column(Acting_Amount; "Employee Acting Position"."Acting Amount")
            {
            }
            column(Acting_Position; "Employee Acting Position".Position)
            {
            }
            column(Start_Date; "Employee Acting Position"."Start Date")
            {
            }
            column(End_; "Employee Acting Position"."End Date")
            {
            }
            column(Reason; Reason)
            {
            }
            column(Relieved_Name; "Relieved Name")
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

    var
        CompanyInfo: Record "Company Information";
}





