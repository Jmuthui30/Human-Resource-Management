table 52045 "Appraisal Format Header"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Format Header';
    fields
    {
        field(1; Header; Text[50])
        {
            Caption = 'Header';
        }
        field(2; Priority; Integer)
        {
            Caption = 'Priority';
        }
    }

    keys
    {
        key(Key1; Header)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





