page 52032 "Approved Leave Recalls"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Employee Off/Holiday";
    SourceTableView = where(Status = const(Released));
    Caption = 'Approved Leave Recalls';
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
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ToolTip = 'Specifies the value of the Recalled From field';
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    ToolTip = 'Specifies the value of the Recalled To field';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
    }
}





