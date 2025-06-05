report 52112 "Employee Certificate of Servic"
{
    ApplicationArea = All;
    Caption = 'Employee Certificate of Service';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeCertificateOfService.rdl';
    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No; "No.")
            {
            }
            column(EmpName; EmpName)
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
            column(Day; Day)
            {
            }
            column(Month; Month)
            {
            }
            column(Year; Year)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmpRec.Copy(Employee);
                EmpName := EmpRec.FullName();

                Day := Date2DMY(Today, 1);
                Month := Date2DMY(Today, 2);
                Year := Date2DMY(Today, 3);
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        EmpRec: Record Employee;
        Day, Month, Year : Integer;
        EmpName: Text;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

}






