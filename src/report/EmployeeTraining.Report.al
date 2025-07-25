report 52006 "Employee Training"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeTraining.rdlc';
    Caption = 'Employee Training';
    dataset
    {
        dataitem("Employees Travelling"; "Employees Travelling")
        {
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
            column(Employee_No; "Employees Travelling"."Employee No")
            {
            }
            column(Employee_Name; "Employees Travelling"."Employee Name")
            {
            }
            column(Tuition_Fee; "Employees Travelling"."Tuition Fee")
            {
            }
            column(Per_Diem; "Employees Travelling"."Per Diem")
            {
            }
            column(Air_Ticket; "Employees Travelling"."Air Ticket")
            {
            }
            column(Total_Cost; "Employees Travelling"."Total Cost")
            {
            }
            column(Request_No; RequestNo)
            {
            }
            column(Venue; Venue)
            {
            }
            column(From; StartDate)
            {
            }
            column("To"; EndDate)
            {
            }
            column(Employee_Dept; Employee."Global Dimension 1 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin

                Training.Reset();
                Training.SetRange("Employee No", "Employee No");
                Training.SetRange("Request No.", "Request No.");
                if Training.Find('-') then begin
                    RequestNo := Training."Request No.";
                    StartDate := Training."Planned Start Date";
                    EndDate := Training."Planned End Date";
                    Venue := Training.Venue;
                end;

                Employee.Reset();
                Employee.SetRange("No.", "Employees Travelling"."Employee No");
                if Employee.Find('-') then
                    Department := Employee."Global Dimension 1 Code";
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
        Employee: Record Employee;
        Training: Record "Training Request";
        Department: Code[10];
        RequestNo: Code[50];
        EndDate: Date;
        StartDate: Date;
        Venue: Text;
}





