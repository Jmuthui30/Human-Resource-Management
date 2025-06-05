page 52035 "Disciplinary Cases"
{
    ApplicationArea = All;
    Caption = 'Types of hearing';
    PageType = List;
    SourceTable = "Disciplinary Cases";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ToolTip = 'Specifies the value of the Recommended Action field';
                }
                field("Action Description"; Rec."Action Description")
                {
                    ToolTip = 'Specifies the value of the Action Description field';
                }
            }
        }
    }

    actions
    {
    }
}





