table 52014 "Disciplinary Cases"
{
    DrillDownPageID = "Disciplinary Cases";
    LookupPageID = "Disciplinary Cases";
    DataClassification = CustomerContent;
    Caption = 'Disciplinary Cases';
    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Recommended Action"; Code[10])
        {
            TableRelation = "Recommended Actions".Code;
            Caption = 'Recommended Action';

            trigger OnValidate()
            var
                RAction: Record "Recommended Actions";
            begin
                RAction.Reset();
                RAction.SetRange(Code, "Recommended Action");
                if RAction.Find('-') then
                    "Action Description" := RAction.Description;
            end;
        }
        field(4; "Action Description"; Text[60])
        {
            Caption = 'Action Description';
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





