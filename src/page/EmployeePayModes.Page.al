page 52251 "Employee Pay Modes"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Employee Pay Modes";
    Caption = 'Employee Pay Modes';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field';
                }
                field("Total Earnings"; Rec."Total Earnings")
                {
                    ToolTip = 'Specifies the value of the Total Earnings field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field';
                }
                field("Net Pay A/C"; Rec."Net Pay A/C")
                {
                    ToolTip = 'Specifies the value of the Net Pay A/C field';
                }
            }
        }
    }

    actions
    {
    }
}





