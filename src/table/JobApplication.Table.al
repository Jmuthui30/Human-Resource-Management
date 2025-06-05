table 52003 "Job Application"
{
    Caption = 'Job Application';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get();
                    HRSetup.TestField("Job Application Nos");

                    NoSeriesMgt.TestManual(HRSetup."Job Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
            TableRelation = if ("Applicant Type" = const(External)) Applicants where(Submitted = const(true))
            else
            if ("Applicant Type" = const(Internal)) Employee where(Status = const(Active));

            trigger OnValidate()
            var
                Applicants: Record Applicants;
                Employee: Record Employee;
            begin
                case "Applicant Type" of
                    "Applicant Type"::External:
                        begin
                            if Applicants.Get("Applicant No.") then;
                            "Applicant Name" := Applicants."Full Name";
                            Gender := Applicants.Gender;
                        end;
                    "Applicant Type"::"Internal":
                        begin
                            if Employee.Get("Applicant No.") then;
                            "Applicant Name" := Employee.FullName();
                            Gender := Employee.Gender;
                        end;
                end;
            end;
        }
        field(3; "Applicant Name"; Text[100])
        {
            Caption = 'Applicant Name';
            Editable = false;
        }
        field(4; "Date-Time Created"; DateTime)
        {
            Caption = 'Date-Time Created';
            Editable = false;
        }
        field(5; Submitted; Boolean)
        {
            Caption = 'Submitted';
        }
        field(6; "Job Applied Code"; Code[50])
        {
            Caption = 'Job Applied Code';
            TableRelation = "Recruitment Needs"."No." where(Status = const(Released), "Shortlisting Started" = const(false), "Shortlisting Closed" = const(false));
            trigger OnValidate()
            var
                Needs: Record "Recruitment Needs";
                AlreadyAppliedErr: Label 'You have already applied for %1 position';
            begin

                JobApplications.Reset();
                JobApplications.SetRange("Applicant No.", "Applicant No.");
                JobApplications.SetRange("Job Applied Code", "Job Applied Code");
                if JobApplications.FindFirst() then
                    Error(AlreadyAppliedErr, JobApplications."Job Title");

                Needs.Reset();
                Needs.SetRange(Needs."No.", "Job Applied Code");
                if Needs.Find('-') then
                    "Job Title" := Needs.Description;
            end;
        }
        field(7; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
            Editable = false;
        }
        field(8; "No. Series"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'No. Series';
        }
        field(9; "Applicant Type"; Option)
        {
            OptionMembers = "External","Internal";
            OptionCaption = 'External,Internal';
            Caption = 'Applicant Type';
        }
        field(10; "Application Status"; Enum "Job Application Status")
        {
            Caption = 'Application Status';
        }
        field(11; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
            Editable = false;
        }
        field(12; "Expected Reporting Date"; Date)
        {
            Caption = 'Expected Reporting Date';
        }
        field(13; "Practical Average Score"; Decimal)
        {
            CalcFormula = average("Interview Stage"."Marks Awarded" where("Applicant No" = field("No."), "Interview Type" = const(Practical)));
            FieldClass = FlowField;
            Caption = 'Practical Average Score';
            Editable = false;
        }
        field(14; "Oral Average Score"; Decimal)
        {
            CalcFormula = average("Interview Stage"."Marks Awarded" where("Applicant No" = field("No."), "Interview Type" = const(Oral)));
            FieldClass = FlowField;
            Caption = 'Oral Average Score';
            Editable = false;
        }
        field(15; Interviewed; Boolean)
        {
            Caption = 'Interviewed';
        }
        field(16; "Total Average Score"; Decimal)
        {
            CalcFormula = average("Interview Stage"."Marks Awarded" where("Applicant No" = field("No.")));
            FieldClass = FlowField;
            Caption = 'Total Average Score';
            Editable = false;
        }
        field(17; "Select To Hire"; Boolean)
        {
            Caption = 'Select To Hire';
        }
        field(18; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(19; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        HRSetup: Record "Human Resources Setup";
        JobApplications: Record "Job Application";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Job Application Nos");

            NoSeriesMgt.InitSeries(HRSetup."Job Application Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Date-Time Created" := CurrentDateTime();
    end;
}






