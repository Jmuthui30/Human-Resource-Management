page 52098 "Score Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Score Setup";
    Caption = 'Score Setup';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Score ID"; Rec."Score ID")
                {
                    ToolTip = 'Specifies the value of the Score ID field';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field';
                }
            }
        }
    }

    actions
    {
    }
}





