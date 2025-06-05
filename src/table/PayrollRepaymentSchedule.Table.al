table 52130 "Payroll Repayment Schedule"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Repayment Schedule';
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Payroll Loan Application"."Loan No";
            Caption = 'Loan No';
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Employee No';
        }
        field(3; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
        }
        field(4; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
        }
        field(5; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
        }
        field(6; "Loan Category"; Code[20])
        {
            Caption = 'Loan Category';
        }
        field(7; "Monthly Repayment"; Decimal)
        {
            Caption = 'Monthly Repayment';
        }
        field(8; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(9; "Monthly Interest"; Decimal)
        {
            Caption = 'Monthly Interest';
        }
        field(10; "Principal Repayment"; Decimal)
        {
            Caption = 'Principal Repayment';
        }
        field(11; "Instalment No"; Integer)
        {
            Caption = 'Instalment No';
        }
        field(12; "Remaining Debt"; Decimal)
        {
            Caption = 'Remaining Debt';
        }
        field(13; "Payroll Group"; Code[20])
        {
            Caption = 'Payroll Group';
        }
        field(14; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(15; "Loan Deduction Code"; Code[10])
        {
            TableRelation = Deductions.Code;
            Caption = 'Loan Deduction Code';
        }
        field(16; "Loan Interest Code"; Code[10])
        {
            TableRelation = Deductions.Code;
            Caption = 'Loan Interest Code';
        }
        field(17; "Customer Code"; code[50])
        {
            Caption = 'Customer Code';
        }
        field(18; "Loan Customer Type"; option)
        {
            OptionMembers = "Staff","External Customer";
            Caption = 'Loan Customer Type';
        }
        field(19; "Partially Paid"; Boolean)
        {
            Caption = 'Partially Paid';
        }
        field(20; "Next Invoice Date"; date)
        {
            Caption = 'Next Invoice Date';
        }
        field(21; "Last Interest Date"; date)
        {
            Caption = 'Last Interest Date';
        }
    }

    keys
    {
        key(Key1; "Loan No", "Employee No", "Repayment Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





