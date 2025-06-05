page 52150 "Classroom Interview"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Classroom Interview";
    Caption = 'Classroom Interview';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No field';
                }
                field("Need Code"; Rec."Need Code")
                {
                    ToolTip = 'Specifies the value of the Need Code field';
                }
                field("Panel Member"; Rec."Panel Member")
                {
                    ToolTip = 'Specifies the value of the Panel Member field';
                }
                field("Test Parameters"; Rec."Test Parameters")
                {
                    ToolTip = 'Specifies the value of the Test Parameters field';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
            }
        }
    }

    actions
    {
    }
}





