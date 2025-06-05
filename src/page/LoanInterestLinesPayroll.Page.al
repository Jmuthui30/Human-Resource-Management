page 52269 "Loan Interest Lines-Payroll"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Loan Interest Lines";
    Caption = 'Loan Interest Lines-Payroll';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Period Reference"; Rec."Period Reference")
                {
                    ToolTip = 'Specifies the value of the Period Reference field';
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ToolTip = 'Specifies the value of the Loan Amount field';
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ToolTip = 'Specifies the value of the Loan Balance field';
                }
                field("Interest Due"; Rec."Interest Due")
                {
                    ToolTip = 'Specifies the value of the Interest Due field';
                }
            }
        }
    }

    actions
    {
    }
}





