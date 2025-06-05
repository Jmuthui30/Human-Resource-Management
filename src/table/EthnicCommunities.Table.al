table 52070 "Ethnic Communities"
{
    DrillDownPageID = "Ethnic Communities";
    LookupPageID = "Ethnic Communities";
    DataClassification = CustomerContent;
    Caption = 'Ethnic Communities';
    fields
    {
        field(1; "Ethnic Code"; Code[30])
        {
            Caption = 'Ethnic Code';
        }
        field(2; "Ethnic Name"; Text[100])
        {
            Caption = 'Ethnic Name';
        }
    }

    keys
    {
        key(Key1; "Ethnic Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





