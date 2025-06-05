table 52109 "Work related attributes"
{
    DataClassification = CustomerContent;
    Caption = 'Work related attributes';
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





