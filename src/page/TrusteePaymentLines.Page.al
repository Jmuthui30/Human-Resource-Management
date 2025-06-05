page 52265 "Trustee Payment Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Trustee Reversal Lines";
    Caption = 'Trustee Payment Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trustee No"; Rec."Trustee No")
                {
                    ToolTip = 'Specifies the value of the Trustee No field';
                }
                field("Trustee Name"; Rec."Trustee Name")
                {
                    ToolTip = 'Specifies the value of the Trustee Name field';
                }
                field("Pay Period"; Rec."Pay Period")
                {
                    ToolTip = 'Specifies the value of the Pay Period field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    ToolTip = 'Specifies the value of the Total Allowances field';
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                    ToolTip = 'Specifies the value of the Taxable Allowance field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field';
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ToolTip = 'Specifies the value of the Net Pay field';
                }
            }
        }
    }

    actions
    {
    }
}





