page 52233 "Emp Posting Group"
{
    ApplicationArea = All;
    Caption = 'Employee Posting Group';
    PageType = List;
    SourceTable = "Employee HR Posting Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ToolTip = 'Specifies the value of the Salary Account field';
                }
                field("PAYE Account"; Rec."PAYE Account")
                {
                    ToolTip = 'Specifies the value of the PAYE Account field';
                }
                field("Income Tax Account"; Rec."Income Tax Account")
                {
                    ToolTip = 'Specifies the value of the Income Tax Account field';
                }
                field("SSF Employer Account"; Rec."SSF Employer Account")
                {
                    ToolTip = 'Specifies the value of the SSF Employer Account field';
                }
                field("SSF Employee Account"; Rec."SSF Employee Account")
                {
                    ToolTip = 'Specifies the value of the SSF Employee Account field';
                }
                field("Net Salary Account Type"; Rec."Net Salary Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {
                    ToolTip = 'Specifies the value of the Net Salary Payable field';
                }
                field("Operating Overtime"; Rec."Operating Overtime")
                {
                    ToolTip = 'Specifies the value of the Operating Overtime field';
                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ToolTip = 'Specifies the value of the Tax Relief field';
                }
                field("Employee Provident Fund Acc."; Rec."Employee Provident Fund Acc.")
                {
                    ToolTip = 'Specifies the value of the Employee Provident Fund Acc. field';
                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {
                    ToolTip = 'Specifies the value of the Pension Employer Acc field';
                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {
                    ToolTip = 'Specifies the value of the Pension Employee Acc field';
                }
                field("Earnings and deductions"; Rec."Earnings and deductions")
                {
                    ToolTip = 'Specifies the value of the Earnings and deductions field';
                }
                field("Daily Salary"; Rec."Daily Salary")
                {
                    ToolTip = 'Specifies the value of the Daily Salary field';
                }
                field("Normal Overtime"; Rec."Normal Overtime")
                {
                    ToolTip = 'Specifies the value of the Normal Overtime field';
                }
                field("Weekend Overtime"; Rec."Weekend Overtime")
                {
                    ToolTip = 'Specifies the value of the Weekend Overtime field';
                }
                field(Seasonals; Rec.Seasonals)
                {
                    ToolTip = 'Specifies the value of the Seasonals field';
                }
                field(Pension; Rec.Pension)
                {
                    ToolTip = 'Specifies the value of the Pension field';
                }
            }
        }
    }

    actions
    {
    }
}





