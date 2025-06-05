table 52082 "Classroom Interview"
{
    DataClassification = CustomerContent;
    Caption = 'Classroom Interview';
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
        field(6; "Test Parameters"; Code[20])
        {
            TableRelation = "Test Parameters";
            Caption = 'Test Parameters';
        }
    }

    keys
    {
        key(Key1; "Applicant No", "Panel Member", "Test Parameters")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





