page 52111 "Employee Promotion_Demotion"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Acting Position";
    Caption = 'Employee Promotion_Demotion';
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
                    ToolTip = 'Specifies the value of the Promotion Type field';
                }
                label("Request:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Request Name"; Rec."Request Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Name field';
                }
                label("Employee:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee No."; Rec."Acting Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Current Position"; Rec."Current Position")
                {
                    ToolTip = 'Specifies the value of the Current Position field.';
                }
                field("Current Position Name"; Rec."Current Position Name")
                {
                    ToolTip = 'Specifies the value of the Current Position Name field.';
                }
                label("New Position:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("New Position"; Rec."Desired Position")
                {
                    ToolTip = 'Specifies the value of the Desired Position field';
                }
                field("Position Name"; Rec."Position Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Position Name field';
                }
                field("New Job Group"; Rec."New Scale")
                {
                    ToolTip = 'Specifies the value of the New Scale field';
                }
                field("New Pointer"; Rec."New Pointer")
                {
                    ToolTip = 'Specifies the value of the New Pointer field';
                }
                field(EmpPromoted; Rec.Processed)
                {
                    Caption = 'Processed';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Processed field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            group("Reason ")
            {
                Caption = 'Reason';

                field(Reason; Rec.Reason)
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Reason field';
                }
            }
            group("Promotion Benefits")
            {
                Editable = false;
                Caption = 'New Benefits';

                field("Current Job Group"; Rec."Current Scale")
                {
                    Caption = 'Current Job Group';
                    ToolTip = 'Specifies the value of the Current Job Group field';
                }
                field("Current Pointer"; Rec."Current Pointer")
                {
                    ToolTip = 'Specifies the value of the Current Pointer field';
                }
                field("Current Benefits"; Rec."Current Benefits")
                {
                    ToolTip = 'Specifies the value of the Current Benefits field';
                }
                label("Grade Benefits")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("New Benefits"; Rec."New Benefits")
                {
                    ToolTip = 'Specifies the value of the New Benefits field';
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

                    if Confirm('Do you want to the send the request for approval?', true) = false then
                        exit else
                        if ApprovalsMgmt.CheckEmpActingAndPromotionWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendEmpActingAndPromotionRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelEmpActingAndPromotionRequestApproval(Rec);
                end;
            }
            action(ViewApporvals)
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
                    ApprovalEntry.SetRange("Document No.", Rec.No);
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            action(Action)
            {
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec.Status = Rec.Status::Approved;
                ToolTip = 'Executes the Promote action';
                Caption = 'Process Document';

                trigger OnAction()
                var
                    Employee: Record Employee;
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", Rec."Acting Employee No.");
                    if Employee.FindFirst() then begin

                        Employee."Job Position" := Rec."Desired Position";
                        Employee."Job Position Title" := Rec."Position Name";
                        Employee.Validate("Salary Scale", Rec."New Scale");
                        Employee.Validate("Present Pointer", Rec."New Pointer");
                        Employee.Halt := Rec."Current Pointer";
                        Employee.Modify();
                    end;
                    Assign.Reset();
                    Assign.SetRange("Employee No", Rec."Acting Employee No.");
                    Assign.SetRange("Basic Salary Code", true);
                    Assign.SetRange(Closed, false);
                    if Assign.FindFirst() then begin
                        Assign.Amount := Rec."New Benefits";
                        Assign.Modify();
                    end;

                    Rec.Processed := true;
                    Rec.Modify();

                end;
            }

            action("Promotion Letter")
            {
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    PromotionRec.Reset();
                    PromotionRec.SetRange(No, Rec.No);
                    PromotionLetter.SetTableView(PromotionRec);
                    PromotionLetter.Run();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //Rec."Promotion Type" := Rec."Promotion Type"::Promotion;
    end;

    var
        Assign: Record "Assignment Matrix";
        PromotionRec: Record "Employee Acting Position";

        PromotionLetter: Report "Promotion Letter";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
}





