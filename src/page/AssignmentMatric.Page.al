page 52003 "Assignment Matric"
{
    ApplicationArea = All;
    Caption = 'Assignment Matric';
    PageType = List;
    SourceTable = "Assignment Matrix";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    Editable = true;
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field(BFPay; Rec.BFPay)
                {
                    ToolTip = 'Specifies the value of the BFPay field.';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field("Basic Pay Arrears"; Rec."Basic Pay Arrears")
                {
                    ToolTip = 'Specifies the value of the Basic Pay Arrears field.';
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                    ToolTip = 'Specifies the value of the Basic Salary Code field';
                }
                field(CFPay; Rec.CFPay)
                {
                    ToolTip = 'Specifies the value of the CFPay field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Commuter Allowance Code"; Rec."Commuter Allowance Code")
                {
                    ToolTip = 'Specifies the value of the Commuter Allowance Code field.';
                }
                field("Company Cummulative"; Rec."Company Cummulative")
                {
                    ToolTip = 'Specifies the value of the Company Cummulative field.';
                }
                field("Company Monthly Contribution"; Rec."Company Monthly Contribution")
                {
                    ToolTip = 'Specifies the value of the Company Monthly Contribution field.';
                }
                field(CreditAcct; Rec.CreditAcct)
                {
                    ToolTip = 'Specifies the value of the CreditAcct field.';
                }
                field(DebitAcct; Rec.DebitAcct)
                {
                    ToolTip = 'Specifies the value of the DebitAcct field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Earning/Deduction Type"; Rec."Earning/Deduction Type")
                {
                    ToolTip = 'Specifies the value of the Earning/Deduction Type field.';
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                    ToolTip = 'Specifies the value of the Effective End Date field';
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                    ToolTip = 'Specifies the value of the Effective Start Date field';
                }
                field("Employee Tier I"; Rec."Employee Tier I")
                {
                    ToolTip = 'Specifies the value of the Employee Tier I field.';
                }
                field("Employee Tier II"; Rec."Employee Tier II")
                {
                    ToolTip = 'Specifies the value of the Employee Tier II field.';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
                field("Employee Voluntary"; Rec."Employee Voluntary")
                {
                    ToolTip = 'Specifies the value of the Employee Voluntary field';
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ToolTip = 'Specifies the value of the Employer Amount field';
                }
                field("Employer Tier I"; Rec."Employer Tier I")
                {
                    ToolTip = 'Specifies the value of the Employer Tier I field.';
                }
                field("Employer Tier II"; Rec."Employer Tier II")
                {
                    ToolTip = 'Specifies the value of the Employer Tier II field.';
                }
                field("Employer Voluntary"; Rec."Employer Voluntary")
                {
                    ToolTip = 'Specifies the value of the Employer Voluntary field.';
                }
                field("Ext Insurance Amount"; Rec."Ext Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the External Insurance Amount field';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(Gratuity; Rec.Gratuity)
                {
                    ToolTip = 'Specifies the value of the Gratuity field.';
                }
                field("Gratuity PAYE"; Rec."Gratuity PAYE")
                {
                    ToolTip = 'Specifies the value of the Gratuity PAYE field';
                }
                field("House Allowance Code"; Rec."House Allowance Code")
                {
                    ToolTip = 'Specifies the value of the House Allowance Code field.';
                }
                field("House No."; Rec."House No.")
                {
                    ToolTip = 'Specifies the value of the House No. field';
                }
                field(Imprest; Rec.Imprest)
                {
                    ToolTip = 'Specifies the value of the Imprest field.';
                }
                field("Initial Amount"; Rec."Initial Amount")
                {
                    ToolTip = 'Specifies the value of the Initial Amount field.';
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ToolTip = 'Specifies the value of the Insurance Code field';
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ToolTip = 'Specifies the value of the Interest Amount field';
                }
                field("June Paye"; Rec."June Paye")
                {
                    ToolTip = 'Specifies the value of the June Paye field.';
                }
                field("June Paye Diff"; Rec."June Paye Diff")
                {
                    ToolTip = 'Specifies the value of the June Paye Diff field.';
                }
                field("June Taxable Amount"; Rec."June Taxable Amount")
                {
                    ToolTip = 'Specifies the value of the June Taxable Amount field.';
                }
                field("Less Pension Contribution"; Rec."Less Pension Contribution")
                {
                    ToolTip = 'Specifies the value of the Less Pension Contribution field.';
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                    ToolTip = 'Specifies the value of the Loan Interest field';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field';
                }
                field("Loan Repay"; Rec."Loan Repay")
                {
                    ToolTip = 'Specifies the value of the Loan Repay field';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ToolTip = 'Specifies the value of the Loan Type field.';
                }
                field("Main Deduction Code"; Rec."Main Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Main Deduction Code field';
                }
                field("Manual Entry"; Rec."Manual Entry")
                {
                    ToolTip = 'Specifies the value of the Manual Entry field.';
                }
                field("Monthly Personal Relief"; Rec."Monthly Personal Relief")
                {
                    ToolTip = 'Specifies the value of the Monthly Personal Relief field.';
                }
                field("Monthly Self Cummulative"; Rec."Monthly Self Cummulative")
                {
                    ToolTip = 'Specifies the value of the Monthly Self Cummulative field.';
                }
                field("Mortgage Interest"; Rec."Mortgage Interest")
                {
                    ToolTip = 'Specifies the value of the Mortgage Interest field.';
                }
                field("Mortgage Relief"; Rec."Mortgage Relief")
                {
                    ToolTip = 'Specifies the value of the Mortgage Relief field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field("Next Period Entry"; Rec."Next Period Entry")
                {
                    ToolTip = 'Specifies the value of the Next Period Entry field.';
                }
                field("No of Days"; Rec."No of Days")
                {
                    ToolTip = 'Specifies the value of the No of Days field.';
                }
                field("No. of Units"; Rec."No. of Units")
                {
                    ToolTip = 'Specifies the value of the No. of Units field.';
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                    ToolTip = 'Specifies the value of the Non-Cash Benefit field';
                }
                field("Normal Earnings"; Rec."Normal Earnings")
                {
                    ToolTip = 'Specifies the value of the Normal Earnings field.';
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ToolTip = 'Specifies the value of the Opening Balance field.';
                }
                field("Opening Balance Company"; Rec."Opening Balance Company")
                {
                    ToolTip = 'Specifies the value of the Opening Balance Company field.';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ToolTip = 'Specifies the value of the Outstanding Amount field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Pay Period"; Rec."Pay Period")
                {
                    ToolTip = 'Specifies the value of the Pay Period field';
                }
                field(Paye; Rec.Paye)
                {
                    ToolTip = 'Specifies the value of the Paye field.';
                }
                field("Payroll Group"; Rec."Payroll Group")
                {
                    ToolTip = 'Specifies the value of the Payroll Group field.';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Period Repayment"; Rec."Period Repayment")
                {
                    ToolTip = 'Specifies the value of the Period Repayment field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Posting Group Filter"; Rec."Posting Group Filter")
                {
                    ToolTip = 'Specifies the value of the Posting Group Filter field.';
                }
                field(Prorated; Rec.Prorated)
                {
                    ToolTip = 'Specifies the value of the Prorated field.';
                }
                field(Quarters; Rec.Quarters)
                {
                    ToolTip = 'Specifies the value of the Quarters field.';
                }
                field("Reason For Chage"; Rec."Reason For Chage")
                {
                    ToolTip = 'Specifies the value of the Reason For Chage field.';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field';
                }
                field(Retirement; Rec.Retirement)
                {
                    ToolTip = 'Specifies the value of the Retirement field';
                }
                field("Sacco Deduction"; Rec."Sacco Deduction")
                {
                    ToolTip = 'Specifies the value of the Sacco Deduction field.';
                }
                field("Salary Arrears Code"; Rec."Salary Arrears Code")
                {
                    ToolTip = 'Specifies the value of the Salary Arrears Code field.';
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ToolTip = 'Specifies the value of the Salary Grade field.';
                }
                field("Salary Pointer"; Rec."Salary Pointer")
                {
                    ToolTip = 'Specifies the value of the Salary Pointer field.';
                }
                field("Secondary PAYE"; Rec."Secondary PAYE")
                {
                    ToolTip = 'Specifies the value of the Secondary PAYE field.';
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Specifies the value of the Section field.';
                }
                field(Shares; Rec.Shares)
                {
                    ToolTip = 'Specifies the value of the Shares field.';
                }
                field("Show on Report"; Rec."Show on Report")
                {
                    ToolTip = 'Specifies the value of the Show on Report field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Tax Deductible"; Rec."Tax Deductible")
                {
                    ToolTip = 'Specifies the value of the Tax Deductible field';
                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ToolTip = 'Specifies the value of the Tax Relief field.';
                }
                field(Taxable; Rec.Taxable)
                {
                    ToolTip = 'Specifies the value of the Taxable field';
                }
                field("Taxable amount"; Rec."Taxable amount")
                {
                    ToolTip = 'Specifies the value of the Taxable amount field';
                }
                field(Tenure; Rec.Tenure)
                {
                    ToolTip = 'Specifies the value of the Tenure field';
                }
                field("Time Sheet"; Rec."Time Sheet")
                {
                    ToolTip = 'Specifies the value of the Time Sheet field.';
                }
                field("Top Up Share"; Rec."Top Up Share")
                {
                    ToolTip = 'Specifies the value of the Top Up Share field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field(Voluntary; Rec.Voluntary)
                {
                    ToolTip = 'Specifies the value of the Voluntary field.';
                }
            }
        }
    }
}






