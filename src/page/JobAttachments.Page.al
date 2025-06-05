page 52134 "Job Attachments"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Job Attachments";
    Caption = 'Job Attachments';
    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("Job ID"; Rec."Job ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachment field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}





