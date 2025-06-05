page 52159 "Second Supervisor Comments"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    Caption = 'Second Supervisor Comments';
    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

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
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Comments on Performance field';
                }
            }
        }
    }

    actions
    {
    }
}





