page 52258 "Deductions Balances"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Deduction Balances";
    Caption = 'Deductions Balances';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Employee No';
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    Caption = 'Deduction Code';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Deduction Code field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    Caption = 'Loan Type';
                    ToolTip = 'Specifies the value of the Loan Type field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Caption = 'Reference No.';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                }
            }
        }
    }

    actions
    {
    }
}





