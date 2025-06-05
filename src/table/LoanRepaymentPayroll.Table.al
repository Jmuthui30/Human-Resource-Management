table 52159 "Loan Repayment-Payroll"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Repayment-Payroll';
    fields
    {
        field(1; "Loan No."; Code[30])
        {
            TableRelation = "Payroll Loan Application"."Loan No";
            Caption = 'Loan No.';
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(4; "No. of Periods"; Integer)
        {
            Caption = 'No. of Periods';
        }
        field(5; "Customer No."; Code[30])
        {
            TableRelation = Customer;
            Caption = 'Customer No.';
        }
        field(6; "Repayment Amount"; Decimal)
        {
            Caption = 'Repayment Amount';
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





