page 52271 "Reversed Loan Interests-Payrol"
{
    ApplicationArea = All;
    CardPageID = "Posted Loan Interest-Payroll";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Header";
    SourceTableView = where(Posted = const(true),
                            Reversed = const(true));
    Caption = 'Reversed Loan Interests-Payrol';
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
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Period Reference"; Rec."Period Reference")
                {
                    ToolTip = 'Specifies the value of the Period Reference field';
                }
                field("Period Narration"; Rec."Period Narration")
                {
                    ToolTip = 'Specifies the value of the Period Narration field';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field';
                }
            }
        }
    }

    actions
    {
    }
}





