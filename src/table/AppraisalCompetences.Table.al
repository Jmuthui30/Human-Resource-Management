table 52076 "Appraisal Competences"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Competences';
    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
        }
        field(2; "Value/Core Competence"; Option)
        {
            OptionCaption = 'Values,Core Competences,Curriculum Delivery,Research,Initiative & Willingness,Managerial & Supervisory';
            OptionMembers = Values,"Core Competences","Curriculum Delivery",Research,"Initiative & Willingness","Managerial & Supervisory";
            Caption = 'Value/Core Competence';
        }
        field(3; Description; Text[250])
        {
            TableRelation = "Appraisal Formats".Indicator where(Type = field("Value/Core Competence"));
            Caption = 'Description';
        }
        field(4; Score; Decimal)
        {
            TableRelation = "Score Setup";
            Caption = 'Score';
        }
        field(5; Rating; Code[30])
        {
            CalcFormula = lookup("Score Setup".Score where("Score ID" = field(Score)));
            FieldClass = FlowField;
            Caption = 'Rating';
        }
        field(6; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(7; "Comments (Negative)"; Text[250])
        {
            Caption = 'Comments (Negative)';
        }
    }

    keys
    {
        key(Key1; "Appraisal No.", "Value/Core Competence", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





