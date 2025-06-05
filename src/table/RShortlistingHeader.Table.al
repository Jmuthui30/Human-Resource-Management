table 52063 "R.Shortlisting Header"
{
    DataClassification = CustomerContent;
    Caption = 'R.Shortlisting Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                /*
                if "No." <> xRec."No." then
                  begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."ShortList Criteria");
                    "No Series":='';
                  end;
                */

            end;
        }
        field(2; "Recruitment Need"; Code[20])
        {
            TableRelation = "Recruitment Needs"."No." where(Status = filter(Released));
            Caption = 'Recruitment Need';

            trigger OnValidate()
            begin
                RecruitNeed.Reset();
                RecruitNeed.SetRange("No.", "Recruitment Need");
                if RecruitNeed.Find('-') then begin
                    "Job ID" := RecruitNeed."Job ID";
                    Description := RecruitNeed.Description;
                    Positions := RecruitNeed.Positions;
                end;
            end;
        }
        field(3; "Job ID"; Code[30])
        {
            Caption = 'Job ID';

            trigger OnValidate()
            begin

                if CompanyJob.Get("Job ID") then begin
                    "Oral Interview" := CompanyJob."Oral Interview";
                    "Oral Interview (Board)" := CompanyJob."Oral Interview (Board)";
                    Classroom := CompanyJob.Classroom;
                    Practical := CompanyJob.Practical;
                end;
            end;
        }
        field(4; Description; Text[70])
        {
            Caption = 'Description';
        }
        field(5; Positions; Integer)
        {
            Caption = 'Positions';
        }
        field(6; "Desired Score"; Decimal)
        {
            Caption = 'Desired Score';
        }
        field(7; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(8; "Desired Interview Score"; Decimal)
        {
            Caption = 'Desired Interview Score';
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Open,Set';
            OptionMembers = Open,Set;
            Caption = 'Status';
        }
        field(10; Oral; Decimal)
        {
            Caption = 'Oral';
        }
        field(11; "Oral (Board)"; Decimal)
        {
            Caption = 'Oral (Board)';
        }
        field(12; "Practical Interview"; Decimal)
        {
            Caption = 'Practical Interview';
        }
        field(13; "Classroom Interview"; Decimal)
        {
            Caption = 'Classroom Interview';
        }
        field(30; "Oral Interview"; Boolean)
        {
            Caption = 'Oral Interview';
        }
        field(31; "Oral Interview (Board)"; Boolean)
        {
            Caption = 'Oral Interview (Board)';
        }
        field(32; Classroom; Boolean)
        {
            Caption = 'Classroom';
        }
        field(33; Practical; Boolean)
        {
            Caption = 'Practical';
        }
        field(34; "Total Desired Score"; Decimal)
        {
            CalcFormula = sum("R. Shortlisting Criteria"."Desired Score" where("Need Code" = field(upperlimit("Recruitment Need"))));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Desired Score';
        }
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
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Shortlisting Criteria");
            NoSeriesMgt.InitSeries(HRSetup."Shortlisting Criteria", xRec."No Series", 0D, "No.", "No Series");
        end;
    end;

    var
        CompanyJob: Record "Company Job";
        HRSetup: Record "Human Resources Setup";
        RecruitNeed: Record "Recruitment Needs";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





