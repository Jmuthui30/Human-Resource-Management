page 52211 "Training Needs Requisitions"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Needs Request";
    UsageCategory = Lists;
    Editable = true;
    Caption = 'Training Needs Requisitions';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Source Document No"; Rec."Source Document No")
                {
                    ToolTip = 'Specifies the value of the Source Document No field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field("Training Name"; Rec."Training Name")
                {
                    ToolTip = 'Specifies the value of the Training Name field';
                }
                field("Training area"; Rec."Training area")
                {
                    ToolTip = 'Specifies the value of the Training area field';
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    ToolTip = 'Specifies the value of the Training Objectives field';
                }
                field(Venue; Rec.Venue)
                {
                    ToolTip = 'Specifies the value of the Venue field';
                }
                field(Provider; Rec.Provider)
                {
                    ToolTip = 'Specifies the value of the Provider field';
                }
                field("Need Source"; Rec."Need Source")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Need Source field';
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Training Need")
            {
                Visible = Rec.Status = Rec.Status::New;
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create a Training need action';

                trigger OnAction()
                var
                    TrainingNeeds: Record "Training Need";
                begin
                    TrainingNeeds.Init();
                    TrainingNeeds.Code := '';
                    TrainingNeeds."Need Source" := Rec."Need Source";
                    TrainingNeeds."Training Objectives" := Rec."Training Objectives";
                    TrainingNeeds.Insert(true);
                    Page.Run(Page::"Training Needs", TrainingNeeds);
                    Rec."Need created" := true;
                    Rec.Status := Rec.Status::Created;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                Visible = Rec.Status = Rec.Status::New;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Reject action';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify();
                end;
            }
        }
    }
}





