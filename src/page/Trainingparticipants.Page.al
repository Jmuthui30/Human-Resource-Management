page 52209 "Training participants"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Participants";
    UsageCategory = Lists;
    Caption = 'Training participants';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Training Need"; Rec."Training Need")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Training Need field';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
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
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
            }
        }
    }
}





