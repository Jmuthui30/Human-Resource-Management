page 52227 "Scale Benefits"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Scale Benefits";
    Caption = 'Scale Benefits';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Salary Scale"; Rec."Salary Scale")
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
                field("Salary Pointer"; Rec."Salary Pointer")
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Salary Pointer field';
                }
                field("ED Code"; Rec."ED Code")
                {
                    Caption = 'Earning Code';
                    ToolTip = 'Specifies the value of the Earning Code field';
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                    ToolTip = 'Specifies the value of the Basic Salary Code field.';
                }
                field("ED Description"; Rec."ED Description")
                {
                    Caption = 'Earning Description';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Earning Description field';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the G/L Account field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Payment Option"; Rec."Payment Option")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Payment Option field';
                }
                field(Rate; Rec.Rate)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Rate field';
                }
            }
        }
    }

    actions
    {
    }
}





