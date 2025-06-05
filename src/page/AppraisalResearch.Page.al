page 52155 "Appraisal Research"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Competences";
    Caption = 'Appraisal Research';
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

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Rating; Rec.Rating)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Rating field';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field';
                }
            }
        }
    }

    actions
    {
    }
}





