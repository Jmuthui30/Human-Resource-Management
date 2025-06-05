report 52080 "Trustee Bank Details"
{
    ApplicationArea = All;
    Caption = 'Board Members Bank Details';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrusteeBankDetails.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where("Employee Type" = const("Board Member"));

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Comp_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(Employee_Name; GetName(Employee."No."))
            {
            }
            column(Employment_Date; Employee."Employment Date")
            {
            }
            column(Bank_Branch; Employee."Bank Branch")
            {
            }
            column(Bank_Account_Number; Employee."Bank Account Number")
            {
            }
            column(Date_Of_Join; Employee."Date Of Join")
            {
            }
            column(Sort_Code; Employee."Employee Bank Sort Code")
            {
            }
            column(Employee_BankCode; Employee."Employee's Bank")
            {
            }
            column(Banks_Name; GetBankName(Employee."Employee's Bank"))
            {
            }
            column(Branch_Name; Employee."Employee Branch Name")
            {
            }
            column(General_Payslip_Message; HRSetup."General Payslip Message")
            {
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

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        HRSetup.Get();

    end;

    var
        CompanyInfo: Record "Company Information";
        HRSetup: Record "Human Resources Setup";

    procedure GetBankName("Code": Code[20]): Text[250]
    var
        Banks: Record Banks;
    begin
        if Banks.Get(Code) then
            exit(Banks.Name);
    end;

    procedure GetName(No: Code[20]): Text[250]
    var
        Employee: Record Employee;
    begin
        if Employee.Get(No) then
            exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
}





