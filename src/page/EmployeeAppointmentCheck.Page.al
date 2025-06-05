page 52018 "Employee Appointment Check"
{
    ApplicationArea = All;
    CardPageID = "Employee Appoint CList Card";
    PageType = List;
    SourceTable = Employee;
    Caption = 'Employee Appointment Check';
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
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field';
                }
            }
        }
    }

    actions
    {
    }
}





