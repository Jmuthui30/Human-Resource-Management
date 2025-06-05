page 52137 "Completed Interviews"
{
    ApplicationArea = All;
    CardPageID = "Interview Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Job Application";
    SourceTableView = where("Application Status" = const(Interviewed));
    Caption = 'Completed Interviews';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Specifies the value of the Applicant Name field.';
                }
                field("Job Applied Code"; Rec."Job Applied Code")
                {
                    ToolTip = 'Specifies the value of the Job Applied Code field.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                }

                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ToolTip = 'Specifies the value of the Date-Time Created field.';
                }
                field("Application Status"; Rec."Application Status")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                }
            }
        }
    }

    actions
    {
    }
}





