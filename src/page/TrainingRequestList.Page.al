page 52055 "Training Request List"
{
    ApplicationArea = All;
    CardPageID = "Training Request Card";
    PageType = List;
    SourceTable = "Training Request";
    SourceTableView = where(Status = filter(<> Released));
    Caption = 'Training Request List';
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

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."HOD User" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("User ID", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}





