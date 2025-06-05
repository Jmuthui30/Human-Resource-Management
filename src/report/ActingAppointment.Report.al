report 52002 "Acting Appointment"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ActingAppointment.rdlc';
    Caption = 'Acting Appointment';
    dataset
    {
        dataitem("Employee Acting Position"; "Employee Acting Position")
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
            column(Doc_No; "Employee Acting Position".No)
            {
            }
            column(Acting_Employee_No; "Employee Acting Position"."Acting Employee No.")
            {
            }
            column(Acting_Date; "Employee Acting Position"."Start Date")
            {
            }
            column(Acting_Position; GetGrade("Employee Acting Position".Position))
            {
            }
            column(Job_Description; "Employee Acting Position"."Job Description")
            {
            }
            column(Employee_Name; EmplName)
            {
            }
            column(Employee_Grade; EmpGrade)
            {
            }
            column(Current_Position; EmpCurrPos)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetRange("Document Type", "Employee Acting Position"."Document Type"::Acting);

                Employee.Reset();
                Employee.SetRange("No.", "Acting Employee No.");
                if Employee.Find('-') then begin
                    EmpCurrPos := Employee."Job Title";
                    EmplName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    EmpGrade := Employee."Salary Scale";
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
        Employee: Record Employee;
        EmpGrade: Code[20];
        EmpCurrPos: Text;
        EmplName: Text[200];

    procedure GetGrade("Code": Code[20]): Code[20]
    var
        Jobs: Record "Company Job";
    begin
        if Jobs.Get(Code) then
            exit(Jobs.Grade);
    end;
}





