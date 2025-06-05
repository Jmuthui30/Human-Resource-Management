page 52054 "Approved Training Request List"
{
    ApplicationArea = All;
    CardPageID = "Training Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "Training Request";
    SourceTableView = where(Status = const(Released));
    Caption = 'Approved Training Request List';
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
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field("No. Of Days"; Rec."No. Of Days")
                {
                    ToolTip = 'Specifies the value of the No. Of Days field';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field';
                }
                field(Venue; Rec.Venue)
                {
                    ToolTip = 'Specifies the value of the Venue field';
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





