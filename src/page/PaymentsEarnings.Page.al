page 52278 "Payments_Earnings"
{
    ApplicationArea = All;
    DataCaptionFields = "Employee No", Type, "Code";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Assignment Matrix";
    Caption = 'Payments_Earnings';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                        Commit();

                        //Validate Formula Amounts
                        Payroll.ValidateFormulaAmounts(Rec);
                    end;
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field';
                }
                field("Ext Insurance Amount"; Rec."Ext Insurance Amount")
                {
                    Caption = 'External Insurance Amount';
                    ToolTip = 'Specifies the value of the External Insurance Amount field';
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                    ToolTip = 'Specifies the value of the Effective Start Date field';
                }
                field(Tenure; Rec.Tenure)
                {
                    ToolTip = 'Specifies the value of the Tenure field';
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                    ToolTip = 'Specifies the value of the Effective End Date field';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field';
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ToolTip = 'Specifies the value of the Insurance Code field';
                }
                field("Gratuity PAYE"; Rec."Gratuity PAYE")
                {
                    ToolTip = 'Specifies the value of the Gratuity PAYE field';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field';
                }
                field("Main Deduction Code"; Rec."Main Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Main Deduction Code field';
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                    ToolTip = 'Specifies the value of the Basic Salary Code field';
                }
                field("Period Repayment"; Rec."Period Repayment")
                {
                    ToolTip = 'Specifies the value of the Period Repayment field';
                }
                field("Employee Voluntary"; Rec."Employee Voluntary")
                {
                    ToolTip = 'Specifies the value of the Employee Voluntary field';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ToolTip = 'Specifies the value of the Outstanding Amount field';
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employer Amount field';
                }
                field("Loan Repay"; Rec."Loan Repay")
                {
                    ToolTip = 'Specifies the value of the Loan Repay field';
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                    ToolTip = 'Specifies the value of the Non-Cash Benefit field';
                }
                field(Taxable; Rec.Taxable)
                {
                    ToolTip = 'Specifies the value of the Taxable field';
                }
                field(Retirement; Rec.Retirement)
                {
                    ToolTip = 'Specifies the value of the Retirement field';
                }
                field("Pay Period"; Rec."Pay Period")
                {
                    ToolTip = 'Specifies the value of the Pay Period field';
                }
                field("Tax Deductible"; Rec."Tax Deductible")
                {
                    ToolTip = 'Specifies the value of the Tax Deductible field';
                }
                field("Taxable amount"; Rec."Taxable amount")
                {
                    ToolTip = 'Specifies the value of the Taxable amount field';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ToolTip = 'Specifies the value of the Interest Amount field';
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                    ToolTip = 'Specifies the value of the Loan Interest field';
                }
                field("House No."; Rec."House No.")
                {
                    ToolTip = 'Specifies the value of the House No. field';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Earning;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Earning;
    end;

    var
        Payroll: Codeunit Payroll;
}





