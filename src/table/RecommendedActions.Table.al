table 52067 "Recommended Actions"
{
    DrillDownPageID = "Disc Recommended Action";
    LookupPageID = "Disc Recommended Action";
    DataClassification = CustomerContent;
    Caption = 'Recommended Actions';
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





