page 52267 "Loan Interest List-Payroll"
{
    ApplicationArea = All;
    CardPageID = "Loan Interest Card-Payroll";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Header";
    SourceTableView = where(Posted = const(false));
    Caption = 'Loan Interest List-Payroll';
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





