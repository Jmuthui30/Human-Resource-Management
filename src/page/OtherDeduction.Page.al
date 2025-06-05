page 52225 "Other Deduction"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Other Deductions";
    Caption = 'Other Deduction';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code"; Rec."Earning Code")
                {
                    ToolTip = 'Specifies the value of the Earning Code field';
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





