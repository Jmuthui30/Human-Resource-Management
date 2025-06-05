page 52140 "Practical Interview"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Practical Interview";
    Caption = 'Practical Interview';
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
                    Visible = false;
                    ToolTip = 'Specifies the value of the Need Code field';
                }
                field("Panel Member"; Rec."Panel Member")
                {
                    ToolTip = 'Specifies the value of the Panel Member field';
                }
                field("Test Parameter"; Rec."Test Parameter")
                {
                    ToolTip = 'Specifies the value of the Test Parameter field';
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





