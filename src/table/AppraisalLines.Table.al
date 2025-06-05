table 52016 "Appraisal Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Lines';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
        }
        field(2; "Appraisal Type"; Code[20])
        {
            Caption = 'Appraisal Type';
        }
        field(3; "Appraisal Period"; Code[20])
        {
            Caption = 'Appraisal Period';
        }
        field(4; "Key Responsibility"; Text[250])
        {
            NotBlank = true;
            TableRelation = "Strategic Imp Objectives";
            Caption = 'Key Responsibility';

            trigger OnValidate()
            var
                StrategicObj: Record "Strategic Imp Objectives";
            begin
                if StrategicObj.Get("Key Responsibility") then
                    "Key Responsibility" := StrategicObj.Description;
            end;
        }
        field(5; "No."; Code[20])
        {
            NotBlank = true;
            Caption = 'No.';
        }
        field(6; "Key Indicators"; Text[250])
        {
            Caption = 'Key Indicators';
        }
        field(7; "Agreed Target Date"; Text[100])
        {
            Caption = 'Agreed Target Date';
        }
        field(8; Weighting; Decimal)
        {
            BlankZero = true;
            Caption = 'Weighting';
        }
        field(9; "Results Achieved Comments"; Text[250])
        {
            Caption = 'Results Achieved Comments';
        }
        field(10; "Score/Points"; Decimal)
        {
            BlankZero = true;
            Caption = 'Score/Points';

            trigger OnValidate()
            begin
            end;
        }
        field(11; "Job ID"; Code[20])
        {
            Caption = 'Job ID';
        }
        field(12; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(13; "Appraiser's Comments"; Text[150])
        {
            Caption = 'Appraiser''s Comments';
        }
        field(14; "Appraisee's comments"; Text[150])
        {
            Caption = 'Appraisee''s comments';
        }
        field(15; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(16; "Appraisal Heading Type"; Option)
        {
            OptionMembers = " ",Objectives,"Core Values","Core Competencies","Managerial and Supervisory";
            Caption = 'Appraisal Heading Type';
        }
        field(17; "Appraisal Header"; Text[50])
        {
            TableRelation = "Appraisal Format Header";
            Caption = 'Appraisal Header';
        }
        field(18; Bold; Boolean)
        {
            Caption = 'Bold';
        }
        field(19; "Appraisal No"; Code[20])
        {
            Caption = 'Appraisal No';
        }
        field(20; Rating; Decimal)
        {
            Caption = 'Rating(1-5)';
        }
        field(21; Type; Option)
        {
            OptionCaption = 'Performance Plan,Appraisal';
            OptionMembers = "Performance Plan",Appraisal;
            Caption = 'Type';
        }
        field(22; Status; Option)
        {
            OptionCaption = 'Setting,Review,Appraisal';
            OptionMembers = Setting,Review,Appraisal;
            Caption = 'Status';
        }
        field(23; Indentation; Integer)
        {
            MinValue = 0;
            Caption = 'Indentation';
        }
        field(24; "Mid-Year Appraisal"; Decimal)
        {
            BlankZero = true;
            Caption = 'Mid-Year Appraisal';

            trigger OnValidate()
            begin
                TestField(Weighting);
                if "Mid-Year Appraisal" > Weighting then
                    Error('Value cannot be greater than Weighting value');
            end;
        }
        field(25; "Final Self-Appraisal"; Decimal)
        {
            BlankZero = true;
            Caption = 'Final Self-Appraisal';

            trigger OnValidate()
            begin

                Variance := "Score/Points" - "Final Self-Appraisal";
            end;
        }
        field(26; "Appraisal Line Type"; Option)
        {
            Caption = 'Objective Type';
            OptionCaption = 'Objective,Main Heading,Main Heading End,Sub-Heading,Sub-Heading End';
            OptionMembers = Objective,"Objective Heading","Objective Heading End","Sub-Heading","Sub-Heading End";

            trigger OnValidate()
            begin
                HrMgt.IndentAppraisalGoals("Appraisal No");
            end;
        }
        field(27; Totaling; Text[250])
        {
            Caption = 'Totaling';
        }
        field(28; KPI; Text[50])
        {
            Caption = 'KPI';
        }
        field(29; "FY Target"; Decimal)
        {
            caption = 'Approved performance targets';
        }
        field(30; Variance; Decimal)
        {
            Caption = 'Variance';
        }
        field(31; "Initiative code"; Code[50])
        {
            TableRelation = "Strategic Imp Initiatives".Code where(ObjectiveCode = field("Workplan Code"));
            Caption = 'Initiative code';

            trigger OnValidate()
            var
                StrategicInit: Record "Strategic Imp Initiatives";
            begin
                StrategicInit.Reset();
                StrategicInit.SetRange(Code, "Initiative code");
                if StrategicInit.Find('-') then
                    Description := StrategicInit.Initiatives;
            end;
        }
        field(32; "Activity code"; Code[10])
        {
            TableRelation = "Strategic Imp Activities"."Activity Code" where(InitiativeCode = field("Initiative code"));
            Caption = 'Activity code';

            trigger OnValidate()
            var
                StrategicAct: Record "Strategic Imp Activities";
            begin
                StrategicAct.Reset();
                StrategicAct.SetRange(StrategicAct."Activity Code", "Activity code");
                if StrategicAct.Find('-') then
                    "Key Indicators" := StrategicAct.Activities;
            end;
        }
        field(33; "Objective Code"; Code[20])
        {
            TableRelation = "Strategic Imp Objectives";
            Caption = 'Objective Code';

            trigger OnValidate()
            var
                StrategicObj: Record "Strategic Imp Objectives";
            begin
                StrategicObj.Reset();
                StrategicObj.SetRange(Code, "Objective Code");
                if StrategicObj.Find('-') then
                    "Key Responsibility" := StrategicObj.Description;
            end;
        }
        field(34; Task; Code[500])
        {
            Caption = 'Task';
        }
        field(35; "Agreed perfomance targets"; Text[1000])
        {
            Caption = 'Agreed perfomance targets';
        }
        field(36; "Actual targets"; Text[1000])
        {
            Caption = 'Actual/achieved targets';
        }
        field(37; "Workplan Code"; Code[50])
        {
            Caption = 'Workplan Code';
            TableRelation = "Appraisal Workplan Code".Code;
        }
        field(38; "Performance Measure"; Code[50])
        {
            Caption = 'Performance Measure';
            TableRelation = "Appraisal Perfomance Measures".Code where("Workplan Code" = field("Workplan Code"));
            trigger OnValidate()
            begin
                if PerformanceMeasures.Get("Workplan Code", "Performance Measure") then
                    "Actual targets" := PerformanceMeasures.Description;
            end;
        }
        field(39; "Achieved (%)"; Decimal)
        {
            Caption = 'Achieved (%)';
        }
        field(40; "Weighted Rating"; Decimal)
        {
            Caption = 'Weighted Rating';
        }
    }

    keys
    {
        key(Key1; "Appraisal No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PerformanceMeasures: Record "Appraisal Perfomance Measures";
        HrMgt: Codeunit "HR Management";
}





