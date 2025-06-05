table 52113 "Applicant Job Education"
{
    Caption = 'Applicant Job Education';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
            TableRelation = Applicants."No.";
        }
        field(2; "Education Type"; Enum "Education Types")
        {
            Caption = 'Education Type';
        }
        field(3; Institution; Code[50])
        {
            Caption = 'Institution';
            TableRelation = "Education Institution"."Institution Code" where(Type = field("Institution Type"));

            trigger OnValidate()
            begin
                if EducationInstitutions.Get(Institution) then
                    "Institution Name" := EducationInstitutions."Institution Name";
            end;
        }
        field(4; "Institution Name"; Text[250])
        {
            Caption = 'Institution Name';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            trigger OnValidate()
            begin
                if "Start Date" > Today then
                    Error('Start date can not be a future date');

                if "End Date" <> 0D then
                    if "Start Date" > "End Date" then
                        Error('Start Date can not be later than Start Date');
            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            trigger OnValidate()
            begin
                if "End Date" > Today then
                    Error('End date can not be a future date');

                if "Start Date" <> 0D then
                    if "End Date" < "Start Date" then
                        Error('End Date can not be earlier than Start Date');
            end;
        }
        field(7; Country; Code[50])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(8; Region; Code[50])
        {
            Caption = 'Region';
            TableRelation = County;
        }
        field(9; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            TableRelation = "Field of Study";
        }
        field(10; "Qualification Code"; Code[50])
        {
            Caption = 'Qualification Code';
            TableRelation = Qualification.Code where("Qualification Type" = const(Academic), "Field of Study" = field("Field of Study"), "Education Level" = field("Education Level"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
        field(11; "Qualification Name"; Text[250])
        {
            Caption = 'Qualification Name';
        }
        field(12; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
        }
        field(13; "Highest Level"; Boolean)
        {
            Caption = 'Highest Level';
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(16; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(17; "Proficiency Level"; Enum "Proficiency Level")
        {
            Caption = 'Proficiency Level';
        }
        field(18; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(19; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
        }
        field(20; "Section/Level"; Integer)
        {
            Caption = 'Section/Level';
        }
        field(21; "Qualification Code Prof"; Code[50])
        {
            Caption = 'Qualification Code';
            TableRelation = Qualification.Code;

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code Prof") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
        field(22; "Institution Type"; Enum "Education Institution Type")
        {
            Caption = 'Institution Type';
        }
    }

    keys
    {
        key(PK; "Applicant No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        EducationInstitutions: Record "Education Institution";
        Qualifications: Record Qualification;
}





