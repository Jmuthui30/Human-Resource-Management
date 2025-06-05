report 52109 "Employee Pay Modes"
{
    ApplicationArea = All;
    Caption = 'Employee Pay Modes';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeePayModes.rdl';

    dataset
    {
        dataitem(EmployeePayModes; "Employee Pay Modes")
        {
            column(PayMode; "Pay Mode")
            {
            }
            column(Description; Description)
            {
            }
            column(TotalDeductions; "Total Deductions")
            {
            }
            column(TotalEarnings; "Total Earnings")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
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
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}






