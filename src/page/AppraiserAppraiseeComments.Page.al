page 52040 "Appraiser & Appraisee Comments"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    Caption = 'Appraiser & Appraisee Comments';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                field("Line No"; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field';
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    ToolTip = 'Specifies the value of the Results Achieved Comments field';
                }
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
            }
        }
    }

    actions
    {
    }
}





