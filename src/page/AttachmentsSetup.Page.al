page 52135 "Attachments Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = Attachments;
    Caption = 'Attachments Setup';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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





