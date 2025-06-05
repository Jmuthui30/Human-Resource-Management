table 52132 "Institutions"
{
    DataClassification = CustomerContent;
    Caption = 'Institutions';
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(4; City; Text[30])
        {
            Caption = 'City';
        }
        field(5; Email; Text[60])
        {
            Caption = 'Email';
        }
        field(6; "Deduction Code"; Code[20])
        {
            TableRelation = Deductions;
            Caption = 'Deduction Code';
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





