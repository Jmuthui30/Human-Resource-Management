page 52202 "Transport requests -General"
{
    ApplicationArea = All;
    CardPageID = "Transport Request";
    PageType = List;
    SourceTable = "Travel Requests";
    Caption = 'Transport requests -General';
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
                    Caption = 'Requested By';
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Destinations; Rec.Destinations)
                {
                    ToolTip = 'Specifies the value of the Destinations field';
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
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Caption = 'Employees';
                    ToolTip = 'Specifies the value of the Employees field';
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





