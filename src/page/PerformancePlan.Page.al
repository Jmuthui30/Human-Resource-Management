page 52039 "Performance Plan"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    SourceTableView = where("Appraisal Heading Type" = const(Objectives));
    Caption = 'Performance Plan';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No field';
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Objectives';
                    ToolTip = 'Specifies the value of the Objectives field';
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Action Plan';
                    ToolTip = 'Specifies the value of the Action Plan field';
                }
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field';
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Caption = 'Reasons';
                    ToolTip = 'Specifies the value of the Reasons field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Lock Targets")
            {
                Image = CompleteLine;
                ToolTip = 'Executes the Lock Targets action';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Review;
                    Setting := true;
                    Message('Target Locked');
                end;
            }
            action("Review Target")
            {
                Image = DocumentEdit;
                ToolTip = 'Executes the Review Target action';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Appraisal;
                    Setting := false;
                    Review := true;
                    Message('Targets Changed');
                end;
            }
            action("Score Awards")
            {
                Image = Confirm;
                ToolTip = 'Executes the Score Awards action';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Setting;
                    Message('Score Awarded');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Appraisal Heading Type" := Rec."Appraisal Heading Type"::Objectives;
    end;

    var
        Review: Boolean;
        Setting: Boolean;

    procedure SetStatus()
    begin
    end;
}





