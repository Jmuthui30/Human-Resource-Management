report 52116 "Grievance Form"
{
    ApplicationArea = All;
    Caption = 'Grievance Form';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/GrievanceForm.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No; "No.")
            {
            }
            column(JobPosition; "Job Position")
            {
            }
            column(JobPositionTitle; "Job Position Title")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
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






