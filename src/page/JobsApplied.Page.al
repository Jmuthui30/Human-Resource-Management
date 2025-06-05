page 52204 "Jobs Applied"
{
    ApplicationArea = All;
    Caption = 'Jobs applied';
    PageType = ListPart;
    SourceTable = "Applicant job applied";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Application No. field';
                }
                field("Need Code"; Rec."Need Code")
                {
                    ToolTip = 'Specifies the value of the Need Code field';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Job field';
                }
            }
        }
    }
}





