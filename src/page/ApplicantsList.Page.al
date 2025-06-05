page 52087 "Applicants List"
{
    ApplicationArea = All;
    CardPageID = "Applicant Card";
    PageType = List;
    SourceTable = Applicants;
    Caption = 'Applicants List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field("Full Name"; Rec."Full Name")
                {
                    Caption = 'Full Name';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field';
                }
                field(Employ; Rec.Employ)
                {
                    Caption = 'Qualified';
                    ToolTip = 'Specifies the value of the Qualified field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field';
                }
                field(Notified; Rec.Notified)
                {
                    ToolTip = 'Specifies the value of the Notified field';
                }
                field(Submitted; Rec.Submitted)
                {
                    ToolTip = 'Specifies the value of the Submitted field';
                }
                field(Shortlist; Rec.Shortlist)
                {
                    ToolTip = 'Specifies the value of the Shortlist field';
                }
                field(Interviewed; Rec.Interviewed)
                {
                    ToolTip = 'Specifies the value of the Interviewed field';
                }
            }
        }
    }

    actions
    {
    }
}





