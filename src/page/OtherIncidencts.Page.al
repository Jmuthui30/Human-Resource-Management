page 52072 "Other Incidencts"
{
    ApplicationArea = All;
    Caption = 'Closed Disciplinary Cases';
    CardPageID = "Employee Disciplinary Case";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Discplinary";
    SourceTableView = where(Posted = filter(true));

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
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field';
                }
            }
        }
    }

    actions
    {
    }
}





