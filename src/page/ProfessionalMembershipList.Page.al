page 52020 "Professional Membership List"
{
    ApplicationArea = All;
    CardPageID = "Professional Membership Card";
    PageType = List;
    SourceTable = Employee;
    Caption = 'Professional Membership List';
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
            }
        }
    }

    actions
    {
    }
}





