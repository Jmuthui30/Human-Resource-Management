page 52275 "Payroll Approval-Staff"
{
    ApplicationArea = All;
    Caption = 'Payroll Approval-Staff';
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
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
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
                field("Total Earnings"; Rec."Total Earnings")
                {
                    ToolTip = 'Specifies the value of the Total Earnings field.';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field.';
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
                Enabled = CanCancelApprovalForRecord;
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
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Master Roll Report action';
                trigger OnAction()
                begin
                    Commit();

                    EmpRec.Reset();
                    EmpRec.SetFilter("Employee Type", '<>%1', EmpRec."Employee Type"::"Board Member");
                    EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                    if EmpRec.Find('-') then begin
                        Clear(MasterRoll);
                        MasterRoll.GetDefaults(Rec.Code);
                        MasterRoll.SetTableView(EmpRec);
                        MasterRoll.Run();
                    end;
                end;
            }

            action("NSSF Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the NSSF Report action';
                Caption = 'Net Pay Bank Transfer';

                trigger OnAction()
                begin
                    Commit();

                    EmpRec.Reset();
                    EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                    if EmpRec.Find('-') then begin
                        Clear(NSSFReport);
                        NSSFReport.GetDefaults(Rec.Code);
                        NSSFReport.SetTableView(EmpRec);
                        NSSFReport.Run();
                    end;
                end;
            }
            action("NHIF Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the NHIF Report action';
                Caption = 'Cash payment Report';

                trigger OnAction()
                begin
                    Commit();

                    CashPayment.Reset();
                    CashPayment.SetRange("Payroll Period", Rec."Payroll Period");
                    if CashPayment.Find('-') then begin
                        Clear(NHIFReport);
                        NHIFReport.GetDefaults(Rec.Code);
                        NHIFReport.SetTableView(CashPayment);
                        NHIFReport.Run();
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
        Rec."Employee Type" := Rec."Employee Type"::Staff;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Employee Type" := Rec."Employee Type"::Staff;
    end;

    var
        CashPayment: Record "Cash Payment";
        AssgnMatrix: Record "Assignment Matrix";
        EmpRec: Record Employee;
        PayrollPeriodX: Record "Payroll Period";
        HELBReport: Report HELB;
        MasterRoll: Report "Master Roll Report new";
        MonthlyPAYE: Report "Monthly PAYE Reportx";
        //Cash payment Report
        NHIFReport: Report "Cash payment Report";
        NITAReport: Report NITA;
        //Net Pay Bank Transfer (52064, 

        NSSFReport: Report "Net Pay Bank Transfer";
        PensionReport: Report "Pension Report";
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Approved) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}





