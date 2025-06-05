page 52096 "Interview Panel Members"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Interview Panel Members";
    Caption = 'Interview Panel Members';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ShowMandatory = true;
                }
                field("Panel Member Code"; Rec."Panel Member Code")
                {
                    ToolTip = 'Specifies the value of the Panel Member Code field';
                }
                field("Panel Member Name"; Rec."Panel Member Name")
                {
                    ToolTip = 'Specifies the value of the Panel Member Name field';
                }
            }
        }
    }

    actions
    {
    }
}





