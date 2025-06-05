page 52109 "Maintenance Request"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Maintenance Registration";
    Caption = 'Maintenance Request';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Maintenance No"; Rec."Maintenance No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Maintenance No field';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field';
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item Description field';
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ToolTip = 'Specifies the value of the Service Provider field';
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Service Provider Name field';
                }
                field("Service Interval Type"; Rec."Service Interval Type")
                {
                    ToolTip = 'Specifies the value of the Service Interval Type field';
                }
                field("Service/Repair Description"; Rec."Service/Repair Description")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Service/Repair Description field';
                }
                field("Service Period"; Rec."Service Period")
                {
                    ToolTip = 'Specifies the value of the Service Period field';
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ToolTip = 'Specifies the value of the Date of Service field';
                }
                field("Current Odometer Reading"; Rec."Current Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Current Odometer Reading field';
                }
                field("Service Mileage"; Rec."Service Mileage")
                {
                    ToolTip = 'Specifies the value of the Service Mileage field';
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ToolTip = 'Specifies the value of the Next Service Date field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field(Employee; Rec.Employee)
                {
                    ToolTip = 'Specifies the value of the Employee field';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Driver Name field';
                }
                field("Driver's Signature"; Rec."Driver's Signature")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Driver''s Signature field';
                }
                field(Signature; Rec.Signature)
                {
                    ToolTip = 'Specifies the value of the Signature field';
                }
                field("Transport Manager Remarks"; Rec."Transport Manager Remarks")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Transport Manager Remarks field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin

                        if Rec.Status = Rec.Status::Approved then begin
                            FA.Reset();
                            FA.SetRange("No.", Rec."Item No.");
                            if FA.Find('-') then begin
                                FA."Maintainence Status" := FA."Maintainence Status"::"Under Maintenence";
                                FA.Modify();
                            end;
                        end;
                    end;
                }
                field("Service LSO/LPO No."; Rec."Service LSO/LPO No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Service LSO/LPO No. field';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Invoice No. field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this request for approval?', true) = false
                      then
                        exit;

                    Rec.Status := Rec.Status::Approved;
                end;
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Cancel Approval action';

                trigger OnAction()
                begin

                    /*
                    FA.Reset();
                    FA.SetRange("No.","Item No.");
                    if FA.Find('-') then
                      begin
                        FA."Maintainence Status":=FA."Maintainence Status"::Available;
                        FA.Modify();
                      end;
                    */

                end;
            }
            action("Mark Under Maintenance")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Mark Under Maintenance action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to mark this Vehicle to be Under Maintenance?', true) = false
                      then
                        exit;

                    if FA.Get(Rec."Item No.") then begin
                        FA."Under Maintenance" := true;
                        FA.Modify();
                    end;

                    Message('The Vehicle has been marked Under Maintenance');
                end;
            }
            action("Return to List")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Return to List action';

                trigger OnAction()
                begin

                    if Confirm('Do you wish to get the Vehicle back to Available List?', true) = false then
                        exit;

                    if FA.Get(Rec."Item No.") then begin
                        FA."Under Maintenance" := false;
                        FA.Modify();
                    end;
                end;
            }
        }
    }

    var
        FA: Record "Fixed Asset";

    procedure VehReturn()
    begin
        FA.Reset();
        FA.SetRange("No.", Rec."Item No.");
        if FA.Find('-') then begin
            FA."Maintainence Status" := FA."Maintainence Status"::Available;
            FA.Modify();
        end;
    end;

    procedure VehUnderMaintainence()
    begin
        FA.Reset();
        FA.SetRange("No.", Rec."Item No.");
        if FA.Find('-') then begin
            FA."Maintainence Status" := FA."Maintainence Status"::"Under Maintenence";
            FA.Modify();
        end;
    end;
}





