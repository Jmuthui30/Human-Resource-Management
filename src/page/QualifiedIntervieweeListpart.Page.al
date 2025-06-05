page 52116 "Qualified Interviewee Listpart"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Job Application";
    Caption = 'Qualified Interviewee Listpart';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Select To Hire"; Rec."Select To Hire")
                {
                    ToolTip = 'Specifies the value of the Select To Hire field.';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                    Editable = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Specifies the value of the Applicant Name field.';
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    Editable = false;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Editable = false;
                }
                field("Oral Average Score"; Rec."Oral Average Score")
                {
                    ToolTip = 'Specifies the value of the Oral Average Score field.';
                }
                field("Practical Average Score"; Rec."Practical Average Score")
                {
                    ToolTip = 'Specifies the value of the Practical Average Score field.';
                }
                field("Total Average Score"; Rec."Total Average Score")
                {
                    ToolTip = 'Specifies the value of the Total Average Score field.';
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    ToolTip = 'Specifies the value of the Expected Reporting Date field';
                    Editable = Rec."Select To Hire";
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field.';
                    Editable = Rec."Select To Hire";
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Applicant Information")
            {
                Image = View;
                RunObject = page "Submitted Applicant Card";
                RunPageLink = "No." = field("Applicant No.");
                RunPageMode = View;
                Caption = 'View Applicant Information';
            }
        }
    }
}





