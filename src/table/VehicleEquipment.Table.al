table 52068 "Vehicle Equipment"
{
    DataClassification = CustomerContent;
    Caption = 'Vehicle Equipment';
    fields
    {
        field(1; "Vehicle No"; Code[30])
        {
            Caption = 'Vehicle No';
        }
        field(2; Item; Code[30])
        {
            TableRelation = Item;
            Caption = 'Item';
        }
        field(3; "Item Description"; Text[60])
        {
            Caption = 'Item Description';
        }
        field(4; Available; Boolean)
        {
            Caption = 'Available';
        }
    }

    keys
    {
        key(Key1; "Vehicle No", Item)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





