table 52052 "Recruitment Stages"
{
    DrillDownPageID = "Recruitment Stages";
    LookupPageID = "Recruitment Stages";
    DataClassification = CustomerContent;
    Caption = 'Recruitment Stages';
    fields
    {
        field(1; "Recruitement Stage"; Code[50])
        {
            NotBlank = true;
            Caption = 'Recruitement Stage';
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "Failed Response Templates"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
            Caption = 'Failed Response Templates';
        }
        field(4; "Passed Response Templates"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
            Caption = 'Passed Response Templates';
        }
        field(5; Interview; Boolean)
        {
            Caption = 'Interview';
        }
        field(6; Application; Boolean)
        {
            Caption = 'Application';
        }
    }

    keys
    {
        key(Key1; "Recruitement Stage")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





