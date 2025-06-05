page 52118 "Acting Position Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Acting Position";
    Caption = 'Acting Position Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Promotion Type"; Rec."Document Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Promotion Type field';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field';
                }
                field("Job Description"; Rec."Job Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Description field';
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                    ToolTip = 'Specifies the value of the Relieved Employee field';
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relieved Name field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ToolTip = 'Specifies the value of the Maturity Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Duties Taken Over By"; Rec."Acting Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Current Scale"; Rec."Current Scale")
                {
                    ToolTip = 'Specifies the value of the Current Job Group field';
                    Editable = false;
                }
                field("Current Pointer"; Rec."Current Pointer")
                {
                    ToolTip = 'Specifies the value of the Current Pointer field';
                    Editable = false;
                }
                field("New Scale"; Rec."New Scale")
                {
                    ToolTip = 'Specifies the value of the New Scale field';
                }
                field("New Pointer"; Rec."New Pointer")
                {
                    ToolTip = 'Specifies the value of the New Pointer field';
                }
                field("Current Position"; Rec."Current Position")
                {
                    ToolTip = 'Specifies the value of the Current Position field.';
                }
                field("Current Position Name"; Rec."Current Position Name")
                {
                    ToolTip = 'Specifies the value of the Current Position Name field.';
                }
                field(Qualified; Rec.Qualified)
                {
                    ToolTip = 'Specifies the value of the Qualified field';
                }
                field(EmpPromoted; Rec.Processed)
                {
                    Caption = 'Processed';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Promoted field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            group("Reason For Acting")
            {
                Caption = 'Reason For Acting';

                field(Reason; Rec.Reason)
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Reason field';
                }
            }
            group("Financial Implication")
            {
                Editable = false;

                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field';
                }
                field("Current Benefits"; Rec."Current Benefits")
                {
                    ToolTip = 'Specifies the value of the Current Benefits field';
                    Editable = false;
                }
                field("New Benefits"; Rec."New Benefits")
                {
                    ToolTip = 'Specifies the value of the Current Benefits field';
                    Editable = false;
                }
                field("Difference Amount"; Rec."Difference Amount")
                {
                    ToolTip = 'Specifies the value of the Difference Amount field.';
                }
                field("Steps Higher Amount"; Rec."Steps Higher Amount")
                {
                    ToolTip = 'Specifies the value of the Steps Higher Amount field.';
                }
                field("Acting Amount"; Rec."Acting Amount")
                {
                    ToolTip = 'Specifies the value of the Acting Amount field';
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
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    if Confirm('Send for Approval?', true) = false then
                        exit else

                        if ApprovalsMgmt.CheckEmpActingAndPromotionWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendEmpActingAndPromotionRequestForApproval(Rec);

                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelEmpActingAndPromotionRequestApproval(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    Approvalentries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Employee Acting Position");
                    Approvals.SetRange("Document No.", Rec.No);
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Document Type" := Rec."Document Type"::Acting;
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
}





