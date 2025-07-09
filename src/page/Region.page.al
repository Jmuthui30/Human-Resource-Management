page 52990 Region
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    SourceTable = Region;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'The Tooltip property for PageField Code must be filled';
                }
                field("Address Format"; Rec."Address Format")
                {
                    ToolTip = 'The Tooltip property for PageField "Address Format" must be filled.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}