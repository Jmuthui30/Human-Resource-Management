page 52244 "Loan Product Type list-Payroll"
{
    ApplicationArea = All;
    CardPageID = "Loan Product Type Setup";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Product Type-Payroll";
    Caption = 'Loan Product Type list-Payroll';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
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
            }
        }
    }

    actions
    {
    }
}





