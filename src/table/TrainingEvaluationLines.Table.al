table 52161 "Training Evaluation Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Training Evaluation Lines';
    fields
    {
        field(1; "Training Evaluation No."; Code[20])
        {
            Caption = 'Training Evaluation No.';
        }
        field(2; "Personal No."; Code[20])
        {
            Caption = 'Personal No.';
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Evaluation Line Type"; Option)
        {
            OptionCaption = ' ,Course,Utilization,Expectation,Impact,TrainingTechniques,TrainingVenueFood,Recommendation,PersonlActionPlans,Barriers,OvercomingBarriers,ResourceReq,ImprovingWeakness,RecommendationNo';
            OptionMembers = " ",Course,Utilization,Expectation,Impact,TrainingTechniques,TrainingVenueFood,Recommendation,PersonlActionPlans,Barriers,OvercomingBarriers,ResourceReq,ImprovingWeakness,RecommendationNo;
            Caption = 'Evaluation Line Type';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';

            trigger OnValidate()
            begin
                GetNextLineNo();
            end;
        }
        field(6; "Action Plan"; Blob)
        {
            Caption = 'Action Plan';
        }
        field(7; "How To achieve"; Blob)
        {
            Caption = 'How to achieve the action Plan';
        }
        field(8; "Results to be achieved"; Blob)
        {
            Caption = 'Results to be achieved (Targets)';
        }
        field(9; Timeline; Blob)
        {
            Caption = 'Timeline';
        }
    }

    keys
    {
        key(Key1; "Training Evaluation No.", "Evaluation Line Type", "Personal No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure GetNextLineNo(): Integer
    var
        EvaluationLines: Record "Training Evaluation Lines";
    begin
        EvaluationLines.Reset();
        EvaluationLines.SetRange("Training Evaluation No.", "Training Evaluation No.");
        EvaluationLines.SetRange("Evaluation Line Type", "Evaluation Line Type");
        if EvaluationLines.FindLast() then
            exit(EvaluationLines."Line No." + 10000)
        else
            exit(10000);
    end;
}





