page 52026 "Positions Supervising"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Positions Supervised";
    Caption = 'Positions Supervising';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Position Supervised"; Rec."Position Supervised")
                {
                    ToolTip = 'Specifies the value of the Position Supervised field';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
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





