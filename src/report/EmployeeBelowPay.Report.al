report 52061 "Employee Below Pay"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeBelowPay.rdlc';
    Caption = 'Employee Below Pay';
    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix")
        {
            DataItemTableView = where("Employee type" = filter(<> trustee));
            RequestFilterFields = "Payroll Period";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Comp_Phone; CompanyInfo."Phone No.")
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
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
            column(Employee_No; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Type; "Assignment Matrix-X".Type)
            {
            }
            column(Payroll_Period; UpperCase(Format("Assignment Matrix-X"."Payroll Period", 0, '<Month Text> <year4>')))
            {
            }
            column(Amount; "Assignment Matrix-X".Amount)
            {
            }
            column(Employee_Name; GetName("Assignment Matrix-X"."Employee No"))
            {
            }
            column(Gross_Pay; GrossPay)
            {
            }
            column(Basic_Pay; BasicPay)
            {
            }
            column(Total_Deductions; Deductions)
            {
            }

            trigger OnAfterGetRecord()
            begin

                AssignMatrix.Reset();
                AssignMatrix.SetRange(AssignMatrix."Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                AssignMatrix.SetRange(Taxable, true);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    GrossPay := AssignMatrix.Amount;
                end;

                AssignMatrix.Reset();
                AssignMatrix.SetRange("Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange("Basic Salary Code", true);
                if AssignMatrix.Find('-') then
                    BasicPay := AssignMatrix.Amount;

                AssignMatrix.Reset();
                AssignMatrix.SetRange("Payroll Period", "Payroll Period");
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    Deductions := AssignMatrix.Amount;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
            }
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

        Period := "Assignment Matrix-X".GetFilter("Payroll Period");
        if Period = '' then
            Error(PayPeriodErr);
    end;

    var
        AssignMatrix: Record "Assignment Matrix";
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        BasicPay: Decimal;
        Deductions: Decimal;
        GrossPay: Decimal;
        PayPeriodErr: Label 'Pay Period cannot be blank. Kindly Specify the Period.';
        Period: Text;

    procedure GetName(No: Code[20]): Text[250]
    begin
        if Employee.Get(No) then
            exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
}





