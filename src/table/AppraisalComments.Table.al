table 52085 "Appraisal Comments"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Comments';
    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
        }
        field(2; Person; Option)
        {
            OptionCaption = 'Appraiser,Appraisee,Second Supervisor,HR,Trust Secretary,Dev Action,Significant Positive Issues,Significant Negative Issues,Substantial Achievements,Perfomance Improvement Plan,Staff Training and Dev Needs,OtherInterventios,Mitigating Factors';
            OptionMembers = Appraiser,Appraisee,"Second Supervisor",HR,"Trust Secretary","Dev Action","Significant Positive Issues","Significant Negative Issues","Substantial Achievements","Perfomance Improvement Plan","Staff Training and Dev Needs","Other interventions","Mitigating Factors";
            Caption = 'Person';
        }
        field(3; "Performance Related Dicussions"; Boolean)
        {
            Caption = 'Performance Related Dicussions';
        }
        field(4; "Extent of Discussion Help"; Option)
        {
            OptionCaption = 'Very Much,Much,Not at all';
            OptionMembers = "Very Much",Much,"Not at all";
            Caption = 'Extent of Discussion Help';
        }
        field(5; "Comments on Performance"; Text[250])
        {
            Caption = 'Comments on Performance';
        }
        field(6; "Comments On Supervisor"; Text[250])
        {
            Caption = 'Comments On Supervisor';
        }
        field(7; "Comments by Second Suprvisor"; Text[250])
        {
            Caption = 'Comments by Second Suprvisor';
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
        }
        field(9; "Target Achievement"; Option)
        {
            OptionCaption = 'Values,Core Competences,Curriculum Delivery,Research,Initiative & Willingness,Managerial & Supervisory';
            OptionMembers = Values,"Core Competences","Curriculum Delivery",Research,"Initiative & Willingness","Managerial & Supervisory";
            Caption = 'Target Achievement';
        }
        field(10; "End Year Rating"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Appraisal No." = field("Appraisal No."),
                                                                   "Value/Core Competence" = field("Target Achievement")));
            FieldClass = FlowField;
            Caption = 'End Year Rating';
        }
        field(11; "Total Rating"; Decimal)
        {
            Caption = 'Total Rating';
        }
        field(12; "Average Rating"; Decimal)
        {
            Caption = 'Average Rating';
        }
        field(13; "Developmental Action"; Code[50])
        {
            Caption = 'Developmental Action';
            TableRelation = "Appraisal Devt Need Setup";

            trigger OnValidate()
            begin
                if DevNeeds.Get("Developmental Action") then
                    "Comments on Performance" := DevNeeds.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "Appraisal No.", Person, "Comments on Performance")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DevNeeds: Record "Appraisal Devt Need Setup";
}





