table 52069 "Ethnic Groups"
{
    DataClassification = CustomerContent;
    Caption = 'Ethnic Groups';
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Ethnic Group"; Text[100])
        {
            Caption = 'Ethnic Group';
        }
    }

    keys
    {
        key(Key1; "Code", "Ethnic Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





