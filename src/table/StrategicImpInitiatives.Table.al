table 52100 "Strategic Imp Initiatives"
{
    Caption = 'Strategic Implementation Initiatives';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Initiatives; Text[150])
        {
            Caption = 'Initiatives';
        }
        field(3; ObjectiveCode; Code[10])
        {
            TableRelation = "Appraisal Workplan Code".Code;
            Caption = 'Workplan Code';

        }
        field(4; "Strategic Objectives"; Text[500])
        {
            Caption = 'Strategic Objectives';
        }
    }

    keys
    {
        key(PK; ObjectiveCode, Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Initiatives)
        {
        }
    }

    trigger OnInsert()
    begin
        Validate(ObjectiveCode);
    end;
}





