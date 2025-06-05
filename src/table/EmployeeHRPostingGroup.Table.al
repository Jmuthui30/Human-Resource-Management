table 52125 "Employee HR Posting Group"
{
    DrillDownPageID = "Employee HR Posting Group";
    LookupPageID = "Employee HR Posting Group";
    DataClassification = CustomerContent;
    Caption = 'Employee HR Posting Group';
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Salary Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Salary Account';
        }
        field(4; "Income Tax Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Income Tax Account';
        }
        field(5; "SSF Employer Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'SSF Employer Account';
        }
        field(6; "SSF Employee Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'SSF Employee Account';
        }
        field(7; "Net Salary Payable"; Code[20])
        {
            TableRelation = if ("Net Salary Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Net Salary Account Type" = filter(Vendor)) Vendor
            else
            if ("Net Salary Account Type" = filter("Bank Account")) "Bank Account"
            else
            if ("Net Salary Account Type" = filter("Fixed Asset")) "Fixed Asset"
            else
            if ("Net Salary Account Type" = filter(Customer)) Customer;
            Caption = 'Net Salary Payable';
        }
        field(8; "Operating Overtime"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Operating Overtime';
        }
        field(9; "Tax Relief"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Tax Relief';
        }
        field(10; "Employee Provident Fund Acc."; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Employee Provident Fund Acc.';
        }
        field(11; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(12; "Pension Employer Acc"; Code[20])
        {
            Caption = 'Pension Employer Acc';
        }
        field(13; "Pension Employee Acc"; Code[20])
        {
            Caption = 'Pension Employee Acc';
        }
        field(14; "Earnings and deductions"; Code[20])
        {
            Caption = 'Earnings and deductions';
        }
        field(15; "Daily Salary"; Decimal)
        {
            Caption = 'Daily Salary';
        }
        field(16; "Normal Overtime"; Decimal)
        {
            Caption = 'Normal Overtime';
        }
        field(17; "Weekend Overtime"; Decimal)
        {
            Caption = 'Weekend Overtime';
        }
        field(18; "Enterprise Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Enterprise Filter';
        }
        field(19; "Activity Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Activity Filter';
        }
        field(20; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(21; Seasonals; Boolean)
        {
            Caption = 'Seasonals';
        }
        field(22; Pension; Boolean)
        {
            Caption = 'Pension';
        }
        field(23; "Net Salary Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(24; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee;
            Caption = 'Employee Type Filter';
        }
        field(25; "PAYE Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'PAYE Account';
        }
        field(26; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee;
            Caption = 'Employee Type';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Earnings and deductions")
        {
        }
    }

    fieldgroups
    {
    }
}





