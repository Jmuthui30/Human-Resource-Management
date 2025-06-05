table 52166 "Appraisal Workplan Code"
{
    Caption = 'Appraisal Workplan Code';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
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






