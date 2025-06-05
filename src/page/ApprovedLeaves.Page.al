page 52080 "Approved Leaves"
{
    ApplicationArea = All;
    CardPageID = "Leave Application Card Mod";
    PageType = List;
    SourceTable = "Leave Application";
    SourceTableView = where(Status = filter(Released));
    Caption = 'Approved Leaves';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ToolTip = 'Specifies the value of the Application No field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }

                field("Leave Code"; Rec."Leave Code")
                {
                    ToolTip = 'Specifies the value of the Leave Code field';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ToolTip = 'Specifies the value of the Days Applied field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Email Adress"; rec."Email Adress")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Email Adress field';
                }
            }
        }
    }

    actions
    {
    }
}





