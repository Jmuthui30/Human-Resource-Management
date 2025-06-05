page 52120 "Disc Recommended Action"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Recommended Actions";
    Caption = 'Disc Recommended Action';
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
            }
        }
    }

    actions
    {
    }
}





