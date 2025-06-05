page 52025 "Job Specification List"
{
    ApplicationArea = All;
    CardPageID = "Job Specification Card";
    PageType = List;
    SourceTable = "Company Job";
    Caption = 'Job Specification List';
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
                field("No of Posts"; Rec."No of Posts")
                {
                    ToolTip = 'Specifies the value of the No of Posts field';
                }
            }
        }
    }

    actions
    {
    }
}





