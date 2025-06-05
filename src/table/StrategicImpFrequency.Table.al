table 52098 "Strategic Imp Frequency"
{
    Caption = 'Strategic Implementation Frequency';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Text[500])
        {
            Caption = 'Code';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}





