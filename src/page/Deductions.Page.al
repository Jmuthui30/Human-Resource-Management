
page 52230 "Deductions"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = Deductions;
    Caption = 'Deductions';
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
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Tax deductible"; Rec."Tax deductible")
                {
                    ToolTip = 'Specifies the value of the Tax deductible field';
                }
                field("Start date"; Rec."Start date")
                {
                    ToolTip = 'Specifies the value of the Start date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Calculation Method field';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field';
                }
                field("Deduction Table"; Rec."Deduction Table")
                {
                    ToolTip = 'Specifies the value of the Deduction Table field';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                    ToolTip = 'Specifies the value of the Flat Amount field';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
                field("Account Type Employer"; Rec."Account Type Employer")
                {
                    ToolTip = 'Specifies the value of the Account Type Employer field';
                }
                field("Account No. Employer"; Rec."Account No. Employer")
                {
                    ToolTip = 'Specifies the value of the Account No. Employer field';
                }
                field("Percentage Employer"; Rec."Percentage Employer")
                {
                    ToolTip = 'Specifies the value of the Percentage Employer field';
                }
                field("Flat Amount Employer"; Rec."Flat Amount Employer")
                {
                    ToolTip = 'Specifies the value of the Flat Amount Employer field';
                }
                field("Total Amount Employer"; Rec."Total Amount Employer")
                {
                    ToolTip = 'Specifies the value of the Total Amount Employer field';
                }
                field(Loan; Rec.Loan)
                {
                    ToolTip = 'Specifies the value of the Loan field';
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ToolTip = 'Specifies the value of the Maximum Amount field';
                }
                field("Pension Scheme"; Rec."Pension Scheme")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme field';
                }
                field("Show Balance"; Rec."Show Balance")
                {
                    ToolTip = 'Specifies the value of the Show Balance field';
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ToolTip = 'Specifies the value of the Balance Type field';
                }
                field("Show on report"; Rec."Show on report")
                {
                    ToolTip = 'Specifies the value of the Show on report field';
                }
                field("PAYE Code"; Rec."PAYE Code")
                {
                    ToolTip = 'Specifies the value of the PAYE Code field';
                }
                field("Secondary PAYE"; Rec."Secondary PAYE")
                {
                    ToolTip = 'Specifies the value of the Secondary PAYE field';
                }
                field("Applies to All"; Rec."Applies to All")
                {
                    ToolTip = 'Specifies the value of the Applies to All field';
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                    ToolTip = 'Specifies the value of the Show on Master Roll field';
                }
                field("Pension Scheme Code"; Rec."Pension Scheme Code")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme Code field';
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ToolTip = 'Specifies the value of the Insurance Code field';
                }
                field(Block; Rec.Block)
                {
                    ToolTip = 'Specifies the value of the Block field';
                }
                field("Show on Payslip Information"; Rec."Show on Payslip Information")
                {
                    ToolTip = 'Specifies the value of the Show on Payslip Information field';
                }
                field(Voluntary; Rec.Voluntary)
                {
                    ToolTip = 'Specifies the value of the Voluntary field';
                }
                field("Voluntary Percentage"; Rec."Voluntary Percentage")
                {
                    ToolTip = 'Specifies the value of the Voluntary Percentage field';
                }
                field("Voluntary Amount"; Rec."Voluntary Amount")
                {
                    ToolTip = 'Specifies the value of the Voluntary Amount field';
                }
                field("Voluntary Code"; Rec."Voluntary Code")
                {
                    ToolTip = 'Specifies the value of the Voluntary Code field';
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                    ToolTip = 'Specifies the value of the Loan Interest field';
                }
                field("Customer Entry"; Rec."Customer Entry")
                {
                    ToolTip = 'Specifies the value of the Customer Entry field';
                }
                field("Sacco Deduction"; Rec."Sacco Deduction")
                {
                    ToolTip = 'Specifies the value of the Sacco Deduction field';
                }
                field("Exclude Employer Balance"; Rec."Exclude Employer Balance")
                {
                    ToolTip = 'Specifies the value of the Exclude Employer Balance field';
                }
                field(NSSF; Rec.NSSF)
                {
                    ToolTip = 'Specifies the value of the NSSF field';
                }
                field(NHIF; Rec.NHIF)
                {
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field("Exempt from a third rule"; Rec."Exempt from a third rule")
                {
                    ToolTip = 'Specifies the value of the Exempt from a third rule field';
                }
                field("Check Probation End Date"; Rec."Check Probation End Date")
                {
                    ToolTip = 'Specifies the value of the Check Probation field.';
                }
                field(Advance; Rec.Advance)
                {
                    ToolTip = 'Specifies the value of the Advance field';
                }
                field("Housing Levy"; Rec."Housing Levy")
                {
                    ToolTip = 'Specifies the value of the Housing Levy field.', Comment = '%';
                }
                field("Employer Contibution Taxed"; Rec."Employer Contibution Taxed")
                {
                    ToolTip = 'Specifies the value of the Employer Contibution Taxed field.', Comment = '%';
                }
                field("Pension Limit Percentage"; Rec."Pension Limit Percentage")
                {
                    ToolTip = 'Specifies the value of the Pension Limit Percentage field';
                    Visible = false;
                }
                field("Pension Limit Amount"; Rec."Pension Limit Amount")
                {
                    ToolTip = 'Specifies the value of the Pension Limit Amount field';
                    Visible = false;
                }
                field("Grace period"; Rec."Grace period")
                {
                    ToolTip = 'Specifies the value of the Grace period field';
                    Visible = false;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Repayment Period field';
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ToolTip = 'Specifies the value of the Minimum Amount field';
                    Visible = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ToolTip = 'Specifies the value of the Loan Type field';
                    Visible = false;
                }
                field(CoinageRounding; Rec.CoinageRounding)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the CoinageRounding field';
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Opening Balance field';
                }
                field("Main Loan Code"; Rec."Main Loan Code")
                {
                    ToolTip = 'Specifies the value of the Main Loan Code field';
                    Visible = false;
                }
                field(Shares; Rec.Shares)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shares field';
                }
                field("Non-Interest Loan"; Rec."Non-Interest Loan")
                {
                    ToolTip = 'Specifies the value of the Non-Interest Loan field';
                    Visible = false;
                }
                field("Exclude when on Leave"; Rec."Exclude when on Leave")
                {
                    ToolTip = 'Specifies the value of the Exclude when on Leave field';
                    Visible = false;
                }
                field("Co-operative"; Rec."Co-operative")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Co-operative field';
                }
                field("Total Shares"; Rec."Total Shares")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Shares field';
                }
                field(Rate; Rec.Rate)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Rate field';
                }
                field("Total Days"; Rec."Total Days")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Days field';
                }
                field("Housing Earned Limit"; Rec."Housing Earned Limit")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Housing Earned Limit field';
                }
                field("Main Deduction Code"; Rec."Main Deduction Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Main Deduction Code field';
                }
                field("Institution Code"; Rec."Institution Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Institution Code field';
                }
                field("Owner Occupied Interest"; Rec."Owner Occupied Interest")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Owner Occupied Interest field';
                }
                field("Share Top Up"; Rec."Share Top Up")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Share Top Up field';
                }
                field(Statutories; Rec.Statutories)
                {
                    ToolTip = 'Specifies the value of the Statutories field';
                    Visible = false;
                }
                field(Imprest; Rec.Imprest)
                {
                    ToolTip = 'Specifies the value of the Imprest field';
                    Visible = false;
                }
                field(HELB; Rec.HELB)
                {
                    ToolTip = 'Specifies the value of the HELB field';
                    Visible = false;
                }
                field(NITA; Rec.NITA)
                {
                    ToolTip = 'Specifies the value of the NITA field';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Other Earnings")
            {
                Caption = '% of Other Earnings';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Other Deduction";
                RunPageLink = "Main Deduction" = field(Code);
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
}





