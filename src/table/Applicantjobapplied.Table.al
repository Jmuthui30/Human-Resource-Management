table 52112 "Applicant job applied"
{
    Caption = 'Applicant job applied';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            Caption = 'Application No.';
        }
        field(2; "Need Code"; Code[20])
        {
            Caption = 'Need Code';
            TableRelation = "Recruitment Needs"."No." where(Status = const(Released), "Shortlisting Started" = const(false), "Shortlisting Closed" = const(false));

            trigger OnValidate()
            var
                Needs: Record "Recruitment Needs";
            begin
                Needs.Reset();
                Needs.SetRange(Needs."No.", "Need Code");
                if Needs.Find('-') then
                    "Job Description" := Needs.Description;
            end;
        }
        field(3; "Job Description"; Text[100])
        {
            Caption = 'Job Description';
            Editable = false;
        }
        field(4; "Job Application No."; Code[20])
        {
            Caption = 'Job Application No.';
            TableRelation = "Job Application";
        }
        field(5; "Applicant Type"; Option)
        {
            OptionMembers = "External","Internal";
            OptionCaption = 'External,Internal';
            Caption = 'Applicant Type';
        }
    }

    keys
    {
        key(PK; "Applicant No.", "Need Code")
        {
            Clustered = true;
        }
    }
}





