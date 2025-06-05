page 52215 "Training Evaluation List"
{
    ApplicationArea = All;
    PageType = List;
    CardPageId = "Training Evaluation Card";
    SourceTable = "Training Evaluation Header";
    UsageCategory = Lists;
    Caption = 'Training Evaluation List';
    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Training Name"; Rec."Training Name")
                {
                    ToolTip = 'Specifies the value of the Training Name field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}





