table 52080 "Oral Interview (Board)"
{
    DataClassification = CustomerContent;
    Caption = 'Oral Interview (Board)';
    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            Caption = 'Applicant No';
        }
        field(2; "Need Code"; Code[20])
        {
            TableRelation = "Interview Setup";
            Caption = 'Need Code';
        }
        field(3; "Panel Member"; Code[10])
        {
            TableRelation = "Interview Panel Members";
            Caption = 'Panel Member';
        }
        field(4; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(5; Remarks; Text[30])
        {
            Caption = 'Remarks';
        }
        field(6; "Test Parameter"; Code[20])
        {
            TableRelation = "Test Parameters";
            Caption = 'Test Parameter';
        }
    }

    keys
    {
        key(Key1; "Applicant No", "Panel Member", "Test Parameter")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





