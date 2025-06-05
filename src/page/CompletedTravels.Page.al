page 52151 "Completed Travels"
{
    ApplicationArea = All;
    CardPageID = "Transport Request";
    PageType = List;
    SourceTable = "Travel Requests";
    SourceTableView = where(Status = const(Released),
                            "Transport Status" = const(Completed));
    Caption = 'Completed Travels';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                    ToolTip = 'Specifies the value of the Request No. field';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Destinations; Rec.Destinations)
                {
                    ToolTip = 'Specifies the value of the Destinations field';
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    ToolTip = 'Specifies the value of the No. of Personnel field';
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                    Caption = 'Planned Start Date';
                    ToolTip = 'Specifies the value of the Planned Start Date field';
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                    Caption = 'Planned End Date';
                    ToolTip = 'Specifies the value of the Planned End Date field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
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





