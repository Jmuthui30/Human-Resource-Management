page 52110 "Applicant's Employment History"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Applicants Employment History";
    Caption = 'Applicant''s Employment History';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No field';
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ToolTip = 'Specifies the value of the Institution/Company field';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field';
                }
                field("To"; Rec."To")
                {
                    ToolTip = 'Specifies the value of the To field';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field';
                }
                field("Application No"; Rec."Application No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Application No field';
                }
            }
        }
    }

    actions
    {
    }
}





