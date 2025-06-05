page 52158 "Appraisee's Appraisal Comments"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    Caption = 'Appraisee''s Appraisal Comments';
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
                field(Person; Rec.Person)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Person field';
                }
                field("Performance Related Dicussions"; Rec."Performance Related Dicussions")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Performance Related Dicussions field';
                }
                field("Extent of Discussion Help"; Rec."Extent of Discussion Help")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Extent of Discussion Help field';
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    Caption = 'Appraisee';
                    ToolTip = 'Specifies the value of the Appraisee field';
                }
                field("Comments On Supervisor"; Rec."Comments On Supervisor")
                {
                    Caption = 'Appraiser';
                    ToolTip = 'Specifies the value of the Appraiser field';
                }
                field(Date; Rec.Date)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
            }
        }
    }

    actions
    {
    }
}





