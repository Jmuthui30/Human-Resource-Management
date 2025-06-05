page 52019 "Employee Appoint CList Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Employee;
    Caption = 'Employee Appoint CList Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
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
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the value of the Initials field';
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'National ID';
                    ToolTip = 'Specifies the value of the National ID field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                }
            }
            part(Control11; "Appointment Checklist ListPart")
            {
            }
        }
    }

    actions
    {
    }
}





