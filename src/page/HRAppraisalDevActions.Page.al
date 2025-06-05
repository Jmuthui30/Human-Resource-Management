page 52063 "HR Appraisal Dev Actions"
{
    ApplicationArea = All;
    Caption = 'Appraisal Developmental Actions';
    PageType = ListPart;
    SourceTable = "Appraisal Comments";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                Caption = 'Control2';

                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appraisal No. field';
                    Caption = 'Appraisal No.';
                }
                field(Person; Rec.Person)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Person field';
                    Caption = 'Person';
                }
                field("Developmental Action"; Rec."Developmental Action")
                {
                    ToolTip = 'Specifies the value of the Developmental Action field.';
                    Caption = 'Developmental Action';
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Comments on Performance field';
                    Caption = 'Comments on Performance';
                }
            }
        }
    }
}





