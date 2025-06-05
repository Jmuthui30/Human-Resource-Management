page 52213 "Training Evaluation Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Training Evaluation Header";
    Caption = 'Training Evaluation Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Training Evaluation No."; Rec."Training Evaluation No.")
                {
                    ToolTip = 'Specifies the value of the Training Evaluation No. field';
                }
                field("Personal No."; Rec."Personal No.")
                {
                    ToolTip = 'Specifies the value of the Personal No. field';
                }
                field("Name of the participant"; Rec."Name of participant")
                {
                    ToolTip = 'Specifies the value of the Name of participant field';
                }
                field("Course Title"; Rec."Training Name")
                {
                    ToolTip = 'Specifies the value of the Training Name field';
                }
                field("Course Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                part(CourseTitle; "Training Evaluation Lines")
                {
                    Caption = 'Course Title Evaluation';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Course);
                }
                part(KnowledgeSkills; "Training Evaluation Lines")
                {
                    Caption = 'Knowledge Evaluation';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Utilization);
                }
                part(Expectation; "Training Evaluation Lines")
                {
                    Caption = 'Were your expectations met? ';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Expectation);
                }
                part(Impact; "Training Evaluation Lines")
                {
                    Caption = 'What has been the impact of the training on you?';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Impact);
                }
                part(Improving; "Training Evaluation Lines")
                {
                    Caption = 'And how to improve on my weak areas';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(ImprovingWeakness);
                }
                part(TrainingTechniques; "Training Evaluation Lines")
                {
                    Caption = 'Were you satisfied with the training techniques';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(TrainingTechniques);
                }
                part(TrainingFoodVenue; "Training Evaluation Lines")
                {
                    Caption = 'Were you satisfied with the food served?';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(TrainingVenueFood);
                }
                part(Recommendation; "Training Evaluation Lines")
                {
                    Caption = 'Any recommendations?';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Recommendation);
                }
                part(RecommendationNo; "Training Evaluation Lines")
                {
                    Caption = 'If your answer is no, please explain';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(RecommendationNo);
                }
                part(PersonalActionPlans; "Training Evaluation Lines")
                {
                    Caption = 'PERSONAL ACTION PLANS: (What actions are you putting in place to improve on your performance /training needs as a result of this training?)';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(PersonlActionPlans);
                }
                part(Barriers; "Training Evaluation Lines")
                {
                    Caption = 'State the barriers that may impede the implementation of your action plans and how you intend to overcome them.';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Barriers);
                }
                part(OverComingBarriers; "Training Evaluation Lines")
                {
                    Caption = 'How To Overcome- assignments';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(OvercomingBarriers);
                }
                part(ReqResources; "Training Evaluation Lines")
                {
                    Caption = 'State the resource requirements (people, equipments, extra skills) that will enable you implement the action plans.';
                    SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(ResourceReq);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Image = Home;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Submit action';

                trigger OnAction()
                begin
                    Rec.Submitted := true;
                end;
            }
        }
        area(reporting)
        {
            action("Training Evaluation Report")
            {
                Caption = 'Training Evaluation Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Training Evaluation Report action';

                trigger OnAction()
                var
                    EvalHeader: Record "Training Evaluation Header";
                begin
                    EvalHeader.Reset();
                    EvalHeader.SetRange(EvalHeader."Training Evaluation No.", Rec."Training Evaluation No.");
                    if EvalHeader.Find('-') then
                        Report.Run(Report::"Training Evaluation Report", true, false, EvalHeader);
                end;
            }
        }
    }
}





