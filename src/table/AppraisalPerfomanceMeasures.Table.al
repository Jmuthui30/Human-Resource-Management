table 52167 "Appraisal Perfomance Measures"
{
    Caption = 'Appraisal Perfomance Measures';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Workplan Code"; Code[50])
        {
            Caption = 'Workplan Code';
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Workplan Code", Code)
        {
            Clustered = true;
        }
    }
}






