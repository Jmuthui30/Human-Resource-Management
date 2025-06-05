table 52107 "Appraisal Devt Need Setup"
{
    Caption = 'Appraisal Devt Need Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
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
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}






