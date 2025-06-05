table 52093 "Field of Study"
{
    Caption = 'Field of Study';
    DataClassification = CustomerContent;
    DrillDownPageId = "Fields of Study";
    LookupPageId = "Fields of Study";

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[250])
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





