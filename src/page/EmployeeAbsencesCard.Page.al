page 52058 "Employee Absences Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Employee;
    Caption = 'Employee Absences Card';
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
                    ToolTip = 'Specifies the value of the ID No. field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field';
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field';
                }
            }
        }
    }

    actions
    {
    }
}





