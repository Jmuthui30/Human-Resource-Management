page 52016 "Employment History List"
{
    ApplicationArea = All;
    CardPageID = "Scale Benefits";
    PageType = List;
    SourceTable = Employee;
    Caption = 'Employment History List';
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
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
            }
        }
    }

    actions
    {
    }
}





