page 52163 "User Incidences Resolution"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "User Support Incident";
    SourceTableView = where("Incident Status" = filter(Unresolved));
    Caption = 'User Incidences Resolution';
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Incident Reference field';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Incident Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(User; Rec.User)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User field';
                }
                field("User email Address"; Rec."User email Address")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User email Address field';
                }
                field("Incidence Location"; Rec."Incidence Location")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Incidence Location field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            group(Incident)
            {
                field("Incident Description"; Rec."Incident Description")
                {
                    Editable = false;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Incident Description field';
                }
                field("Screen Shot"; Rec."Screen Shot")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Screen Shot field';
                }
            }
            group("Incidence Action")
            {
                group(Control25)
                {
                    Editable = (Rec."Status" = Rec."Status"::Pending) or (Rec."Status" = Rec."Status"::Escalated);
                    ShowCaption = false;

                    field("Action Date"; Rec."Action Date")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Action Date field';
                    }
                    field("Incident Status"; Rec."Incident Status")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Incident Status field';
                    }
                    field("Action taken"; Rec."Action taken")
                    {
                        MultiLine = true;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Action taken field';
                    }
                }
                group(Control24)
                {
                    ShowCaption = false;
                    Visible = Rec."Status" = Rec."Status"::Solved;

                    field("User Remarks"; Rec."User Remarks")
                    {
                        MultiLine = true;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the User Remarks field';
                    }
                }
            }
            group("Incidence Escalation")
            {
                Visible = false;

                field("Escalate To"; Rec."Escalate To")
                {
                    ToolTip = 'Specifies the value of the Escalate To field';
                }
                field("Ecalation Date"; Rec."Escalation Date")
                {
                    ToolTip = 'Specifies the value of the Ecalation Date field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Resolve)
            {
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Resolve action';

                trigger OnAction()
                begin
                    if Rec."Incident Status" = Rec."Incident Status"::Resolved then
                        Error(Error0001);
                    Rec.TestField("Action taken");

                    Rec."Action By" := UserId;
                    Rec."Action Date" := Today;
                    Rec."Action Time" := Time;
                    GetActionBy(Rec."Action By");
                    GetActionName(Rec."Action By");

                    Rec."Incidence Resolved" := true;
                    Rec.Status := Rec.Status::Solved;
                    Rec."Incident Status" := Rec."Incident Status"::Resolved;
                    Rec.Modify();
                    IncidentResolved(Rec."Incident Reference");
                    CurrPage.Close();
                end;
            }
            action(EscalateAction)
            {
                Image = MoveUp;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the EscalateAction action';

                trigger OnAction()
                begin
                    Rec."Action By" := UserId;
                    if Confirm('Do you want to escalate this incident?') then
                        Escalate(Rec."Incident Reference");
                    Rec.Status := Rec.Status::Escalated;
                    Message('Incident %1 has been escalated successfully');
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        Employee: Record Employee;
        ICTSetup: Record "ICT Setup";
        UserSetup: Record "User Setup";
        Incident: Record "User Support Incident";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Error0001: Label 'This Incident has already been resolved';
        Receipient: List of [Text];
        RecipientBCC: List of [Text];
        RecipientCC: List of [Text];
        Attachment: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;

    procedure Escalate(IncidentNo: Code[20])
    var
        Text0001: Label 'text';
        Text002: Label 'Incident has been escalated Successfully';
        FormattedBody: Text;
    begin
        Incident.Reset();
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-') then begin
            ICTSetup.Get();
            SenderAddress := GetActionBy(Rec."Action By");
            SenderName := GetActionName(Rec."Action By");
            Receipient.Add(ICTSetup."Escalation E-mail");
            RecipientCC.Add(ICTSetup."Security E-Mail");
            RecipientBCC.Add(ICTSetup."Registry BCC");
            Subject := 'Incident Escalation';
            Attachment := (ICTSetup."Screenshot Path" + Incident."Incident Reference" + '.jpg');
            TimeNow := Format(Time);

            FormattedBody := StrSubstNo(Text0001);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true, RecipientCC, RecipientBCC);
            Email.Send(EmailMessage);
            Message(Text002);
        end;
    end;

    procedure GetActionBy(UserrID: Code[50]): Text
    var
        ActionByEmail: Text[250];
    begin
        if UserSetup.Get(UserrID) then
            if Employee.Get(UserSetup.Picture) then
                ActionByEmail := Employee."E-Mail";
        exit(ActionByEmail);
    end;

    procedure GetActionName(UserrID: Code[50]): Text
    var
        ActionByName: Text[250];
    begin
        if UserSetup.Get(UserrID) then
            if Employee.Get(UserSetup.Picture) then
                ActionByName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        exit(ActionByName);
    end;

    procedure IncidentResolved(IncidentNo: Code[20])
    var
        Text0001: Label 'Hi, <br><br>You Incident %1 has been resolved. Kindly verify and close the Incident. <br><br>Thank you.<br><br>Regards,<br><br>%2';
        FormattedBody: Text;
    begin
        Incident.Reset();
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-') then begin
            SenderAddress := GetActionName(Incident."Action By");
            SenderAddress := GetActionBy(Incident."Action By");
            SenderName := GetActionName(Incident."Action By");
            Receipient.Add(Incident."User email Address");
            RecipientCC.Add(ICTSetup."Security E-Mail");
            RecipientBCC.Add(ICTSetup."Registry BCC");
            Subject := Incident."Incident Reference" + ' Resolved';
            TimeNow := (Format(Time));
            FormattedBody := StrSubstNo(Text0001, Incident."Incident Reference", SenderName);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true, RecipientCC, RecipientBCC);
            Email.Send(EmailMessage);
            Message('Incident Successfully Logged');
        end;
    end;
}





