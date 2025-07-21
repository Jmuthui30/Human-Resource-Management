report 52020 "Employment Contracts"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmploymentContracts.rdlc';
    Caption = 'Employment Contracts';
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "Employment Type", "No.";

            column(Comp_Name; CompanyInfo.Name)
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
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(County; CompanyInfo.County)
            {
            }
            column(EMail; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(Employee_Name; GetEmployeeName(Employee."No."))
            {
            }
            column(Retirement_Date; Employee."Retirement Date")
            {
            }
            column(Nature_of_Employment; Employee."Employment Type")
            {
            }
            column(Contract_Start; Employee."Contract Start Date")
            {
            }
            column(Contract_End; Employee."Contract End Date")
            {
            }
            column(RemainingPeriod; RemainingPeriod) { }
            column(DurationPeriod; DurationPeriod) { }
            trigger OnAfterGetRecord()
            begin

                if Employee."Contract End Date" = 0D then
                    DurationPeriod := 'Indefinite'
                else
                    DurationPeriod := HRDates.DetermineAge(Employee."Contract Start Date", Employee."Contract End Date");

                //**********************************************************************************
                if Employee."Contract End Date" = 0D then
                    RemainingPeriod := 'No EndDate'
                else if Employee."Contract End Date" < Today then
                    RemainingPeriod := 'Expired'
                else
                    RemainingPeriod := HRDates.DetermineAge(Today, Employee."Contract End Date");


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
        EmployeeRec: Record Employee;
        RemainingPeriod: Text;
        DurationPeriod: text;
        HRDates: Codeunit "Dates Management";


    procedure GetEmployeeName(No: Code[20]): Text[250]
    begin
        if EmployeeRec.Get(No) then
            exit(EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name");
    end;
}





