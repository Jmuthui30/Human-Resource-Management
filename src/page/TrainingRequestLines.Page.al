page 52187 "Training Request Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Request Lines";
    Caption = 'Training Request Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                    ToolTip = 'Specifies the value of the Expense Code field';
                }
                field("Expense Name"; Rec."Expense Name")
                {
                    ToolTip = 'Specifies the value of the Expense Name field';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    ToolTip = 'Specifies the value of the Per Diem field';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount (LCY) field';
                }
                field("Document No."; Rec."Document No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
            }
        }
    }

    actions
    {
    }
}





