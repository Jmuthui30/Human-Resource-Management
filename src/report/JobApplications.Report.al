report 52110 "Job Applications"
{
    ApplicationArea = All;
    Caption = 'Job Applications';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/JobApplications.rdl';
    dataset
    {
        dataitem(JobApplication; "Job Application")
        {
            RequestFilterFields = "Job Applied Code", Gender, "Applicant Type", "Application Status";
            column(No; "No.")
            {
            }
            column(JobAppliedCode; "Job Applied Code")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(Gender; Gender)
            {
            }
            column(ApplicantNo; "Applicant No.")
            {
            }
            column(ApplicantName; "Applicant Name")
            {
            }
            column(ApplicantType; "Applicant Type")
            {
            }
            column(ApplicationStatus; "Application Status")
            {
            }
            column(DateTimeCreated; "Date-Time Created")
            {
            }
            column(TotalAverageScore; "Total Average Score")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
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






