table 52163 "Perfomance rating matrix"
{
    DataClassification = CustomerContent;
    Caption = 'Perfomance rating matrix';
    fields
    {
        field(1; Code; Code[1500])
        {
            Caption = 'Code';
        }
        field(2; "Start"; Decimal)
        {
            Caption = 'Start';
        }
        field(3; "End"; Decimal)
        {
            Caption = 'End';
        }
        field(4; Grade; Text[20])
        {
            Caption = 'Grade';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}





