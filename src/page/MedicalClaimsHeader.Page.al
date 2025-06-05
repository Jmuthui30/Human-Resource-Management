page 52105 "Medical Claims Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Medical Claims";
    Caption = 'Medical Claims Header';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Claim No"; Rec."Claim No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Claim No field';
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ToolTip = 'Specifies the value of the Claim Date field';
                }
                field(Claimant; Rec.Claimant)
                {
                    ToolTip = 'Specifies the value of the Claimant field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field(OutEntitlement; Rec.OutEntitlement)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the OutEntitlement field';
                }
                field(InEntitlement; Rec.InEntitlement)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the InEntitlement field';
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ToolTip = 'Specifies the value of the Service Provider field';
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Service Provider Name field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Total Claims"; Rec."Total Claims")
                {
                    ToolTip = 'Specifies the value of the Total Claims field';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
                field(Settled; Rec.Settled)
                {
                    ToolTip = 'Specifies the value of the Settled field';
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of Approvals field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
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
                    Message('Coming Soon');
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
                    Message('Coming Soon');
                end;
            }
            action("View Approvals")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                begin
                    Message('Coming Soon');
                end;
            }
        }
    }
}





