page 52076 "Travel Expense"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Travel Expense";
    Caption = 'Travel Expense';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Quantity; Rec.Quantity)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field("Fuel Amount"; Rec."Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Requested Amount field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Available Budget"; Rec."Available Budget")
                {
                    ToolTip = 'Specifies the value of the Available Budget field';
                }
            }
        }
    }

    actions
    {
    }
}





