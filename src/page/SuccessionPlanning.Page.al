page 52051 "Succession Planning"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Employee;
    Caption = 'Succession Planning';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the value of the Initials field';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Deductions field';
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Taxable Allowance field';
                }
                field("Position TO Succeed"; Rec."Position TO Succeed")
                {
                    ToolTip = 'Specifies the value of the Position TO Succeed field';
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Earnings field';
                }
            }
        }
    }

    actions
    {
    }
}





