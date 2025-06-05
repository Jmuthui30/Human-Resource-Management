page 52068 "Appraisal Types"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Appraisal Type";
    Caption = 'Appraisal Types';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field';
                }
                field("Max. Weighting"; Rec."Max. Weighting")
                {
                    ToolTip = 'Specifies the value of the Max. Weighting field';
                }
                field("Minimum Job Group"; Rec."Minimum Job Group")
                {
                    ToolTip = 'Specifies the value of the Minimum Job Group field';
                }
                field("Maximum Job Group"; Rec."Maximum Job Group")
                {
                    ToolTip = 'Specifies the value of the Maximum Job Group field';
                }
                field("Max. Score"; Rec."Max. Score")
                {
                    ToolTip = 'Specifies the value of the Max. Score field';
                }
                field("Use Template"; Rec."Use Template")
                {
                    ToolTip = 'Specifies the value of the Use Template field';
                }
                field("Template Link"; Rec."Template Link")
                {
                    ToolTip = 'Specifies the value of the Template Link field';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClosePeriod)
            {
                Caption = 'Close Appraisal Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Close Appraisal Period action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this period?', false) then begin
                        Rec.Closed := true;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }
}





