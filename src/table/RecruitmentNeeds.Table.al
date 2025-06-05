table 52046 "Recruitment Needs"
{
    DrillDownPageID = "Approved Recruitment Requests";
    LookupPageID = "Approved Recruitment Requests";
    DataClassification = CustomerContent;
    Caption = 'Recruitment Needs';
    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            NotBlank = false;
            Caption = 'No.';
        }
        field(2; "Job ID"; Code[20])
        {
            NotBlank = false;
            TableRelation = "Company Job"."Job ID" where(Vacancy = filter(> 0));
            Caption = 'Job ID';

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange(Jobs."Job ID", "Job ID");
                if Jobs.Find('-') then
                    Description := CopyStr(Jobs."Job Description", 1, MaxStrLen(Description));
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; Priority; Option)
        {
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
            Caption = 'Priority';
        }
        field(5; Positions; Integer)
        {
            Caption = 'Positions';

            trigger OnValidate()
            begin
                Jobs.SetRange(Jobs."Job ID", "Job ID");
                if Jobs.Find('-') then
                    if Positions > Jobs.Vacancy then
                        Error('Positions cannot be more than vacant positions in staff establishment');

            end;
        }
        field(6; Approved; Boolean)
        {
            Caption = 'Approved';

            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
            Caption = 'Date Approved';
        }
        field(8; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(9; Stage; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Stage';

            trigger OnValidate()
            begin
                /*
                RShort.Reset();
                RShort.SetRange(RShort."Need Code","Need Code");
                RShort.SetRange(RShort."Stage Code",Stage);
                RShort.CalcSums(RShort."Desired Score");
                Score:=RShort."Desired Score";
                */

            end;
        }
        field(10; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(11; "Stage Code"; Code[20])
        {
            Caption = 'Stage Code';
        }
        field(12; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
        field(13; "No Filter"; Integer)
        {
            FieldClass = FlowFilter;
            Caption = 'No Filter';
        }
        field(14; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(15; "End Date"; Date)
        {
            Editable = true;
            Caption = 'End Date';
        }
        field(16; "Documentation Link"; Text[200])
        {
            Caption = 'Documentation Link';
        }
        field(17; "Turn Around Time"; Integer)
        {
            Editable = false;
            Caption = 'Turn Around Time';
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(19; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(20; "Reason for Recruitment"; Option)
        {
            OptionMembers = " ","New Position","Existing Position";
            Caption = 'Reason for Recruitment';
        }
        field(21; "Appointment Type"; Code[15])
        {
            TableRelation = "Employment Contract";
            Caption = 'Appointment Type';

            trigger OnValidate()
            var
                EContract: Record "Employment Contract";
            begin
                if EContract.Get("Appointment Type") then
                    "Appointment Type Description" := EContract.Description;
            end;
        }
        field(22; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
        }
        field(23; "Expected Reporting Date"; Date)
        {
            Caption = 'Expected Reporting Date';
            trigger OnValidate()
            begin
                if "Expected Reporting Date" < Today then
                    Error('Cannot backdate');
            end;
        }
        field(24; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval",Archived,Rejected;
            Caption = 'Status';
        }
        field(25; "Reason for Recruitment(text)"; Text[250])
        {
            Caption = 'Reason for Recruitment(text)';
        }
        field(26; "Employment Done"; Boolean)
        {
            Caption = 'Employment Done';
        }
        field(27; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(28; "Interview Date"; Date)
        {
            Caption = 'Interview Date';
        }
        field(29; "Shortlisting Closed"; Boolean)
        {
            Caption = 'Shortlisting Closed';
        }
        field(91; "Shortlist Criteria"; Enum "Shortlist Criteria")
        {
            Caption = 'Shortlist Criteria';
        }
        field(92; "Education Type"; Enum "Education Types")
        {
            Caption = 'Education Type';
        }
        field(93; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
        }
        field(94; "Proficiency Level"; Enum "Proficiency Level")
        {
            Caption = 'Proficiency Level';
        }
        field(95; "Field of Study"; Code[50])
        {
            TableRelation = "Field of Study";
            Caption = 'Field of Study';
        }
        field(96; "Minimum years of experience"; integer)
        {
            Caption = 'Minimum years of experience';
        }
        field(97; "Maximum years of experience"; integer)
        {
            Caption = 'Maximum years of experience';
        }
        field(98; "Experience industry"; Code[50])
        {
            TableRelation = "Company Job Industry";
            Caption = 'Experience industry';
        }
        field(99; "Professional Course"; Code[50])
        {
            TableRelation = Qualification.Code where("Qualification Type" = const(Academic), "Education Level" = const(Professional));
            Caption = 'Professional Course';
        }
        field(100; "Professional Membership"; Code[50])
        {
            TableRelation = "Professional Memberships";
            Caption = 'Professional Membership';
        }
        field(101; "Submitted To Portal"; Boolean)
        {
            Caption = 'Submitted To Portal';
        }
        field(102; "Shortlisting Started"; Boolean)
        {
            Caption = 'Shortlisting Started';
        }
        field(103; "Appointment Type Description"; Text[200])
        {
            Caption = 'Appointment Type Description';
        }
        field(104; "Qualified Applicants"; Integer)
        {
            Editable = false;
            Caption = 'Qualified Applicants';
            FieldClass = FlowField;
            CalcFormula = count("Applicant Shortlist" where("Need Code" = field("No."), Qualified = const(true)));
        }
        field(105; "No. of Applicants"; Integer)
        {
            Editable = false;
            Caption = 'No. of Applicants';
            FieldClass = FlowField;
            CalcFormula = count("Applicant Shortlist" where("Need Code" = field("No.")));
        }
        field(106; "Non-Qualified Applicants"; Integer)
        {
            Editable = false;
            Caption = 'Non-Qualified Applicants';
            FieldClass = FlowField;
            CalcFormula = count("Applicant Shortlist" where("Need Code" = field("No."), Qualified = const(false)));
        }
        field(107; "Total Recruitment Costs"; Decimal)
        {
            Caption = 'Total Recruitment Costs';
            FieldClass = FlowField;
            CalcFormula = sum("Recruitment Cost".Amount where("Need Code" = field("No.")));
            Editable = false;
        }
        field(130; "Oral Interview"; Boolean)
        {
            Caption = 'Oral Interview';
        }
        field(131; "Oral Interview (Board)"; Boolean)
        {
            Caption = 'Oral Interview (Board)';
        }
        field(132; Classroom; Boolean)
        {
            Caption = 'Classroom';
        }
        field(133; Practical; Boolean)
        {
            Caption = 'Practical';
        }
        field(134; Blocked; Boolean)
        {
            Caption = 'Blocked';

        }
        field(135; "Longlisting Closed"; Boolean)
        { }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Job ID", Description)
        {
        }
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Resource Request Nos");
            NoSeriesMgt.InitSeries(HRSetup."Resource Request Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Requested By" := CopyStr(UserId(), 1, MaxStrLen("Requested By"));
    end;

    var
        Jobs: Record "Company Job";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





