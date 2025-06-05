page 52226 "Other Earnings"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Other Earnings";
    Caption = 'Other Earnings';
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





