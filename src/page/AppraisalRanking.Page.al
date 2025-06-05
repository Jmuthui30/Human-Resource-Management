page 52069 "Appraisal Ranking"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Appraisal Grades";
    Caption = 'Appraisal Ranking';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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





