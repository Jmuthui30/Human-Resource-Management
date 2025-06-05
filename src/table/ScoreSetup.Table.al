table 52054 "Score Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Score Setup';
    fields
    {
        field(1; "Score ID"; Decimal)
        {
            Caption = 'Score ID';
        }
        field(2; Score; Text[30])
        {
            Caption = 'Score';
        }
    }

    keys
    {
        key(Key1; "Score ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





