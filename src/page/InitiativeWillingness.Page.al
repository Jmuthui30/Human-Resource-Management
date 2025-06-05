page 52156 "Initiative & Willingness"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Competences";
    Caption = 'Initiative & Willingness';
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
                    Caption = 'Indicator';
                    ToolTip = 'Specifies the value of the Indicator field';
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





