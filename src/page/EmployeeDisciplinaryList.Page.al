page 52029 "Employee Disciplinary List"
{
    ApplicationArea = All;
    CardPageID = "Employee Disciplinary Case";
    PageType = List;
    SourceTable = "Employee Discplinary";
    Caption = 'Employee Disciplinary List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Disciplinary Nos"; Rec."Disciplinary Nos")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Nos field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Date of Join"; Rec."Date of Join")
                {
                    ToolTip = 'Specifies the value of the Date of Join field';
                }
            }
        }
    }

    actions
    {
    }
}





