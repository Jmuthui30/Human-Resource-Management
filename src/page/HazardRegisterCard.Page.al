page 52008 "Hazard Register Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Reject';
    SourceTable = "User Support Incident";
    Caption = 'Hazard Register Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'No.';
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                label("Raised By:")
                {
                    Style = Strong;
                    StyleExpr = true;
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("User email Address"; Rec."User email Address")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                label("Hazard Description:")
                {

                    Style = Strong;
                    StyleExpr = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Incidence Location Name"; Rec."Incidence Location Name")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Hazard Location';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Hazard Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    Caption = 'Hazard Time';
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'Hazard Description';
                    Enabled = Rec.Status = Rec.Status::Open;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("System Support Email Address"; Rec."System Support Email Address")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field("Incident Cause"; Rec."Incident Cause")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Caption = 'Hazard Cause';
                }
                field("Action taken"; Rec."Action taken")
                {
                    Enabled = Rec.Status = Rec.Status::Pending;
                    ApplicationArea = Basic, Suite;
                }
                field(Priority; Rec.Priority)
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("User Remarks"; Rec."User Remarks")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Recommendation';
                    MultiLine = true;
                }
                field("Incident Rating"; Rec."Incident Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Image:"; Rec."Screen Shot")
                {
                    Caption = 'Image';
                }
                field("Rejection reason"; Rec."Rejection reason")
                {
                    Enabled = Rec.Status = Rec.Status::Pending;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Incident Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Caption = 'Hazard Report';

                trigger OnAction()
                begin
                    Incident.Reset();
                    Incident.SetRange("Incident Reference", Rec."Incident Reference");
                    Report.Run(Report::"Incident Report", true, false, Incident);
                end;
            }
            action("Send Incident")
            {
                //Visible = Rec.Status = Rec.Status::Open;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Text0001: Label 'Do you want to Send the Incident %1?';
                begin
                    if Confirm(Text0001, false, Rec."Incident Reference") then
                        AuditMgt.SendRiskIncident(Rec."Incident Reference");
                end;
                //exit(true);
            }
            action(Solve)
            {
                //Visible = (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Escalated);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Solved;
                    Rec."Incident Status" := Rec."Incident Status"::Resolved;
                    Rec.Modify(true);
                end;
            }
            action(Escalate)
            {
                //Visible = Rec.Status = Rec.Status::Pending;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Escalated;
                    Rec.Modify(true);
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Incident';
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                //Visible = Rec.Status = Rec.Status::Pending;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Rejection reason" = '' then
                        Error('Please input reject reason');
                    //AuditMgt.NotifyIncidSenderOnChanges(Rec);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.Close();
                end;
            }
            action(Close)
            {
                //Visible = (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Escalated) or (Rec.Status = Rec.Status::Solved);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify(true);
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Risk;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Risk;
    end;

    var
        Incident: Record "User Support Incident";
        AuditMgt: Codeunit "HR Management";
}







