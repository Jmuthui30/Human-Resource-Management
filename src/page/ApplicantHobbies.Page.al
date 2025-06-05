page 52100 "Applicant Hobbies"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = Listpart;
    SourceTable = "Applicant Hobbies";
    Caption = 'Applicant Hobbies';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Hobbies; Rec.Hobbies)
                {
                    ToolTip = 'Specifies the value of the Hobbies field';
                }
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Line No"; Rec."Line No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No field';
                }
            }
        }
    }

    actions
    {
    }
}





