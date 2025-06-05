page 52210 "Training Needs Request"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Needs Request";
    UsageCategory = Lists;
    Caption = 'Training Needs Request';
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
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
}





