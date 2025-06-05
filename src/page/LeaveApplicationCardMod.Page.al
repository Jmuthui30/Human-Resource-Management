page 52279 "Leave Application Card Mod"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Leave Application";
    Caption = 'Leave Application Card Mod';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                label("Application Details")
                {
                    Caption = 'Application Details';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Application No"; Rec."Application No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Application No field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Date of Application';
                    ToolTip = 'Specifies the value of the Date of Application field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Employment Type field';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mobile No field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Leave Period field';
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                    ToolTip = 'Specifies the value of the Leave Type field';
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Status field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                label(Balances)
                {
                    Caption = 'Balances';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Leave Entitlment field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Balance brought forward field';
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Earned to Date field';
                }
                field(LeaveAdjustments; Rec.LeaveAdjustments)
                {
                    Caption = 'Leave Adjustments';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Leave Adjustments field';
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    Caption = 'No of Days Taken To Date';
                    Editable = false;
                    ShowCaption = true;
                    ToolTip = 'Specifies the value of the No of Days Taken To Date field';
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Recalled Days field';
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Days Absent field';
                }
                field("Off Days"; Rec."Off Days")
                {
                    Caption = 'Off Days';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Off Days field';
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    Caption = 'Available Leave Balance';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Available Leave Balance field';
                }
                label("Current Application Details")
                {
                    Caption = 'Current Application Details';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Days Applied field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'From';
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the From field';
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'To';
                    Editable = false;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the To field';
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Editable = false;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Resumption Date field';
                }
                field("Annual Leave Entitlement Bal"; Rec."Annual Leave Entitlement Bal")
                {
                    Caption = 'Leave Balance';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Leave Balance field';
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duties Taken Over By field';
                }
                field("Relieving Name"; Rec."Relieving Name")
                {
                    Caption = 'Name';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Leave Allowance Payable field';
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    Caption = 'Approval Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Approval Status field';
                }
            }
            part(Control3; "Leave Relievers")
            {
                SubPageLink = "Leave Code" = field("Application No");
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = field("Application No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Action34)
            {
                action("Send For Approval")
                {
                    Caption = 'Send Approval Request';
                    Enabled = Rec."Status" = Rec."Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send Approval Request action';

                    trigger OnAction()
                    begin

                        /*if ApprovalsMgmt.CheckLeaveRequestWorkflowEnabled(Rec) then
                          ApprovalsMgmt.OnSendLeaveRequestApproval(Rec);*/
                        Commit();

                        Message(Rec."Employee No");
                        //Check HOD approver
                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."Employee No.", Rec."Employee No");
                        if UserSetup.FindFirst() then
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset();
                                ApprovalEntry.SetRange("Table ID", Database::"Leave Application");
                                ApprovalEntry.SetRange("Document No.", Rec."Application No");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal();
                            end;

                        Commit();
                        CurrPage.Close();

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Cancel Approval Request action';

                    trigger OnAction()
                    begin
                        //ApprovalManagement.OnCancelLeaveRequestApproval(Rec);
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Approvals action';

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetCurrentKey("Document No.");
                        ApprovalEntry.SetRange("Document No.", Rec."Application No");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.Run();
                    end;
                }
            }
            action("Notify Empoyees")
            {
                Image = Holiday;
                ToolTip = 'Executes the Notify Empoyees action';

                trigger OnAction()
                begin
                    //HRMgnt.SendLeaveNotice(HRMgnt.GetEmail("Employee No"),Employee.Name,"Application No","Employee No");
                end;
            }
        }
        area(creation)
        {
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Executes the Print action';

                trigger OnAction()
                begin
                    LeaveApp.Reset();
                    LeaveApp.SetRange("Application No", Rec."Application No");
                    Report.Run(Report::"Leave Report", true, false, LeaveApp);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."Application No");
        if ApprovalEntry.Find('-') then
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        LeaveApp: Record "Leave Application";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ShowCommentFactbox: Boolean;
}





