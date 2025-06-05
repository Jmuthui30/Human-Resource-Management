table 52040 "Appraisal Formats"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Formats';
    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Values,Core Competences,Curriculum Delivery,Research,Initiative & Willingness,Managerial & Supervisory';
            OptionMembers = Values,"Core Competences","Curriculum Delivery",Research,"Initiative & Willingness","Managerial & Supervisory";
            Caption = 'Type';
        }
        field(2; Indicator; Text[250])
        {
            Caption = 'Indicator';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Type, Indicator)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





