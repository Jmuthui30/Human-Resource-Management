page 52046 "Recruitment Costs"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Recruitment Costs';
    PageType = ListPart;
    SourceTable = "Recruitment Cost";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                    ToolTip = 'Specifies the value of the Expense Code field.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}






