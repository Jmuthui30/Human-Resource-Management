table 52053 "Interview Panel Members"
{
    LookupPageID = "Interview Panel Members";
    DataClassification = CustomerContent;
    Caption = 'Interview Panel Members';
    fields
    {
        field(1; "Panel Member Code"; Code[10])
        {
            Caption = 'Panel Member Code';
            TableRelation = if (Type = const("Internal")) Employee where(Status = const(Active));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Panel Member Code") then
                    "Panel Member Name" := Employee.FullName();
            end;
        }
        field(2; "Panel Member Name"; Text[250])
        {
            Caption = 'Panel Member Name';
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            Caption = 'Type';
        }
    }

    keys
    {
        key(Key1; "Panel Member Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Panel Member Code", "Panel Member Name")
        {
        }
    }
}





