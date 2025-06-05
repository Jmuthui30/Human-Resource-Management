page 52034 "Vehicle Equipment"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Vehicle Equipment";
    Caption = 'Vehicle Equipment';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vehicle No"; Rec."Vehicle No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Vehicle No field';
                }
                field(Item; Rec.Item)
                {
                    ToolTip = 'Specifies the value of the Item field';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field';
                }
                field(Available; Rec.Available)
                {
                    ToolTip = 'Specifies the value of the Available field';
                }
            }
        }
    }

    actions
    {
    }
}





