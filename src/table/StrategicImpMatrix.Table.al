table 52097 "Strategic Imp Matrix"
{
    Caption = 'Strategic Implementation Matrix';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Strategic Objective"; Text[500])
        {
            Caption = 'Strategic Objective';
        }
        field(2; Initiatives; Text[250])
        {
            Caption = 'Initiatives';
        }
        field(3; "#"; Code[20])
        {
            Caption = '#';
        }
        field(4; "Responsible Person"; Text[250])
        {
            TableRelation = "Company Job"."Job Description";
            Caption = 'Responsible Person';
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
            OptionCaption = ' ,"Not yet started",Delayed,"In progress",Completed';
            OptionMembers = " ","Not yet started",Delayed,"In progress",Completed;
            Caption = 'Status';
        }
        field(12; Comments; Text[100])
        {
            Caption = 'Comments';
        }
        field(13; Activities; Text[2000])
        {
            Caption = 'Activities';
        }
    }

    keys
    {
        key(PK; "Strategic Objective")
        {
            Clustered = true;
        }
    }
}





