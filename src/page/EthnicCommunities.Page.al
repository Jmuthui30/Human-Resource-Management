page 52123 "Ethnic Communities"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Ethnic Communities";
    Caption = 'Ethnic Communities';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ethnic Code"; Rec."Ethnic Code")
                {
                    ToolTip = 'Specifies the value of the Ethnic Code field';
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    ToolTip = 'Specifies the value of the Ethnic Name field';
                }
            }
        }
    }

    actions
    {
    }
}





