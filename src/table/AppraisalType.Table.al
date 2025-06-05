table 52037 "Appraisal Type"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Type';
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; Description; Text[150])
        {
            NotBlank = true;
            Caption = 'Description';
        }
        field(3; "Use Template"; Boolean)
        {
            Caption = 'Use Template';
        }
        field(4; "Template Link"; Text[200])
        {
            Caption = 'Template Link';
        }
        field(5; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(6; "Max. Weighting"; Decimal)
        {
            Caption = 'Max. Weighting';
        }
        field(7; "Max. Score"; Decimal)
        {
            Caption = 'Max. Score';
        }
        field(8; "Minimum Job Group"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'Minimum Job Group';
        }
        field(9; "Maximum Job Group"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'Maximum Job Group';
        }
        field(10; Type; Option)
        {
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ","Q1","Q2","Q3","Q4";
            Caption = 'Type';
        }
        field(11; Closed; Boolean)
        {
            Caption = 'Closed';
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





