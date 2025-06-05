page 52247 "Payroll Change Adjustment"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Payroll Change Header";
    Caption = 'Payroll Change Adjustment';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field(Time; Rec.Time)
                {
                    Caption = 'Time';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part(Control10; "Emp. Payment Req Lines")
            {
                SubPageLink = "Document No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Pay Change")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Import Pay Change action';

                trigger OnAction()
                begin
                    Clear(ExportPayChange);
                    ExportPayChange.GetHeaderNo(Rec);
                    ExportPayChange.Run();
                end;
            }
            action("send approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the send approval action';

                trigger OnAction()
                begin
                    if ApprovalMgt.CheckPayrollChangeWorkflowEnabled(Rec) then
                        ApprovalMgt.OnSendPayrollChangeforApproval(Rec);
                end;
            }
            action("cancel approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the cancel approval action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelPayrollChangeApproval(Rec);
                end;
            }
            action(approval)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the approval action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocType: Enum "Approval Document Type";
                begin
                    DocType := DocType::"Payroll Change";
                    ApprovalEntries.SetRecordFilters(Database::"Payroll Change Header", DocType, Rec.No);
                    ApprovalEntries.Run();
                end;
            }
        }
    }

    var
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        ExportPayChange: XMLport "Export Payroll Change";
}





