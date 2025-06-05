table 52099 "Strategic Imp Objectives"
{
    Caption = 'Strategic Implementation Objectives';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
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





