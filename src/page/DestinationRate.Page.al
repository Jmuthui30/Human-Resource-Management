page 52006 "Destination Rate"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Destination Rate Entry";
    Caption = 'Destination Rate';
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;

                field("Employee Job Group"; Rec."Employee Job Group")
                {
                    ToolTip = 'Specifies the value of the Employee Job Group field';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field';
                }
                field("Advance Code"; Rec."Advance Code")
                {
                    ToolTip = 'Specifies the value of the Expenditure Type field';
                }
                field("Daily Rate (Amount)"; Rec."Daily Rate (Amount)")
                {
                    ToolTip = 'Specifies the value of the Daily Rate (Amount) field';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field';
                    Visible = false;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field';
                    Visible = false;
                }
                field("Rate Type"; Rec."Rate Type")
                {
                    ToolTip = 'Specifies the value of the Rate Type field';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}





