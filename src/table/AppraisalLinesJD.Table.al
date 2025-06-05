table 52084 "Appraisal Lines-JD"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Lines-JD';
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
            Caption = 'Key Responsibility';
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
                TestField(Weighting);
                if "Score/Points" > Weighting then
                    Error('Value cannot be greater than Weighting value');
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
            TableRelation = "Score Setup";
            Caption = 'Rating';
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
                TestField(Weighting);
                if "Final Self-Appraisal" > Weighting then
                    Error('Value cannot be greater than Weighting value');
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
        HrMgt: Codeunit "HR Management";
}





