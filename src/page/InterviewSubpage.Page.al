page 52093 "Interview Subpage"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Interview Stage";
    Caption = 'Interview Subpage';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    ToolTip = 'Specifies the value of the Applicant No field';
                    Visible = false;
                }
                field(Panel; Rec.Panel)
                {
                    Caption = 'Panel Member Code';
                    ToolTip = 'Specifies the value of the Panel Member Code field';
                }
                field("Panel Member Name"; Rec."Panel Member Name")
                {
                    ToolTip = 'Specifies the value of the Panel Member Name field.';
                }
                field("Test Parameter"; Rec."Test Parameter")
                {
                    ToolTip = 'Specifies the value of the Test Parameter field';
                }
                field("Marks Awarded"; Rec."Marks Awarded")
                {
                    ToolTip = 'Specifies the value of the Marks Awarded field';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
                field("Maximum Marks"; Rec."Maximum Marks")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Maximum Marks field';
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pass Mark field';
                }
            }
        }
    }

    actions
    {
    }
}





