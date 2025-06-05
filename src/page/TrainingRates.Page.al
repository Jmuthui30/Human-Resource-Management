page 52171 "Training Rates"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Destination Rate Entry";
    Caption = 'Training Rates';
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
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Rate Type" := Rec."Rate Type"::Training;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Rate Type" := Rec."Rate Type"::Training;
    end;
}





