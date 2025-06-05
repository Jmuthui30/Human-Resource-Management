page 52238 "Tax Table"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Brackets";
    Caption = 'Tax Table';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table Code"; Rec."Table Code")
                {
                    ToolTip = 'Specifies the value of the Table Code field';
                }
                field("Tax Band"; Rec."Tax Band")
                {
                    ToolTip = 'Specifies the value of the Tax Band field';
                }
                field("Taxable Amount"; Rec."Taxable Amount")
                {
                    ToolTip = 'Specifies the value of the Taxable Amount field';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field';
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ToolTip = 'Specifies the value of the Lower Limit field';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Upper Limit field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
            }
        }
    }

    actions
    {
    }
}





