page 52162 "User Incidences Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Send Incident,ICT Delegation';
    SourceTable = "User Support Incident";
    Caption = 'User Incidences Card';
    layout
    {
        area(content)
        {
            group("Incident Logging")
            {
                Caption = 'Incident Logging';

                field("Incident Reference"; Rec."Incident Reference")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Incident Reference field';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Incident Time field';
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
                field("User email Address"; Rec."User email Address")
                {
                    ToolTip = 'Specifies the value of the User email Address field';
                }
                field(Sent; Rec.Sent)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Sent field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Incident Status field';
                }
            }
            group("Incident attachment")
            {
                Caption = 'Incident attachment';
                Editable = Rec."Status" = Rec."Status"::Open;

                field("Incident Description"; Rec."Incident Description")
                {
                    MultiLine = true;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Incident Description field';

                    trigger OnValidate()
                    begin
                        //FileName:=FileMgnt.UploadFile("Incident Reference",jpg);
                    end;
                }
                field("Screen Shot"; Rec."Screen Shot")
                {
                    ToolTip = 'Specifies the value of the Screen Shot field';
                }
            }
            group("User Remark")
            {
                Caption = '<User Remark>';
                Visible = (Rec."Status" = Rec."Status"::Solved) and (Rec."Incident Status" = Rec."Incident Status"::Resolved);

                field("User Remarks"; Rec."User Remarks")
                {
                    ToolTip = 'Specifies the value of the User Remarks field';
                }
            }
            group("ICT Delegation")
            {
                Visible = Rec."Status" = Rec."Status"::Pending;

                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field("Delegated To"; Rec."Delegated To")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Delegated To field';
                }
                field("Delegated To Name"; Rec."Delegated To Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Delegated To Name field';
                }
                field("Delegated User ID"; Rec."Delegated User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Delegated User ID field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Report Incident")
            {
                Caption = 'Report Incident';
                Enabled = not Rec.Sent;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = Rec."Incident Status" = Rec."Incident Status"::Unresolved;
                ToolTip = 'Executes the Report Incident action';

                trigger OnAction()
                begin
                    if not ICTSetup.Get() then
                        Error(Err0001);

                    if Rec.Sent = true then
                        Error(Err0002);

                    ICTSetup.TestField("Screenshot Path");


                    if Confirm('Do you want to send this Incident?') then begin
                        Rec.CalcFields("Screen Shot");

                        /* if "Screen Shot".HasValue then begin
                            "Screen Shot".CreateInStream(InStr);
                            FileRec.Create(ICTSetup."Screenshot Path" + Rec."Incident Reference" + '.jpg');
                            FileRec.CreateOutStream(OutStr);
                            CopyStream(OutStr, InStr);
                            FileRec.Close;
                        end; */

                        //Send Incident
                        SendIncident(Rec."Incident Reference");
                        //
                        Rec.Sent := true;
                        Rec.Status := Rec.Status::Pending;
                        Rec.Modify();
                        Message('The Incident %1 has been sent successfully', Rec."Incident Reference");
                        CurrPage.Close();
                    end else
                        exit;
                end;
            }
            action("Close Incident")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = Rec."Incident Status" = Rec."Incident Status"::Resolved;
                ToolTip = 'Executes the Close Incident action';

                trigger OnAction()
                begin

                    if Rec."Incident Status" <> Rec."Incident Status"::Resolved then
                        Error(Err0003);

                    Rec.Status := Rec.Status::Closed;
                    Message('The Incident has been closed successfully');
                    CurrPage.Close();
                end;
            }
            action("Resend Incident")
            {
                Image = Reminder;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = true;
                ToolTip = 'Executes the Resend Incident action';
            }
            action(Delegate)
            {
                Image = CoupledUser;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Pending;
                ToolTip = 'Executes the Delegate action';

                trigger OnAction()
                begin
                    Employee.Reset();
                    Employee.SetRange("Global Dimension 2 Code", '004');
                    if Employee.Find('-') then
                        if Action::LookupOK = Page.RunModal(Page::"Employee List Modified", Employee) then begin
                            Rec."Delegated To" := Employee."No.";
                            Rec."Delegated To Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            //Get UserId
                            UserSetup.Reset();
                            UserSetup.SetRange("Employee No.", Employee."No.");
                            if UserSetup.Find('-') then
                                Rec."Delegated User ID" := UserSetup."User ID";
                        end;

                    if Confirm('Do you want to delegate this Incident to %1 - %2?', true, Rec."Delegated To", Rec."Delegated To Name") then
                        Message('This Incident has been delegated to %1 - %2', Rec."Delegated To", Rec."Delegated To Name")
                    else
                        exit;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::ICT;
        Rec.User := UserId;
        Users.Get(UserId);
        Rec."User email Address" := Users."E-Mail";
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE(User,USERID);
    end;

    var
        Employee: Record Employee;
        ICTSetup: Record "ICT Setup";
        Users: Record "User Setup";
        UserSetup: Record "User Setup";
        Incident: Record "User Support Incident";
        Err0001: Label 'Resources setup doesn''t exist';
        Err0002: Label 'The incidence has already been sent!';
        Err0003: Label 'The issues has not been reolved.';
        Receipient: List of [Text];
        ReceipientBCC: List of [Text];
        ReceipientCC: List of [Text];
        FileName: Text;
        TimeNow: Text;
        Body: Text[250];
        SenderAddress: Text[250];
        SenderName: Text[250];
        Subject: Text[250];

    procedure SendIncident(IncidentNo: Code[50])
    var
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        Space: Label '     ';
        txtB64: Text;
    begin
        Incident.Reset();
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-') then begin
            ICTSetup.Get();
            ICTSetup.TestField("Security E-Mail");
            ICTSetup.TestField("Registry E-Mail");

            SenderName := Incident."Employee Name";
            SenderAddress := Incident."User email Address";
            Receipient.Add(ICTSetup."Registry E-Mail");
            ReceipientCC.Add(ICTSetup."Security E-Mail");
            ReceipientBCC.Add(ICTSetup."Registry BCC");
            Subject := Incident."Incident Reference" + Space + CompanyName;
            Body := Incident."Incident Description";

            FileName := (ICTSetup."Screenshot Path" + Incident."Incident Reference" + '.jpg');
            TimeNow := (Format(Time));

            //New Email Code/
            /*1.Create Msg*/
            EmailMessage.Create(Receipient, Subject, Body, false,
                                ReceipientCC, ReceipientBCC);
            /*2.Add Attachment*/
            if Incident."Screen Shot".HasValue then begin
                TempBlob.CreateInStream(AttachInstr);
                txtB64 := Base64Conv.ToBase64(AttachInstr, true);
                EmailMessage.AddAttachment('Incident Report', 'jpg', txtB64);
            end;
            /*3.Send() Msg*/
            Email.Send(EmailMessage);

        end;
    end;

    procedure SendIncidentNew(IncidentNo: Code[50])
    var
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        Space: Label '     ';
        AttachOutstr: OutStream;
        txtB64: Text;
    begin
        Incident.Reset();
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-') then begin
            ICTSetup.Get();
            ICTSetup.TestField("Security E-Mail");
            ICTSetup.TestField("Registry E-Mail");

            SenderName := Incident."Employee Name";
            SenderAddress := Incident."User email Address";
            Receipient.Add(ICTSetup."Registry E-Mail");
            ReceipientCC.Add(ICTSetup."Security E-Mail");
            ReceipientBCC.Add(ICTSetup."Registry BCC");
            Subject := Incident."Incident Reference" + Space + CompanyName;
            Body := Incident."Incident Description";

            TimeNow := (Format(Time));

            //New Email Code/
            /*1.Create Msg*/
            EmailMessage.Create(Receipient, Subject, Body, false,
                                ReceipientCC, ReceipientBCC);
            /*2.Add Attachment*/
            if Incident."Screen Shot".HasValue then begin
                FileName := (ICTSetup."Screenshot Path" + Incident."Incident Reference" + '.jpg');
                /*  ExportFile.Create(FileName);
                 ExportFile.CreateOutStream(AttachOutstr); */
                TempBlob.CreateOutStream(AttachOutstr);

                TempBlob.CreateInStream(AttachInstr);
                txtB64 := Base64Conv.ToBase64(AttachInstr, true);
                EmailMessage.AddAttachment('Incident Report', 'jpg', txtB64);
            end;
            /*3.Send() Msg*/
            Email.Send(EmailMessage, Enum::"Email Scenario"::Notification);
        end;
    end;
}





