table 52050 "Interview Stage"
{
    DataClassification = CustomerContent;
    Caption = 'Interview Stage';
    fields
    {
        field(1; "Request No"; Code[20])
        {
            Caption = 'Request No';
        }
        field(2; "Applicant No"; Code[20])
        {
            Caption = 'Applicant No';
        }
        field(3; Panel; Code[20])
        {
            TableRelation = "Interview Panel Members"."Panel Member Code";
            Caption = 'Panel';
        }
        field(4; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(5; "Marks Awarded"; Decimal)
        {
            Caption = 'Marks Awarded';
            trigger OnValidate()
            begin
                if "Marks Awarded" > "Maximum Marks" then
                    Error('Marks Awaraded can not be greater than Maximum Set Mark');
            end;
        }
        field(6; "Test Parameter"; Code[20])
        {
            TableRelation = "Interview Setup".Code;
            Caption = 'Test Parameter';

            trigger OnValidate()
            begin
                InterviewSetup.Get("Test Parameter");
                InterviewSetup.TestField("Maximum Marks");
                Description := InterviewSetup.Description;
                "Interview Type" := InterviewSetup.Type;
                "Maximum Marks" := InterviewSetup."Maximum Marks";
                "Pass Mark" := InterviewSetup."Pass Mark";
            end;
        }
        field(7; "Maximum Marks"; Decimal)
        {
            Editable = false;
            Caption = 'Maximum Marks';
        }
        field(8; "Pass Mark"; Decimal)
        {
            Editable = false;
            Caption = 'Pass Mark';
        }
        field(9; "Interview Type"; Option)
        {
            OptionCaption = ' ,Oral,Practical';
            OptionMembers = " ",Oral,Practical;
            Caption = 'Interview Type';
        }
        field(10; "Panel Member Name"; Text[250])
        {
            CalcFormula = lookup("Interview Panel Members"."Panel Member Name" where("Panel Member Code" = field(Panel)));
            Caption = 'Panel Member Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Applicant No", Panel, "Test Parameter")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        InterviewSetup: Record "Interview Setup";
}





