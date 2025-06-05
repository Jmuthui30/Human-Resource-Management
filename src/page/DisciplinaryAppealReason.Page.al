page 52299 "Disciplinary Appeal Reason"
{
    ApplicationArea = All;
    Caption = 'Disciplinary Appeal Reason';
    PageType = StandardDialog;
    SourceTable = "Employee Discplinary";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reason for Appeal"; Rec."Reason for Appeal")
                {
                    ToolTip = 'Specifies the value of the Reason for Appeal field.';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Appeal Approval")
            {
                Image = SendApprovalRequest;
                Enabled = Rec."Appeal Status" = Rec."Appeal Status"::Open;
                Caption = 'Send Committee For Approval';
                ToolTip = 'Executes the Send Approval Committee action';

                trigger OnAction()
                begin
                    Rec.Posted := false;
                    Rec."Appeal Status" := Rec."Appeal Status"::"Pending Approval";
                    Rec.Modify();
                end;
            }
            action("Cancel Appeal Approval Request")
            {
                Image = CancelApprovalRequest;
                Enabled = Rec."Appeal Status" = Rec."Appeal Status"::"Pending Approval";
                Caption = 'Cancel Committee Approval Request';
                ToolTip = 'Executes the Cancel Approval Committee action';

                trigger OnAction()
                begin
                    //ApprovalMgt.OnCancelTenderCommitteeRequest(Rec);
                    Rec."Appeal Status" := Rec."Appeal Status"::Open;
                    Rec.Modify();
                end;
            }
        }
    }
}






