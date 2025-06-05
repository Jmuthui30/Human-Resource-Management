page 52219 "Applicant Job Prof Membership"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Applicant Job professional membership';
    PageType = ListPart;
    SourceTable = "Applicant Prof Membership";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Professional Body"; Rec."Professional Body")
                {
                    ToolTip = 'Specifies the value of the Professional Body field';
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(MembershipNo; Rec.MembershipNo)
                {
                    ToolTip = 'Specifies the value of the MembershipNo field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No. field';
                }
                field("Line No"; Rec."Line No.")
                {
                    Enabled = false;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field("Need Code"; Rec."Need Code")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Need Code field';
                }
            }
        }
    }
}





