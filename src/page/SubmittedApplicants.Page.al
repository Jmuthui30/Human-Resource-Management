page 52296 "Submitted Applicants"
{
    ApplicationArea = All;
    Caption = 'Submitted Applicants';
    CardPageID = "Submitted Applicant Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Applicants;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    Caption = 'No.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                    Caption = 'Application Date';
                }
                field("Full Name"; Rec."Full Name")
                {
                    Caption = 'Full Name';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                    Caption = 'ID Number';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field';
                    Caption = 'Citizenship';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field';
                    Caption = 'Date Of Birth';
                }
                field(Employ; Rec.Employ)
                {
                    Caption = 'Qualified';
                    ToolTip = 'Specifies the value of the Qualified field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    Caption = 'Global Dimension 1 Code';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field';
                    Caption = 'Applicant Type';
                }
                field(Notified; Rec.Notified)
                {
                    ToolTip = 'Specifies the value of the Notified field';
                    Caption = 'Notified';
                }
                field(Submitted; Rec.Submitted)
                {
                    ToolTip = 'Specifies the value of the Submitted field';
                    Caption = 'Submitted';
                }
                field(Shortlist; Rec.Shortlist)
                {
                    ToolTip = 'Specifies the value of the Shortlist field';
                    Caption = 'Shortlist';
                }
                field(Interviewed; Rec.Interviewed)
                {
                    ToolTip = 'Specifies the value of the Interviewed field';
                    Caption = 'Interviewed';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Names")
            {
                trigger OnAction()
                begin
                    if Rec.FindSet() then
                        repeat
                            Rec.GetFullName();
                            Rec.Modify();
                        until Rec.Next() = 0;
                end;
            }
        }
    }
}





