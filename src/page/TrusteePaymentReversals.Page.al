page 52263 "Trustee Payment Reversals"
{
    ApplicationArea = All;
    CardPageID = "Trustee Payment Reversal";
    PageType = List;
    SourceTable = "Trustee Payment Reversal";
    SourceTableView = where(Posted = filter(false));
    Caption = 'Trustee Payment Reversals';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                }
            }
        }
    }

    actions
    {
    }
}





