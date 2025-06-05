report 52000 "Allowance Register"
{
    ApplicationArea = All;
    Caption = 'Allowance Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/AllowanceRegister.rdl';
    dataset
    {
        dataitem(AllowanceRegister; "Allowance Register")
        {
            RequestFilterFields = "No.", Status, "Employee Type", "Payroll Period";
            column(No; "No.")
            {
            }
            column(EmployeeType; "Employee Type")
            {
            }
            column(PayrollPeriod; "Payroll Period")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(Status; Status)
            {
            }
            column(DateofActivity; "Date of Activity")
            {
            }
            column(TotalAmount; "Total Amount")
            {
            }
            column(TotalNetAmount; "Total Net Amount")
            {
            }
            column(TotalPAYE; "Total PAYE")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(Company_Name; CompanyInfo.Name)
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
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            dataitem("Allowance Register Line"; "Allowance Register Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Employee Type", "Employee No.", "Earning Code", "Date of Activity");

                column(EmployeeNo_AllowanceRegisterLine; "Employee No.")
                {
                }
                column(DocumentNo_AllowanceRegisterLine; "Document No.")
                {
                }
                column(EmployeeName_AllowanceRegisterLine; "Employee Name")
                {
                }
                column(Amount_AllowanceRegisterLine; Amount)
                {
                }
                column(DateofActivity_AllowanceRegisterLine; "Date of Activity")
                {
                }
                column(EarningCode_AllowanceRegisterLine; "Earning Code")
                {
                }
                column(EarningDescription_AllowanceRegisterLine; "Earning Description")
                {
                }
                column(NetAmount_AllowanceRegisterLine; "Net Amount")
                {
                }
                column(PAYEAmount_AllowanceRegisterLine; "PAYE Amount")
                {
                }
                column(Remarks_AllowanceRegisterLine; Remarks)
                {
                }
                column(DestinationCode_AllowanceRegisterLine; "Destination Code")
                {
                }
                column(Noofsittings_AllowanceRegisterLine; "No of sittings")
                {
                }
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






