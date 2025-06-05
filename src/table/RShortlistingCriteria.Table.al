table 52047 "R. Shortlisting Criteria"
{
    DataClassification = CustomerContent;
    Caption = 'R. Shortlisting Criteria';
    fields
    {
        field(1; "Need Code"; Code[20])
        {
            TableRelation = "Recruitment Needs"."No.";
            Caption = 'Need Code';
        }
        field(2; "Stage Code"; Code[50])
        {
            TableRelation = "Recruitment Stages";
            Caption = 'Stage Code';

            trigger OnValidate()
            begin

                if RStages.Get("Stage Code") then begin
                    "Stage Name" := RStages.Description;
                    "Application Stage" := RStages.Application;
                    "Interview Stage" := RStages.Interview;
                end;
            end;
        }
        field(3; "Job ID"; Code[20])
        {
            TableRelation = "Company Job"."Job ID";
            Caption = 'Job ID';
        }
        field(4; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
            Caption = 'Qualification Type';
        }
        field(5; Qualification; Code[20])
        {
            Caption = 'Qualification';

            trigger OnValidate()
            begin

                if Qualifications.Get(Qualification) then
                    "Qualification Description" := Qualifications.Description;
            end;
        }
        field(6; "Desired Score"; Decimal)
        {
            Caption = 'Desired Score';
        }
        field(7; "Qualification Description"; Text[60])
        {
            Caption = 'Qualification Description';
        }
        field(8; "Stage Name"; Text[50])
        {
            Caption = 'Stage Name';
        }
        field(9; "Interview Type"; Code[20])
        {
            TableRelation = "Interview Setup";
            Caption = 'Interview Type';

            trigger OnValidate()
            begin

                if Interview.Get("Interview Type") then
                    "Interview Description" := Interview.Description;
            end;
        }
        field(10; "Interview Description"; Text[50])
        {
            Caption = 'Interview Description';
        }
        field(11; "Application Stage"; Boolean)
        {
            Caption = 'Application Stage';
        }
        field(12; "Interview Stage"; Boolean)
        {
            Caption = 'Interview Stage';
        }
    }

    keys
    {
        key(Key1; "Need Code", "Stage Code", "Job ID", "Qualification Type", Qualification, "Interview Type")
        {
            Clustered = true;
            SumIndexFields = "Desired Score";
        }
    }

    fieldgroups
    {
    }

    var
        Interview: Record "Interview Setup";
        Qualifications: Record Qualification;
        RStages: Record "Recruitment Stages";
}





