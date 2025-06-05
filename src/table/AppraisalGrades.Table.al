table 52038 "Appraisal Grades"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Grades';
    fields
    {
        field(1; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(2; Rating; Text[50])
        {
            Caption = 'Rating';
        }
    }

    keys
    {
        key(Key1; Score)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





