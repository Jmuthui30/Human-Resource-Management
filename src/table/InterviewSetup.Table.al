table 52078 "Interview Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Interview Setup';
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Oral,Practical';
            OptionMembers = " ",Oral,Practical;
            Caption = 'Type';
        }
        field(4; "Oral Interview"; Boolean)
        {
            Caption = 'Oral Interview';
        }
        field(5; "Oral Interview (Board)"; Boolean)
        {
            Caption = 'Oral Interview (Board)';
        }
        field(6; "Classroom Interview"; Boolean)
        {
            Caption = 'Classroom Interview';
        }
        field(7; Practical; Boolean)
        {
            Caption = 'Practical';
        }

        field(8; "Maximum Marks"; Decimal)
        {
            Caption = 'Maximum Marks';
        }
        field(9; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





