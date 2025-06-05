table 52102 "Training Area"
{
    DataClassification = CustomerContent;
    Caption = 'Training Area';
    fields
    {
        field(1; "Description"; Code[500])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





