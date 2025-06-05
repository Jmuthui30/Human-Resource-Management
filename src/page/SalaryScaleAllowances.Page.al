page 52001 "Salary Scale Allowances"
{
    ApplicationArea = All;
    Caption = 'Salary Scale Allowances';
    PageType = ListPart;
    SourceTable = "Salary Scale Allowance";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Earning Code"; Rec."Earning Code")
                {
                    ToolTip = 'Specifies the value of the Earning Code field.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Earning Description"; Rec."Earning Description")
                {
                    ToolTip = 'Specifies the value of the Earning Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}






