page 52301 "Incident Report"
{
    ApplicationArea = All;
    Caption = 'Service Desk';
    // PageType = Card;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Reject';
    SourceTable = "User Support Incident";

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
            }
            group("Incident Identification")
            {
                label("Description:")
                {

                    Style = Strong;
                    StyleExpr = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Incidence Location Name"; Rec."Incidence Location Name")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Incidence Location';
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Responsible User HOD"; Rec."Responsible User HOD")
                {
                    ToolTip = 'Specifies the value of the Responsible User HOD field.';
                    Editable = false;
                }
                field("Responsible User E-Mail"; Rec."Responsible User E-Mail")
                {
                    ToolTip = 'Specifies the value of the Responsible User E-Mail field.';
                    Editable = false;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Incident Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
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
                }
                field("Incident Cause"; Rec."Incident Cause")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("Image:"; Rec."Screen Shot")
                {
                    Caption = 'Image';
                }
                field("Incident Rating"; Rec."Incident Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("User Remarks"; Rec."User Remarks")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Recommendation';
                    MultiLine = true;
                }
            }

            group("Assignment & Response")
            {

                field(Priority; Rec.Priority)
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                }


                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Support Recommendation"; Rec."Support Recommendation")
                {
                    Caption = 'Support Recommendation';
                    MultiLine = true;
                }
            }




            group(Escalation)
            {
                Editable = Rec.Status = Rec.Status::Pending;

                field("Escalate To"; Rec."Escalate To")
                {
                    ToolTip = 'Specifies the value of the Escalate To field';
                }
                field("Escalation Date"; Rec."Escalation Date")
                {
                    ToolTip = 'Specifies the value of the Ecalation Date field';
                }
                field("Escalate To Email"; Rec."Escalate To Email")
                {
                    ToolTip = 'Specifies the value of the Escalate To Email field.';
                }
                field("Escalation Levels"; Rec."Escalation Levels")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Escalation Recommendation"; Rec."Escalation Recommendation")
                {
                    //ApplicationArea=All;
                    ToolTip = 'Specifies the Escalation Recommendation.';
                    MultiLine = true;


                }
            }

            group("Closure & Resolution")
            {
                field("Rejection reason"; Rec."Rejection reason")
                {
                    Enabled = Rec.Status = Rec.Status::Pending;
                    MultiLine = true;
                }
                field("Action taken"; Rec."Action taken")
                {
                    Enabled = Rec.Status = Rec.Status::Pending;
                    MultiLine = true;

                }

            }


        }
    }

    actions
    {
        area(Processing)
        {
            group(actions1)
            {

                action("Incident Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Caption = 'Service Desk Report';

                    trigger OnAction()
                    begin
                        Incident.Reset();
                        Incident.SetRange("Incident Reference", Rec."Incident Reference");
                        Report.Run(Report::"Incident Report", true, false, Incident);
                    end;
                }
                action("Send Incident")
                {
                    Visible = Rec.Status = Rec.Status::Open;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text0001: Label 'Do you want to Send the Incident %1?';
                    begin
                        if Confirm(Text0001, false, Rec."Incident Reference") then begin
                            HRMgt.SendRiskIncident(Rec."Incident Reference");

                            CurrPage.Close();
                        end;
                    end;
                    //exit(true);
                }
                action(Solve)
                {
                    Visible = (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Escalated);
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to solve this incident?', false) then begin
                            HRMgt.SolveIncident(Rec);
                            CurrPage.Close();
                        end;
                    end;
                }

            }
            group(Escalations)
            {
                action("Esclate Level 1 Support")
                {
                    Visible = (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Escalated);
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Caption = 'Escalate Incident';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to escalate this incident?', false) then begin
                            HRMgt.EscalateIncidentLevel1(Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                /* action("Esclate Level 2 Support")
                {
                    //Visible = Rec.Status = Rec.Status::Pending;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to escalate this incident?', false) then
                            HRMgt.EscalateIncidentLevel2(Rec);
                        CurrPage.Close;
                    end;
                }
                action("Esclate Level 3 Support")
                {
                    //Visible = Rec.Status = Rec.Status::Pending;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to escalate this incident?', false) then
                            HRMgt.EscalateIncidentLevel3(Rec);
                        CurrPage.Close;
                    end;
                }
                action("Esclate Level External")
                {
                    //Visible = Rec.Status = Rec.Status::Pending;
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to escalate this incident?', false) then
                            HRMgt.EscalateIncidentExternal(Rec);
                        CurrPage.Close;
                    end;
                } */
            }
            action(Reject)
            {
                Caption = 'Reject Incident';
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reject this incident?', false) then begin
                        if Rec."Rejection reason" = '' then
                            Error('Please input reject reason');
                        //AuditMgt.NotifyIncidSenderOnChanges(Rec);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
                end;
            }
            action(Close)
            {
                Visible = (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Escalated) or (Rec.Status = Rec.Status::Solved);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this incident?', false) then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify(true);
                        CurrPage.Close();
                    end;
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    var
        Incident: Record "User Support Incident";
        HRMgt: Codeunit "HR Management";
}







