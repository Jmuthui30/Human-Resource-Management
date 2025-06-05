page 52160 "HR Appraisal Comments"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    Caption = 'HR Appraisal Comments';
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
                field("Developmental Action"; Rec."Developmental Action")
                {
                    ToolTip = 'Specifies the value of the Developmental Action field.';
                    Visible = Rec.Person = Rec.Person::"Dev Action";
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Comments on Performance field';
                }
            }
        }
    }
}





