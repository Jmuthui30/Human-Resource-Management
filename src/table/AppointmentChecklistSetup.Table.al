table 52005 "Appointment Checklist Setup"
{
    Caption = 'Induction Checklist Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item Code"; Code[50])
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Item Code")
        {
            Clustered = true;
        }
    }
}






