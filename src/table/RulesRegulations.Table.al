table 52035 "Rules & Regulations"
{
    DataClassification = CustomerContent;
    Caption = 'Rules & Regulations';
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; "Rules & Regulations"; Text[250])
        {
            Caption = 'Rules & Regulations';
        }
        field(4; "Document Link"; Text[200])
        {
            Caption = 'Document Link';
        }
        field(5; Remarks; Text[200])
        {
            NotBlank = true;
            Caption = 'Remarks';
        }
        field(6; "Language Code (Default)"; Code[10])
        {
            Caption = 'Language Code (Default)';
        }
        field(7; Attachement; Option)
        {
            OptionMembers = No,Yes;
            Caption = 'Attachement';
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





