report 52047 "KNBS Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/KNBSReport.rdlc';
    Caption = 'KNBS Report';
    dataset
    {
        dataitem(Employee; Employee)
        {
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
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
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Contract_Female; ContractFemale)
            {
            }
            column(Contract_Male; ContractMale)
            {
            }
            column(Permanent_Female; PermanentMale)
            {
            }
            column(Permanent_Male; PermanentFemale)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Emp2.Reset();
                Emp2.SetRange("Employment Type", Employee."Employment Type"::Contract);
                if Emp2.Find('-') then
                    case Emp2.Gender of
                        Emp2.Gender::Female:

                            ContractFemale := Emp2.Count;
                        Emp2.Gender::Male:

                            ContractMale := Emp2.Count;
                    end;

                Emp2.Reset();
                Emp2.SetRange("Employment Type", Employee."Employment Type"::Permanent);
                if Emp2.Find('-') then
                    case Emp2.Gender of
                        Emp2.Gender::Female:

                            PermanentFemale := Emp2.Count;
                        Emp2.Gender::Male:

                            PermanentMale := Emp2.Count;
                    end;
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
        Emp2: Record Employee;
        ContractFemale: Integer;
        ContractMale: Integer;
        PermanentFemale: Integer;
        PermanentMale: Integer;
}





