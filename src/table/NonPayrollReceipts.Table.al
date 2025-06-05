table 52138 "Non Payroll Receipts"
{
    DataClassification = CustomerContent;
    Caption = 'Non Payroll Receipts';
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Payroll Loan Application"."Loan No";
            Caption = 'Loan No';
        }
        field(2; "Receipt Date"; Date)
        {
            NotBlank = true;
            Caption = 'Receipt Date';
        }
        field(3; "Received From"; Text[40])
        {
            Caption = 'Received From';
        }
        field(4; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Reference No"; Code[20])
        {
            Caption = 'Reference No';
        }
    }

    keys
    {
        key(Key1; "Loan No", "Receipt Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





