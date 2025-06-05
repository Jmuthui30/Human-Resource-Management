page 52277 "Payroll Approval-Board"
{
    ApplicationArea = All;
    Caption = 'Payroll Approval-Board';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Payroll Approval";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;

                field(Code; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Type field';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Period Description"; Rec."Period Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Description field';
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Prepared By field';
                }
                field("Date-Time Prepared"; Rec."Date-Time Prepared")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date-Time Prepared field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = not OpenApprovalEntriesExist;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    if ApprovalMgt.CheckPayrollApprovalWorkflowEnabled(Rec) then
                        ApprovalMgt.OnSendPayrollApprovalRequest(Rec);

                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = CanCancelApprovalForPayment;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelPayrollApprovalRequest(rec);
                    CurrPage.Close();
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Payroll Approval");
                    Approvals.SetRange("Document No.", Rec.Code);
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
        }
        area(Reporting)
        {
            action("Master Roll Report")
            {
                ToolTip = 'Executes the Master Roll Report action';

                trigger OnAction()
                begin
                    Commit();
                    Clear(MasterRollBoard);

                    AssgnMatrix.Reset();
                    AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                    if AssgnMatrix.Find('-') then begin
                        MasterRollBoard.GetDefaults(Rec.Code);
                        MasterRollBoard.SetTableView(AssgnMatrix);
                        MasterRollBoard.Run();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
    end;

    var
        AssgnMatrix: Record "Assignment Matrix";
        MasterRollBoard: Report "Master Roll-Board Members";
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        CanCancelApprovalForPayment: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Approved) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
    end;
}





