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
            action("Monthly PAYE Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Monthly PAYE Report action';

                trigger OnAction()
                begin
                    Commit();

                    EmpRec.Reset();
                    EmpRec.SetFilter("Employee Type", '<>%1', EmpRec."Employee Type"::"Board Member");
                    EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                    if EmpRec.Find('-') then begin
                        Clear(MonthlyPAYE);
                        MonthlyPAYE.GetDefaults(Rec.Code);
                        MonthlyPAYE.SetTableView(EmpRec);
                        MonthlyPAYE.Run();
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

                trigger OnAction()
                begin
                    Commit();

                    AssgnMatrix.Reset();
                    AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                    if AssgnMatrix.Find('-') then begin
                        Clear(NSSFReport);
                        NSSFReport.GetDefaults(Rec.Code);
                        NSSFReport.SetTableView(AssgnMatrix);
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

                trigger OnAction()
                begin
                    Commit();

                    AssgnMatrix.Reset();
                    AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                    if AssgnMatrix.Find('-') then begin
                        Clear(NHIFReport);
                        NHIFReport.GetDefaults(Rec.Code);
                        NHIFReport.SetTableView(AssgnMatrix);
                        NHIFReport.Run();
                    end;
                end;
            }
            action("HELB Report")
            {
                Visible = false;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the HELB Report action';

                trigger OnAction()
                begin
                    Commit();

                    PayrollPeriodX.Reset();
                    PayrollPeriodX.SetRange("Starting Date", Rec."Payroll Period");
                    if PayrollPeriodX.Find('-') then begin
                        Clear(HELBReport);
                        HELBReport.GetDefaults(Rec.Code);
                        HELBReport.SetTableView(PayrollPeriodX);
                        HELBReport.Run();
                    end;
                end;
            }
            action("Pension Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Pension Report action';

                trigger OnAction()
                begin
                    Commit();

                    AssgnMatrix.Reset();
                    AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                    if AssgnMatrix.Find('-') then begin
                        Clear(PensionReport);
                        PensionReport.GetDefaults(Rec.Code);
                        PensionReport.SetTableView(AssgnMatrix);
                        PensionReport.Run();
                    end;
                end;
            }
            action("NITA Report")
            {
                Visible = false;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the NITA Report action';

                trigger OnAction()
                begin
                    Commit();

                    PayrollPeriodX.Reset();
                    PayrollPeriodX.SetRange("Starting Date", Rec."Payroll Period");
                    if PayrollPeriodX.Find('-') then begin
                        Clear(NITAReport);
                        NITAReport.GetDefaults(Rec.Code);
                        NITAReport.SetTableView(PayrollPeriodX);
                        NITAReport.Run();
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
        AssgnMatrix: Record "Assignment Matrix";
        EmpRec: Record Employee;
        PayrollPeriodX: Record "Payroll Period";
        HELBReport: Report HELB;
        MasterRoll: Report "Master Roll Report";
        MonthlyPAYE: Report "Monthly PAYE Reportx";
        NHIFReport: Report NHIF;
        NITAReport: Report NITA;
        NSSFReport: Report "NSSF Reporting";
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





