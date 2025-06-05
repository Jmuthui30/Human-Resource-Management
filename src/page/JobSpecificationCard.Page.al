page 52024 "Job Specification Card"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Company Job";
    Caption = 'Job Specification Card';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Job Description field';
                }
                field("Total Score"; Rec."Total Score")
                {
                    ToolTip = 'Specifies the value of the Total Score field';
                }
            }
        }
    }

    actions
    {
    }
}





