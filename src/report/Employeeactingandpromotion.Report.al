report 52018 "Employee acting and promotion"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/Employeeactingandpromotion.rdl';
    Caption = 'Employee acting and promotion';
    dataset
    {
        dataitem("Employee Acting Position"; "Employee Acting Position")
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = "Document Type";

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
            column(Start_Date; "Employee Acting Position"."Start Date")
            {
            }
            column(End_Date; "Employee Acting Position"."End Date")
            {
            }
            column(Desired_Position; "Desired Position")
            {
            }
            column(Position_Name; "Position Name")
            {
            }
            column(Reason; "Employee Acting Position".Reason)
            {
            }
            column(Employee_No; "Employee Acting Position"."Acting Employee No.")
            {
            }
            column(New_Scale; "Employee Acting Position"."New Scale")
            {
            }
            column(New_Pointer; "Employee Acting Position"."New Pointer")
            {
            }
            column(New_Benefits; "Employee Acting Position"."New Benefits")
            {
            }
            column(PromotionType; "Document Type")
            {
            }
            column(CurrentPosition; "Current Position")
            {
            }
            column(CurrentPositionName; "Current Position Name")
            {
            }
            column(CurrentBenefits; "Current Benefits")
            {
            }
            column(CurrentPointer; "Current Pointer")
            {
            }
            column(CurrentScale; "Current Scale")
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





