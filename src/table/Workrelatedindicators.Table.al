table 52110 "Work related indicators"
{
    DataClassification = CustomerContent;
    Caption = 'Work related indicators';
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
        field(3; AttributeCode; Code[20])
        {
            Caption = 'AttributeCode';
        }
    }

    keys
    {
        key(PK; AttributeCode, Code)
        {
            Clustered = true;
        }
    }
}
