table 52007 "Medical Ceiling Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Medical Ceiling Setup';
    fields
    {
        field(1; "Salary Scale"; Code[20])
        {
            TableRelation = "Salary Scale".Scale;
            Caption = 'Salary Scale';
        }
        field(2; "Annual Amount"; Decimal)
        {
            Caption = 'Annual Amount';
        }
    }

    keys
    {
        key(Key1; "Salary Scale")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





