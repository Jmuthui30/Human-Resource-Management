table 52126 "Bracket Tables"
{
    DataClassification = CustomerContent;
    Caption = 'Bracket Tables';
    fields
    {
        field(1; "Bracket Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Bracket Code';
        }
        field(2; "Bracket Description"; Text[80])
        {
            Caption = 'Bracket Description';
        }
        field(3; "Effective Starting Date"; Date)
        {
            Caption = 'Effective Starting Date';
        }
        field(4; "Effective End Date"; Date)
        {
            Caption = 'Effective End Date';
        }
        field(5; Annual; Boolean)
        {
            Caption = 'Annual';
        }
        field(6; Type; Option)
        {
            OptionCaption = 'Fixed,Graduating Scale';
            OptionMembers = "Fixed","Graduating Scale";
            Caption = 'Type';
        }
    }

    keys
    {
        key(Key1; "Bracket Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Brackets.SetRange("Table Code", "Bracket Code");
        if Brackets.FindSet() then
            Brackets.DeleteAll();
    end;

    var
        Brackets: Record Brackets;
}





