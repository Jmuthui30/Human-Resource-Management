report 52108 "Promotion Letter"
{
    ApplicationArea = All;
    Caption = 'Promotion Letter';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PromotionLetter.rdl';
    dataset
    {
        dataitem(EmployeeActingPosition; "Employee Acting Position")
        {
            column(EmployeeNo; "Acting Employee No.")
            {
            }
            column(Name; Name)
            {
            }
            column(DesiredPosition; "Desired Position")
            {
            }
            column(PositionName; "Position Name")
            {
            }
            column(NewScale; "New Scale")
            {
            }
            column(NewPointer; "New Pointer")
            {
            }
            column(Reason; Reason)
            {
            }
            column(CurrentBenefits; "Current Benefits")
            {
            }
            column(NewBenefits; "New Benefits")
            {
            }
            column(CurrentPointer; "Current Pointer")
            {
            }
            column(CurrentScale; "Current Scale")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
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






