page 52231 "Loan Product Types-Payroll"
{
    ApplicationArea = All;
    CardPageID = "Loan Product Type Setup";
    PageType = List;
    SourceTable = "Loan Product Type-Payroll";
    SourceTableView = where(TPS = const(false));
    Caption = 'Loan Product Types-Payroll';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate (Annual) field';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Interest Calculation Method field';
                }
                field("No Series"; Rec."No Series")
                {
                    ToolTip = 'Specifies the value of the No Series field';
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                    ToolTip = 'Specifies the value of the No of Instalment field';
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





