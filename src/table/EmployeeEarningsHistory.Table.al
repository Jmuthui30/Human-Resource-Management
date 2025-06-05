table 52120 "Employee Earnings History"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Earnings History';
    fields
    {
        field(1; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No';
        }
        field(2; Type; Option)
        {
            NotBlank = false;
            OptionCaption = 'Payment,Deduction,Saving Scheme,Loan';
            OptionMembers = Payment,Deduction,"Saving Scheme",Loan;
            Caption = 'Type';
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = if (Type = const(Payment)) Earnings
            else
            if (Type = const(Deduction)) Deductions
            else
            if (Type = const(Loan)) "Payroll Loan Application"."Loan No" where("Employee No" = field("Employee No"));
            Caption = 'Code';
        }
        field(5; "Effective Start Date"; Date)
        {
            Caption = 'Effective Start Date';
        }
        field(6; "Effective End Date"; Date)
        {
            Caption = 'Effective End Date';
        }
        field(7; "Payroll Period"; Date)
        {
            NotBlank = false;
            TableRelation = "Payroll Period"."Starting Date";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            Caption = 'Payroll Period';
        }
        field(8; Amount; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Caption = 'Amount';
        }
        field(9; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(10; Taxable; Boolean)
        {
            Caption = 'Taxable';
        }
        field(11; "Tax Deductible"; Boolean)
        {
            Caption = 'Tax Deductible';
        }
        field(12; Frequency; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
            Caption = 'Frequency';
        }
        field(13; "Pay Period"; Text[30])
        {
            Caption = 'Pay Period';
        }
        field(14; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'G/L Account';
        }
        field(15; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
        }
        field(16; "Employer Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Caption = 'Employer Amount';
        }
        field(17; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Department Code';
        }
        field(18; "Next Period Entry"; Boolean)
        {
            Caption = 'Next Period Entry';
        }
        field(19; "Posting Group Filter"; Code[20])
        {
            TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group Filter';
        }
        field(20; "Initial Amount"; Decimal)
        {
            Caption = 'Initial Amount';
        }
        field(21; "Outstanding Amount"; Decimal)
        {
            Caption = 'Outstanding Amount';
        }
        field(22; "Loan Repay"; Boolean)
        {
            Caption = 'Loan Repay';
        }
        field(23; Closed; Boolean)
        {
            Editable = true;
            Caption = 'Closed';
        }
        field(24; "Salary Grade"; Code[20])
        {
            Caption = 'Salary Grade';
        }
        field(25; "Tax Relief"; Boolean)
        {
            Caption = 'Tax Relief';
        }
        field(26; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
        }
        field(27; "Period Repayment"; Decimal)
        {
            Caption = 'Period Repayment';
        }
        field(28; "Non-Cash Benefit"; Boolean)
        {
            Caption = 'Non-Cash Benefit';
        }
        field(29; Quarters; Boolean)
        {
            Caption = 'Quarters';
        }
        field(30; "No. of Units"; Decimal)
        {
            Caption = 'No. of Units';
        }
        field(31; Section; Code[20])
        {
            Caption = 'Section';
        }
        field(33; Retirement; Boolean)
        {
            Caption = 'Retirement';
        }
        field(34; CFPay; Boolean)
        {
            Caption = 'CFPay';
        }
        field(35; BFPay; Boolean)
        {
            Caption = 'BFPay';
        }
        field(36; "Opening Balance"; Decimal)
        {
            Caption = 'Opening Balance';
        }
        field(37; DebitAcct; Code[20])
        {
            Caption = 'DebitAcct';
        }
        field(38; CreditAcct; Code[20])
        {
            Caption = 'CreditAcct';
        }
        field(39; Shares; Boolean)
        {
            Caption = 'Shares';
        }
        field(40; "Show on Report"; Boolean)
        {
            Caption = 'Show on Report';
        }
        field(41; "Earning/Deduction Type"; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
            Caption = 'Earning/Deduction Type';
        }
        field(42; "Time Sheet"; Boolean)
        {
            Caption = 'Time Sheet';
        }
        field(43; "Basic Salary Code"; Boolean)
        {
            Caption = 'Basic Salary Code';
        }
        field(44; "Payroll Group"; Code[30])
        {
            TableRelation = Company;
            Caption = 'Payroll Group';
        }
        field(45; Paye; Boolean)
        {
            Caption = 'Paye';
        }
        field(46; "Taxable amount"; Decimal)
        {
            Caption = 'Taxable amount';
        }
        field(47; "Less Pension Contribution"; Decimal)
        {
            Caption = 'Less Pension Contribution';
        }
        field(48; "Monthly Personal Relief"; Decimal)
        {
            Caption = 'Monthly Personal Relief';
        }
        field(49; "Normal Earnings"; Boolean)
        {
            Editable = false;
            Caption = 'Normal Earnings';
        }
        field(50; "Mortgage Relief"; Decimal)
        {
            Caption = 'Mortgage Relief';
        }
        field(51; "Monthly Self Cummulative"; Decimal)
        {
            Caption = 'Monthly Self Cummulative';
        }
        field(52; "Company Monthly Contribution"; Decimal)
        {
            Caption = 'Company Monthly Contribution';
        }
        field(53; "Company Cummulative"; Decimal)
        {
            Caption = 'Company Cummulative';
        }
        field(54; "Main Deduction Code"; Code[20])
        {
            Caption = 'Main Deduction Code';
        }
        field(55; "Opening Balance Company"; Decimal)
        {
            Caption = 'Opening Balance Company';
        }
        field(56; "Insurance Code"; Boolean)
        {
            Caption = 'Insurance Code';
        }
        field(57; "Reference No"; Code[50])
        {
            Caption = 'Reference No';
        }
        field(58; "Manual Entry"; Boolean)
        {
            Caption = 'Manual Entry';
        }
        field(59; "Salary Pointer"; Code[20])
        {
            Caption = 'Salary Pointer';
        }
        field(60; "Employee Voluntary"; Decimal)
        {
            Caption = 'Employee Voluntary';
        }
        field(61; "Employer Voluntary"; Decimal)
        {
            Caption = 'Employer Voluntary';
        }
        field(62; "Loan Product Type"; Code[20])
        {
            TableRelation = "Loan Product Type-Payroll".Code;
            Caption = 'Loan Product Type';
        }
        field(63; "June Paye"; Decimal)
        {
            Caption = 'June Paye';
        }
        field(64; "June Taxable Amount"; Decimal)
        {
            Caption = 'June Taxable Amount';
        }
        field(65; "June Paye Diff"; Decimal)
        {
            Caption = 'June Paye Diff';
        }
        field(66; "Gratuity PAYE"; Decimal)
        {
            Caption = 'Gratuity PAYE';
        }
        field(67; "Basic Pay Arrears"; Boolean)
        {
            Caption = 'Basic Pay Arrears';
        }
        field(68; Voluntary; Boolean)
        {
            Caption = 'Voluntary';
        }
        field(69; "Loan Interest"; Decimal)
        {
            Caption = 'Loan Interest';
        }
        field(70; "Top Up Share"; Decimal)
        {
            Caption = 'Top Up Share';
        }
        field(71; "Insurance No"; Code[20])
        {
            Caption = 'Insurance No';
        }
        field(72; "Employee Tier I"; Decimal)
        {
            Caption = 'Employee Tier I';
        }
        field(73; "Employee Tier II"; Decimal)
        {
            Caption = 'Employee Tier II';
        }
        field(74; "Employer Tier I"; Decimal)
        {
            Caption = 'Employer Tier I';
        }
        field(75; "Employer Tier II"; Decimal)
        {
            Caption = 'Employer Tier II';
        }
        field(76; "House Allowance Code"; Boolean)
        {
            Caption = 'House Allowance Code';
        }
        field(77; "Pay Mode"; Code[20])
        {
            TableRelation = "Employee Pay Modes";
            Caption = 'Pay Mode';
        }
        field(78; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(79; "No of Days"; Integer)
        {
            Caption = 'No of Days';
        }
    }

    keys
    {
        key(Key1; "Employee No", Type, "Code", "Payroll Period", "Reference No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure FetchFullAmt(AssignMatrix: Record "Assignment Matrix"): Decimal
    var
        EmpEarnRec: Record "Employee Earnings History";
    begin
        EmpEarnRec.Reset();
        EmpEarnRec.SetRange("Employee No", AssignMatrix."Employee No");
        EmpEarnRec.SetRange(Type, AssignMatrix.Type);
        EmpEarnRec.SetRange(Code, AssignMatrix.Code);
        EmpEarnRec.SetRange("Payroll Period", AssignMatrix."Payroll Period");
        EmpEarnRec.SetRange("Reference No", AssignMatrix."Reference No");
        if EmpEarnRec.Find('-') then
            exit(EmpEarnRec.Amount);
    end;

    procedure UpdateEntries(AssignMatrix: Record "Assignment Matrix")
    var
        EmpEarnRec: Record "Employee Earnings History";
    begin
        EmpEarnRec.Init();
        EmpEarnRec.TransferFields(AssignMatrix);
        if not EmpEarnRec.Get(EmpEarnRec."Employee No", EmpEarnRec.Type,
                              EmpEarnRec.Code, EmpEarnRec."Payroll Period",
                              EmpEarnRec."Reference No") then
            EmpEarnRec.Insert()
        else begin
            EmpEarnRec.Reset();
            EmpEarnRec.SetRange("Employee No", AssignMatrix."Employee No");
            EmpEarnRec.SetRange(Type, AssignMatrix.Type);
            EmpEarnRec.SetRange(Code, AssignMatrix.Code);
            EmpEarnRec.SetRange("Payroll Period", AssignMatrix."Payroll Period");
            EmpEarnRec.SetRange("Reference No", AssignMatrix."Reference No");
            if EmpEarnRec.Find('-') then begin
                EmpEarnRec.TransferFields(AssignMatrix);
                EmpEarnRec.Modify();
            end;
        end;
    end;
}





