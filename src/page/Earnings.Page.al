page 52229 "Earnings"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = Earnings;
    Caption = 'Earnings';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = Description;
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    ToolTip = 'Specifies the value of the Pay Type field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Taxable; Rec.Taxable)
                {
                    ToolTip = 'Specifies the value of the Taxable field';
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Calculation Method field';
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                    ToolTip = 'Specifies the value of the Flat Amount field';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field';
                }
                field("Tax Free Amount"; Rec."Tax Free Amount")
                {
                    ToolTip = 'Specifies the value of the Tax Free Amount field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
                field(Formula; Rec.Formula)
                {
                    ToolTip = 'Specifies the value of the Formula field';
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                    ToolTip = 'Specifies the value of the Non-Cash Benefit field';
                }
                field("Minimum Limit"; Rec."Minimum Limit")
                {
                    ToolTip = 'Specifies the value of the Minimum Limit field';
                }
                field("Maximum Limit"; Rec."Maximum Limit")
                {
                    ToolTip = 'Specifies the value of the Maximum Limit field';
                }
                field("Reduces Tax"; Rec."Reduces Tax")
                {
                    ToolTip = 'Specifies the value of the Reduces Tax field';
                }
                field("Overtime Workday Factor"; Rec."Overtime Workday Factor")
                {
                    ToolTip = 'Specifies the value of the Overtime Workday Factor field.';
                    Editable = Rec.OverTime;
                }
                field("Overtime Non Working Factor"; Rec."Overtime Non Working Factor")
                {
                    ToolTip = 'Specifies the value of the Overtime Non Working Factor field.';
                    Editable = Rec.OverTime;
                }
                field("Show Balance"; Rec."Show Balance")
                {
                    ToolTip = 'Specifies the value of the Show Balance field';
                }
                field(OverTime; Rec.OverTime)
                {
                    ToolTip = 'Specifies the value of the OverTime field';
                }
                field("Show on Report"; Rec."Show on Report")
                {
                    ToolTip = 'Specifies the value of the Show on Report field';
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                    ToolTip = 'Specifies the value of the Basic Salary Code field';
                }
                field("Earning Type"; Rec."Earning Type")
                {
                    ToolTip = 'Specifies the value of the Earning Type field';
                }
                field("Applies to All"; Rec."Applies to All")
                {
                    ToolTip = 'Specifies the value of the Applies to All field';
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                    ToolTip = 'Specifies the value of the Show on Master Roll field';
                }
                field("House Allowance Code"; Rec."House Allowance Code")
                {
                    ToolTip = 'Specifies the value of the House Allowance Code field';
                }
                field("Responsibility Allowance Code"; Rec."Responsibility Allowance Code")
                {
                    ToolTip = 'Specifies the value of the Responsibility Allowance Code field';
                }
                field("Commuter Allowance Code"; Rec."Commuter Allowance Code")
                {
                    ToolTip = 'Specifies the value of the Commuter Allowance Code field';
                }
                field("Travel Allowance"; Rec."Travel Allowance")
                {
                    ToolTip = 'Specifies the value of the Travel Allowance field.';
                }
                field(Block; Rec.Block)
                {
                    ToolTip = 'Specifies the value of the Block field';
                }
                field("Basic Pay Arrears"; Rec."Basic Pay Arrears")
                {
                    ToolTip = 'Specifies the value of the Basic Pay Arrears field';
                }
                field("Pensionable Pay"; Rec."Pensionable Pay")
                {
                    ToolTip = 'Specifies the value of the Pensionable Pay field';
                }
                field("Yearly Bonus"; Rec."Yearly Bonus")
                {
                    ToolTip = 'Specifies the value of the Yearly Bonus field';
                }
                field("Leave Allowance"; Rec."Leave Allowance")
                {
                    ToolTip = 'Specifies the value of the Leave Allwance field';
                }
                field(Gratuity; Rec.Gratuity)
                {
                    ToolTip = 'Specifies the value of the Gratuity field';
                }
                field("Acting Allowance"; Rec."Acting Allowance")
                {
                    ToolTip = 'Specifies the value of the Acting Allowance field';
                }
                field("Salary Arrears Code"; Rec."Salary Arrears Code")
                {
                    ToolTip = 'Specifies the value of the Salary Arrears Code field';
                }
                field(BoardSittingAllowance; Rec.BoardSittingAllowance)
                {
                    ToolTip = 'Specifies the value of the BoardSittingAllowance field';
                }
                field(Prorate; Rec.Prorate)
                {
                    ToolTip = 'Specifies the value of the Prorate field';
                }
                field(Quarters; Rec.Quarters)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quarters field';
                }
                field(Counter; Rec.Counter)
                {
                    ToolTip = 'Specifies the value of the Counter field';
                    Visible = false;
                }
                field(NoOfUnits; Rec.NoOfUnits)
                {
                    ToolTip = 'Specifies the value of the NoOfUnits field';
                    Visible = false;
                }
                field("Low Interest Benefit"; Rec."Low Interest Benefit")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Low Interest Benefit field';
                }
                field(CoinageRounding; Rec.CoinageRounding)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the CoinageRounding field';
                }
                field(OverDrawn; Rec.OverDrawn)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the OverDrawn field';
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Opening Balance field';
                }
                field(Months; Rec.Months)
                {
                    ToolTip = 'Specifies the value of the Months field';
                    Visible = false;
                }
                field("Time Sheet"; Rec."Time Sheet")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Time Sheet field';
                }
                field("Total Days"; Rec."Total Days")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Days field';
                }
                field("Total Hrs"; Rec."Total Hrs")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Hrs field';
                }
                field(Weekend; Rec.Weekend)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Weekend field';
                }
                field(Weekday; Rec.Weekday)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Weekday field';
                }
                field("Default Enterprise"; Rec."Default Enterprise")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Default Enterprise field';
                }
                field("Default Activity"; Rec."Default Activity")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Default Activity field';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    ToolTip = 'Specifies the value of the Per Diem field';
                    Visible = false;
                }
                field("Supension Earnings Percentage"; Rec."Supension Earnings Percentage")
                {
                    ToolTip = 'Specifies the value of the Supension Earnings Percentage field';
                    Visible = false;
                }
                field("Requires Employee Request"; Rec."Requires Employee Request")
                {
                    ToolTip = 'Specifies the value of the Requires Employee Request field';
                    Visible = false;
                }
                field("Casual Code"; Rec."Casual Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Casual Code field';
                }
                field("Special Duty"; Rec."Special Duty")
                {
                    ToolTip = 'Specifies the value of the Special Duty field';
                    Visible = false;
                }
                field("Exclude Gross Pay Deduction"; Rec."Exclude Gross Pay Deduction")
                {
                    ToolTip = 'Specifies the value of the Exclude Gross Pay Deduction field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mass Update Earnings&Deductions")
            {
                Caption = 'Mass Update Earnings & Deductions';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageOnRec = true;
                ToolTip = 'Executes the Mass Update Earnings & Deductions action';
                Image = Payment;

                trigger OnAction()
                begin
                    EarningsMassUpdate.GetEarnings(Rec);
                    EarningsMassUpdate.Run();
                end;
            }
            action("Other Earnings")
            {
                Caption = '% of Other Earnings';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Other Earnings";
                RunPageLink = "Main Earning" = field(Code);
                ToolTip = 'Executes the % of Other Earnings action';
                Enabled = Rec."Calculation Method" = Rec."Calculation Method"::"% of Other Earnings";
            }
            action("Other Deductions")
            {
                Caption = '% of Other Deductions';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Other Deduction Lines";
                RunPageLink = "Main Code" = field(Code);
                ToolTip = 'Executes the % of Other Earnings action.';
                Enabled = Rec."Calculation Method" = Rec."Calculation Method"::"% of Other Deductions";
            }
        }
    }

    var
        EarningsMassUpdate: Report "Earnings Mass Update";
}





