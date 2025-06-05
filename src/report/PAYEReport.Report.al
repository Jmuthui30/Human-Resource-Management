report 52046 "PAYE Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PAYEReport.rdlc';
    Caption = 'PAYE Report';
    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix")
        {
            trigger OnAfterGetRecord()
            begin

                AssignMatrix.Reset();
                AssignMatrix.SetRange("Employee No", "Employee No");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                if AssignMatrix.Find('-') then begin
                    Earnings.Reset();
                    Earnings.SetRange(Code, Code);
                    if Earnings.Find('-') then
                        if Earnings."Basic Salary Code" then
                            BasicSalary := AssignMatrix.Amount;
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

    var
        AssignMatrix: Record "Assignment Matrix";
        Earnings: Record Earnings;
        BasicSalary: Decimal;
}





