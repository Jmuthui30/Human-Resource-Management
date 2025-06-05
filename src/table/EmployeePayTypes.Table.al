table 52140 "Employee Pay Types"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Pay Types';
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Earning Code"; Code[10])
        {
            TableRelation = Earnings;
            Caption = 'Earning Code';
        }
        field(4; Formula; Code[50])
        {
            Caption = 'Formula';
        }
        field(5; "Calculation Type"; Option)
        {
            OptionCaption = 'Salary Scale,Formual';
            OptionMembers = "Salary Scale",Formual;
            Caption = 'Calculation Type';
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





