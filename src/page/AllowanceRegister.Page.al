page 52284 "Allowance Register"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Allowance Register";
    PromotedActionCategories = 'New,Process,Print Report,Post,Attachments,Approvals';
    Caption = 'Allowance Register';
    //DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec."Status" = Rec."Status"::"open";

                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    Caption = 'Employee Type';
                    ToolTip = 'Specifies the value of the Employee Type field.';
                    ShowMandatory = true;
                }
                field("Applies To All"; Rec."Applies To All")
                {
                    ToolTip = 'Specifies the value of the Applies To All field.';
                }
                group(EarningCode)
                {
                    Visible = Rec."Applies To All";
                    field("Earning Code"; Rec."Earning Code")
                    {
                        Caption = 'Earning Code';
                        ToolTip = 'Specifies the value of the Earning Code field.';
                        ShowMandatory = true;
                    }
                    field("Date of Activity"; Rec."Date of Activity")
                    {
                        Caption = 'Date of Activity';
                        ToolTip = 'Specifies the value of the Date of Activity field.';
                        ShowMandatory = true;
                    }
                    field(Description; Rec.Description)
                    {
                        Caption = 'Remarks';
                        ToolTip = 'Specifies the value of the Description field';
                    }
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Caption = 'Payroll Period';
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Caption = 'Date Created';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Caption = 'Date Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Posted field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Caption = 'Total Gross Amount';
                }
                field("Total PAYE"; Rec."Total PAYE")
                {
                    Caption = 'Total PAYE';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    Caption = 'Total Net Amount';
                }
            }
            part(Control11; "Allowance Register Lines")
            {
                Caption = 'Allowance Register Lines';
                //Editable = (Rec."Status" = Rec."Status"::"open");// or (Rec."Status" = Rec."Status"::Approved);
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146691),
                              "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Enabled = Rec."Status" = Rec."Status"::Approved;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post action';

                trigger OnAction()
                var
                    Text001: Label 'Are you sure you want to post the allowances ?';
                    Text002: Label 'The Allowance Amounts have been successfully Posted.';
                begin
                    if Confirm(Text001, false) then begin
                        PayrollManagement.PostAllowances(Rec, false);
                        Message(Text002);
                    end;

                    CurrPage.Close();
                end;
            }
            action(Preview)
            {
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Category4;
                ShortCutKey = 'Ctrl+Alt+F9';
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';
                Enabled = Rec."Status" = Rec."Status"::Approved;

                trigger OnAction()
                var
                    Text001: Label 'Are you sure you want to preview posting the allowances?';
                begin
                    if Confirm(Text001, false) = true then
                        PayrollManagement.PostAllowances(Rec, true);
                end;
            }
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Send Approval Request")
            {
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Image = SendApprovalRequest;
                Enabled = Rec.Status = Rec.Status::Open;
                Caption = 'Send Approval Request';
                ToolTip = 'Executes the Send Approval Plan action';

                trigger OnAction()
                var
                    ConfirmApprovalMsg: Label 'Are you sure you want to send an approval request?';
                begin
                    if Confirm(ConfirmApprovalMsg, false) then
                        if ApprovalMgt.CheckAllowanceRegisterWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendAllowanceRegisterForApproval(Rec);

                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Image = CancelApprovalRequest;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";
                Caption = 'Cancel Approval Request';
                ToolTip = 'Executes the Cancel Approval action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelAllowanceRegisterRequest(Rec);
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Allowance Register");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
            action(InsertEmployees)
            {
                Image = Users;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Insert All Accounts';
                Enabled = Rec."Applies To All";

                trigger OnAction()
                begin
                    PayrollManagement.InsertAllEmployeesOnAllowanceRegister(Rec);
                end;
            }
            action(ValidateNetAmt)
            {
                Promoted = true;
                Image = ValidateEmailLoggingSetup;
                PromotedCategory = Process;
                Caption = 'Validate Net Amount';
                Enabled = Rec.Status <> Rec.Status::Posted;

                trigger OnAction()
                var
                    AllowanceRegisterLines: Record "Allowance Register Line";
                begin
                    AllowanceRegisterLines.SetRange("Document No.", Rec."No.");
                    if AllowanceRegisterLines.FindSet() then
                        repeat
                            AllowanceRegisterLines.Validate("Net Amount");
                            AllowanceRegisterLines.Modify();
                        until AllowanceRegisterLines.Next() = 0;
                end;
            }
        }
        area(Reporting)
        {
            action(PrintReport)
            {
                Caption = 'Print Report';
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AllowanceReport: Report "Allowance Register";
                begin
                    Clear(AllowanceReport);

                    AllowanceRegister.SetRange("No.", Rec."No.");
                    AllowanceReport.SetTableView(AllowanceRegister);
                    AllowanceReport.Run();
                end;
            }
        }
    }

    var
        AllowanceRegister: Record "Allowance Register";
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        PayrollManagement: Codeunit Payroll;
}





