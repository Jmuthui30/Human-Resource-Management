page 52287 "Training Plan"
{
    ApplicationArea = All;
    //Caption = 'Training Budget';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "G/L Budget Name";
    Caption = 'Training Plan';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Blocked field';
                }
            }
            part(Control8; "Training Budget Items")
            {
                SubPageLink = "Training Year" = field(Name);
            }
        }
    }

    actions
    {
    }
}





