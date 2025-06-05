page 52236 "Loan Product Type Setup"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Loan Product Type-Payroll";
    Caption = 'Loan Product Type Setup';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Interest Calculation Method field';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate (Annual) field';
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                    Caption = 'Maximum no. of installments';
                    ToolTip = 'Specifies the value of the Maximum no. of installments field';
                }
                field("Loan No Series"; Rec."Loan No Series")
                {
                    ToolTip = 'Specifies the value of the Loan No Series field';
                }
                field(Rounding; Rec.Rounding)
                {
                    ToolTip = 'Specifies the value of the Rounding field';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ToolTip = 'Specifies the value of the Rounding Precision field';
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ToolTip = 'Specifies the value of the Loan Category field';
                }
                field("Calculate Interest"; Rec."Calculate Interest")
                {
                    ToolTip = 'Specifies the value of the Calculate Interest field';
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Interest Deduction Code field';
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Deduction Code field';
                }
                field(Internal; Rec.Internal)
                {
                    ToolTip = 'Specifies the value of the Internal field';
                }
                field("Interest Receivable Account"; Rec."Interest Receivable Account")
                {
                    ToolTip = 'Specifies the value of the Interest Receivable Account field';
                }
            }
        }
    }

    actions
    {
    }
}





