page 52021 "Professional Membership Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Employee;
    Caption = 'Professional Membership Card';
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
            }
            part(Control8; "Professional Membership")
            {
            }
        }
    }

    actions
    {
    }
}





