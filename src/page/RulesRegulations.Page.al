page 52065 "Rules & Regulations"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Rules & Regulations";
    Caption = 'Rules & Regulations';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Rules & Regulations"; Rec."Rules & Regulations")
                {
                    ToolTip = 'Specifies the value of the Rules & Regulations field';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
            }
            group(Control10)
            {
                ShowCaption = false;
                Visible = false;

                field("Document Link"; Rec."Document Link")
                {
                    ToolTip = 'Specifies the value of the Document Link field';
                }
                field("Language Code (Default)"; Rec."Language Code (Default)")
                {
                    ToolTip = 'Specifies the value of the Language Code (Default) field';
                }
                field(Attachement; Rec.Attachement)
                {
                    ToolTip = 'Specifies the value of the Attachement field';
                }
            }
        }
    }

    actions
    {
    }
}





