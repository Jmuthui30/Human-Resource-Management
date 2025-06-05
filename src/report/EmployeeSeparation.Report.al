report 52111 "Employee Separation"
{
    ApplicationArea = All;
    Caption = 'Employee Separation';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeSeparation.rdl';
    dataset
    {
        dataitem(EmployeeSeparation; "Employee Separation")
        {
            RequestFilterFields = "Separation Type";
            column(No; "No.")
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(EffectiveDate; "Effective Date")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(CurrentBasicPay; "Current Basic Pay")
            {
            }
            column(LeaveEarnedToDate; "Leave Earned To Date")
            {
            }
            column(LeaveLiability; "Leave Liability")
            {
            }
            column(AnnualLeaveBalance; "Annual Leave Balance")
            {
            }
            column(ProvidentFundEmployee; "Provident Fund - Employee")
            {
            }
            column(ProvidentFundEmployer; "Provident Fund - Employer")
            {
            }
            column(TerminationDate; "Termination Date")
            {
            }
            column(GroundsforTermCode; "Grounds for Term. Code")
            {
            }
            column(SeparationType; "Separation Type")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(Comments; Comments)
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






