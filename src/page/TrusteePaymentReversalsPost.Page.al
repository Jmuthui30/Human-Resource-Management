page 52266 "Trustee Payment Reversals-Post"
{
    ApplicationArea = All;
    CardPageID = "Trustee Payment Reversal";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Trustee Payment Reversal";
    SourceTableView = where(Posted = const(true));
    Caption = 'Trustee Payment Reversals-Post';
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





