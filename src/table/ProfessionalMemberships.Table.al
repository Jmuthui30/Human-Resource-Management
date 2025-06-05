table 52105 "Professional Memberships"
{
    DataClassification = CustomerContent;
    Caption = 'Professional Memberships';
    fields
    {
        field(1; Name; Code[500])
        {
            Caption = 'Name';
        }
        field(2; Description; Code[500])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





