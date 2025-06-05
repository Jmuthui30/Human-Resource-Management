page 52028 "Job Requirements Lines"
{
    ApplicationArea = All;
    Caption = 'Job Qualifications';
    PageType = ListPart;
    SourceTable = "Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ToolTip = 'Specifies the value of the Qualification Type field';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field(Qualification; Rec.Qualification)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qualification field';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field("Job Specification"; Rec."Job Specification")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job Specification field';
                }
            }
        }
    }

    actions
    {
    }
}





