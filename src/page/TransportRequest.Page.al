page 52075 "Transport Request"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Transport Management';
    SourceTable = "Travel Requests";
    Caption = 'Transport Request';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                field("Request No."; Rec."Request No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Request No. field';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field';
                }
                field("Request Time"; Rec."Request Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Time field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    Caption = 'Nature of Employement';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Nature of Employement field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin
                        SetPageView();
                    end;
                }
                label("Travel Details:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Reason for Travel"; Rec."Reason for Travel")
                {
                    ToolTip = 'Specifies the value of the Reason for Travel field';
                }
                field("Mode of Travel"; Rec."Mode of Travel")
                {
                    ToolTip = 'Specifies the value of the Mode of Travel field';

                    trigger OnValidate()
                    begin
                        SetPageView();
                    end;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field';
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                    ToolTip = 'Specifies the value of the Trip Planned Start Date field';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field';
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                    ToolTip = 'Specifies the value of the Trip Planned End Date field';
                }
                field("Return Time"; Rec."Return Time")
                {
                    ToolTip = 'Specifies the value of the Return Time field';
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of Personnel field';
                }
                field("No. of Non Employees"; Rec."No. of Non Employees")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. of Non Employees field';
                }
                field("No of Vehicles"; Rec."No of Vehicles")
                {
                    Caption = 'Vehicles Used';
                    Visible = Rec."Status" = Rec."Status"::Open;
                    ToolTip = 'Specifies the value of the Vehicles Used field';
                }
                field("Transport Status"; Rec."Transport Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transport Status field';
                }
            }
            part("Travelling Employees"; "Travelling Employees")
            {
                Editable = Rec."Status" = Rec."Status"::Open;
                SubPageLink = "Request No." = field("Request No.");
                UpdatePropagation = Both;
            }
            part("Travelling Non-Employees"; "Travelling Non Employees")
            {
                Editable = Rec."Status" = Rec."Status"::Open;
                SubPageLink = "Request No." = field("Request No.");
                UpdatePropagation = Both;
            }
            part(Trips; "Transport Trips")
            {
                SubPageLink = "Request No" = field("Request No.");
                Visible = Approved and Road;
            }
            part("Travel Expense"; "Travel Expense")
            {
                Editable = Rec."Status" = Rec."Status"::Open;
                SubPageLink = "Document No" = field("Request No.");
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    if ApprovalMgt.CheckTransportWorkflowEnabled(Rec) then
                        ApprovalMgt.OnSendTransportApprovalRequest(Rec);
                    Commit();

                    // //Check HOD approver
                    // IF UserSetup.GET(USERID) THEN
                    //  BEGIN
                    //    IF UserSetup."Customer No." THEN
                    //      BEGIN
                    //        ApprovalEntry.RESET;
                    //        ApprovalEntry.SETRANGE("Document No.","Request No.");
                    //        ModifyHODApprovals.SETTABLEVIEW(ApprovalEntry);
                    //        ModifyHODApprovals.RUNMODAL;
                    //      END;
                    //  END;

                    Commit();
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelTransportApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocType: Enum "Approval Document Type";
                begin
                    DocType := DocType::"Travel Requests";
                    ApprovalEntries.SetRecordFilters(Database::"Travel Requests", DocType, Rec."Request No.");
                    ApprovalEntries.Run();
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = false;
                ToolTip = 'Executes the Print action';

                trigger OnAction()
                begin
                    Travel.Reset();
                    Travel.SetRange("Request No.", Rec."Request No.");
                    Report.Run(Report::"Travel Request", true, false, Travel);
                end;
            }
            separator(Action19)
            {
            }
            /* action(Imprest)
            {
                ApplicationArea = All;
                Caption = 'Create Travel Imprest';
                Promoted = true;
                PromotedCategory = Process;
                Image = Holiday;
                ToolTip = 'Executes the Create Travel Imprest action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) then
                        HRManagement.CreateTravelImprest(rec);
                end;
            } */
            action("Notify Employees")
            {
                Image = Email;
                trigger OnAction()
                begin
                    HRManagement.NotifyTransportEmployees(Rec."Request No.");
                end;
            }
            group("Transport Management")
            {
                Caption = 'Transport Management';

                action(Vehicles)
                {
                    Image = Delivery;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    RunObject = page "Fleet List";
                    Visible = false;
                    ToolTip = 'Executes the Vehicles action';
                }
                action("Assign Vehicle")
                {
                    Enabled = Rec."Transport Status" = Rec."Transport Status"::"Requisition";
                    Image = NewShipment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Assign Vehicle action';

                    trigger OnAction()
                    begin

                        if Action::LookupOK = Page.RunModal(Page::"Fleet List", FA, FA."No.") then begin
                            Transport.Init();
                            Transport."Vehicle No" := FA."No.";
                            Transport."Request No" := Rec."Request No.";
                            Transport.Date := Today;
                            Transport.Validate("Vehicle No");
                            Transport.Insert();
                        end;
                    end;
                }
                action("Trip Start")
                {
                    Enabled = Rec."Transport Status" = Rec."Transport Status"::"Requisition";
                    Image = Delivery;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = Rec."Status" = Rec."Status"::"Released";
                    ToolTip = 'Executes the Trip Start action';

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Start the Trip %1 to %2?', true, Rec."Request No.", Rec.Destination) = false
                            then
                            exit;
                        if Rec."Mode of Travel" = Rec."Mode of Travel"::Road then begin
                            if Transport."Vehicle Type" <> Transport."Vehicle Type"::Taxi then begin
                                Transport.Reset();
                                Transport.SetRange("Request No", Rec."Request No.");
                                if Transport.Find('-') then
                                    Transport.TestField(Driver);
                            end;
                            Transport."Time Out" := Time;
                            Transport.Modify();

                            repeat
                                if FA.Get(Transport."Vehicle No") then begin
                                    FA."On Trip" := true;
                                    FA.Modify();
                                end;
                            until Transport.Next() = 0;
                        end;
                        Rec."Transport Status" := Rec."Transport Status"::"On Trip";
                        Rec.Modify();

                        if Confirm('Do you want to notify the Employee and Driver via mail?', false) then
                            HRManagement.NotifyTransportEmployees(Rec."Request No.");

                        Message('The Transport trip %1 from %2 has been Initiated', Rec."Request No.", Rec.Destination);
                        CurrPage.Close();
                    end;
                }
                action("Complete Trip")
                {
                    Enabled = Rec."Transport Status" = Rec."Transport Status"::"On Trip";
                    Image = Default;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = Rec."Status" = Rec."Status"::Released;
                    ToolTip = 'Executes the Complete Trip action';

                    trigger OnAction()
                    begin

                        if Confirm('Do you want to Complete the Trip %1 from %2?', true, Rec."Request No.", Rec.Destination) = false
                            then
                            exit;
                        if Rec."Mode of Travel" = Rec."Mode of Travel"::Road then
                            if Transport."Vehicle Type" <> Transport."Vehicle Type"::Taxi then begin
                                Transport.Reset();
                                Transport.SetRange("Request No", Rec."Request No.");
                                if Transport.Find('-') then
                                    Transport.TestField("Time In");
                                Transport.TestField("End of Journey KM");

                                repeat
                                    if FA.Get(Transport."Vehicle No") then begin
                                        FA."On Trip" := false;
                                        FA."Current Odometer Reading" := Transport."End of Journey KM";
                                        FA.Modify();
                                    end;
                                until Transport.Next() = 0;
                            end;
                        Rec."Transport Status" := Rec."Transport Status"::Completed;
                        Rec.Modify();
                        Message('The Transport trip %1 from %2 has been Completed', Rec."Request No.", Rec.Destination);

                        CurrPage.Close();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    var
        FA: Record "Fixed Asset";
        Transport: Record "Transport Trips";
        Travel: Record "Travel Requests";
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        HRManagement: Codeunit "HR Management";
        Approved: Boolean;
        Road: Boolean;

    procedure SetPageView()
    begin
        case Rec."Mode of Travel" of
            Rec."Mode of Travel"::Road,
          Rec."Mode of Travel"::" ":
                Road := true
            else
                Road := false;
        end;

        if Rec.Status = Rec.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}





