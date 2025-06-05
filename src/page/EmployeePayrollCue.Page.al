page 52250 "Employee Payroll Cue"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Employee Payroll Cue";
    Caption = 'Employee Payroll Cue';
    layout
    {
        area(content)
        {
            cuegroup("Employee Statistics")
            {
                field("All Employees"; Rec."All Employees")
                {
                    DrillDownPageId = "Employee List";
                    ToolTip = 'Specifies the value of the All Employees field';
                    Visible = false;
                }
                field("Active Employees"; Rec."Active Employees")
                {
                    DrillDownPageId = "Employee List-Filtered";
                    ToolTip = 'Specifies the value of the Active Employees field';
                }
                field("Board Employees"; Rec."Board Employees")
                {
                    DrillDownPageId = "Trustee Employees";
                    ToolTip = 'Specifies the value of the Board Members field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}





