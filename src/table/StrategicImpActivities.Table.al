table 52101 "Strategic Imp Activities"
{
    Caption = 'Strategic Implementation Activities';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Activity Code"; Code[20])
        {
            Caption = '#';

            trigger OnValidate()
            begin
                Validate(InitiativeCode);
            end;
        }
        field(2; Activities; Text[2048])
        {
            Caption = 'Activities';
        }
        field(3; InitiativeCode; Code[150])
        {
            TableRelation = "Strategic Imp Initiatives".Code;
            Caption = 'InitiativeCode';

            trigger OnValidate()
            var
                StratInit: Record "Strategic Imp Initiatives";
            begin
                if StratInit.Get(StratInit.Code, InitiativeCode)
                then
                    Initiative := StratInit.Initiatives;
            end;
        }
        field(4; Initiative; Text[250])
        {
            Caption = 'Initiative';
        }
        field(5; Frequency; Code[20])
        {
            TableRelation = "Strategic Imp Frequency";
            Caption = 'Frequency';
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(8; Measure; Text[200])
        {
            Caption = 'Measure';
        }
        field(9; KPI; Text[2000])
        {
            Caption = 'KPI';
        }
        field(10; Priority; Option)
        {
            OptionCaption = '"", High,Medium,Low';
            OptionMembers = "",High,Medium,Low;
            Caption = 'Priority';
        }
        field(11; Status; Option)
        {
            OptionCaption = ' ,Not yet started,Delayed,In progress,Completed';
            OptionMembers = " ","Not yet started",Delayed,"In progress",Completed;
            Caption = 'Status';
        }
        field(12; Comments; Text[100])
        {
            Caption = 'Comments';
        }
        field(13; "Responsible Person"; Text[250])
        {
            TableRelation = "Company Job"."Job ID";
            Caption = 'Responsible Person';
        }
        field(14; "ObjectiveCode"; Code[20])
        {
            Caption = 'ObjectiveCode';
        }
    }

    keys
    {
        key(PK; InitiativeCode, "Activity Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Activity Code", Activities)
        {
        }
    }

    trigger OnInsert()
    begin
        Validate(InitiativeCode);
    end;
}





