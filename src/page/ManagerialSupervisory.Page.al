page 52157 "Managerial & Supervisory"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Competences";
    Caption = 'Managerial & Supervisory';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appraisal No. field';
                }
                field("Value/Core Competence"; Rec."Value/Core Competence")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Value/Core Competence field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Competency';
                    ToolTip = 'Specifies the value of the Competency field';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field';
                }
                field("Comments (Negative)"; Rec."Comments (Negative)")
                {
                    ToolTip = 'Specifies the value of the Comments (Negative) field';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field';
                }
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field';
                }
            }
        }
    }

    actions
    {
    }
}





