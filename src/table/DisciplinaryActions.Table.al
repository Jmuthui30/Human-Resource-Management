table 52065 "Disciplinary Actions"
{
    DrillDownPageID = "Disciplinary Actions";
    LookupPageID = "Disciplinary Actions";
    DataClassification = CustomerContent;
    Caption = 'Disciplinary Actions';
    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Warning Letter"; Boolean)
        {
            Caption = 'Warning Letter';
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





