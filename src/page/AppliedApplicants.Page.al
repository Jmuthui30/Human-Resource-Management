page 52114 "Applied Applicants"
{
    ApplicationArea = All;
    PageType = Listpart;
    SourceTable = Applicants;
    SourceTableView = where(Submitted = filter(true), Qualified = filter(true));
    Caption = 'Applied Applicants';
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
                field("Job Applied For"; Rec."Job Applied For")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the Job Applied For field';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field("Total Score"; Rec."Total Score")
                {
                    ToolTip = 'Specifies the value of the Total Score field';
                }
                field(Qualified; Rec.Qualified)
                {
                    ToolTip = 'Specifies the value of the Qualified field';
                }
                field(Employ; Rec.Employ)
                {
                    Caption = 'Shortlist';
                    ToolTip = 'Specifies the value of the Shortlist field';
                }
                field("Interview Date"; Rec."Interview Date")
                {
                    ToolTip = 'Specifies the value of the Interview Date field';
                }
                field("Interview Time"; Rec."Interview Time")
                {
                    ToolTip = 'Specifies the value of the Interview Time field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Applicant Card")
            {
                // Promoted = true;
                Image = View;
                //PromotedCategory = Process;
                // PromotedIsBig = true;
                // PromotedOnly = true;
                RunObject = page "Applicant Card";
                RunPageLink = "No." = field("No.");
                RunPageMode = View;
                Caption = 'View Applicant Card';
            }
        }
    }

    var
        FieldOfStudyFilter: Code[250];

    procedure Load(_FieldOfStudyFilter: Code[250])
    begin

        FieldOfStudyFilter := _FieldOfStudyFilter;
    end;
}





