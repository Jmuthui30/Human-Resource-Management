page 52030 "Employee Disciplinary Case"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Payroll,Appeal,Attachments';
    SourceTable = "Employee Discplinary";
    Caption = 'Employee Disciplinary Case';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EditableTxt;

                field("Disciplinary Nos"; Rec."Disciplinary Nos")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Disciplinary Nos field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Date of Join"; Rec."Date of Join")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date of Join field';
                }
                field("Reason for Appeal"; Rec."Reason for Appeal")
                {
                    ToolTip = 'Specifies the value of the Reason for Appeal field.';
                    MultiLine = true;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Case Closed';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Case Closed field';
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Closed field';
                }
            }
            group(Email)
            {
                Caption = 'E-Mail Notification';
                Editable = EditableTxt;

                field("Recipient Email"; Rec."Recipient Email")
                {
                    Caption = 'Staff Email';
                    ToolTip = 'Specifies the value of the Staff Email field';
                }
                field("Recipient CC"; Rec."Recipient CC")
                {
                    ToolTip = 'Specifies the value of the Recipient CC field';
                }
                field("Recipient BCC"; Rec."Recipient BCC")
                {
                    ToolTip = 'Specifies the value of the Recipient BCC field';
                }
                field("E-Mail Subject"; Rec."E-Mail Subject")
                {
                    ToolTip = 'Specifies the value of the E-Mail Subject field';
                }
                field("E-Mail Body"; EmailTxt)
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the EmailTxt field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("E-Mail Body Text");

                        rec."E-Mail Body Text".CreateInStream(InStrm);
                        EmailBigTxt.Read(InStrm);

                        if EmailTxt <> Format(EmailBigTxt) then begin
                            Clear(Rec."E-Mail Body Text");
                            Clear(EmailBigTxt);
                            EmailBigTxt.AddText(EmailTxt);
                            rec."E-Mail Body Text".CreateOutStream(OutStrm);
                            EmailBigTxt.Write(OutStrm);
                        end;
                    end;
                }
            }
            label("Disciplinary Cases")
            {
                Style = Strong;
                StyleExpr = true;
            }
            part(Control10; "Emp Disciplinary Cases")
            {
                Caption = 'Employee disciplinary case lines';
                Editable = EditableTxt;
                SubPageLink = "Refference No" = field("Disciplinary Nos"),
                              "Employee No" = field("Employee No");
            }
            part(Committee; "Disciplinary Committee")
            {
                Caption = 'Disciplinary Committee';
                SubPageLink = "Case No." = field("Disciplinary Nos");
                Editable = EditableTxt;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146515),
                              "No." = FIELD("Disciplinary Nos");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Appeal)
            {
                Caption = 'Appeal Disciplinary Case';
                Image = ExciseApplyToLine;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = page "Disciplinary Appeal Reason";
                RunPageLink = "Disciplinary Nos" = field("Disciplinary Nos");
                RunPageOnRec = true;
                Enabled = EditableTxt;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action(Suspend)
            {
                Caption = 'Suspend Employee';
                Image = DeactivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = EditableTxt;

                trigger OnAction()
                var
                    EmployeeSep: Record "Employee Separation";
                begin
                    if Confirm('Are you sure you want to Suspend %1', false, Rec."Employee Name") then begin
                        EmployeeSep.Init();
                        EmployeeSep."No." := '';
                        EmployeeSep.Insert(true);

                        EmployeeSep.Validate("Separation Type", EmployeeSep."Separation Type"::Suspension);
                        EmployeeSep.Validate("Employee No.", Rec."Employee No");
                        EmployeeSep.Modify();

                        Page.Run(Page::"Employee Separtion Card", EmployeeSep);
                    end;
                end;
            }
            action("Close Case")
            {
                Enabled = not Rec.Posted;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Close Case action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to post this case?', true) = false
                      then
                        exit;

                    Rec.Posted := true;
                    Rec."Date Closed" := Today;
                    Rec.Modify();

                    Commit();
                    CurrPage.Close();
                end;
            }
            action("Assign Deductions")
            {
                Caption = 'Assign Payroll Deduction';
                Enabled = not Rec.Posted;
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Assign Payroll Deduction action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) = false then
                        exit;

                    AssignmentMatrixX.Reset();
                    AssignmentMatrixX.SetRange("Employee No", Rec."Employee No");
                    AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Deduction);
                    AssignmentMatrixX.SetRange(Closed, false);
                    Deductions.SetTableView(AssignmentMatrixX);
                    Deductions.RunModal();
                end;
            }
            action(Notify)
            {
                Caption = 'Send E-mail Notification';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send E-mail Notification action';
                Enabled = EditableTxt;

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) then
                        HRMgt.NotifyStaffDisciplinary(Rec);
                end;
            }
            action(SendAppeal)
            {
                Caption = 'Send Appeal For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Send Appeal for Approval action';
                Enabled = EditableTxt;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to send appeal for approval ?', false) then begin
                        Rec.TestField("Reason for Appeal");
                        Rec.Posted := false;
                        Rec.Modify();
                        Message('Appeal Sent');
                    end;
                end;
            }
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Track perfomance")
            {
                Image = Track;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Track perfomance action';
                Visible = false;

                trigger OnAction()
                var
                    Appraisal: Record "Employee Appraisal";
                begin
                    Appraisal.SetRange("Employee No", Rec."Employee No");
                    if Appraisal.FindLast() then
                        Page.Run(Page::"Appraisal Card-Completed", Appraisal);
                end;
            }
        }
        area(Creation)
        {
            action(Training)
            {
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create a Training need action';

                // trigger OnAction()
                // begin
                //     TrainHeader.Init;
                //     HRSetup.Get();
                //     TrainHeader.Code := NoSeriesMgmt.GetNextNo(HRSetup."Training Needs Nos", TODAY, TRUE);
                //     TrainHeader.Insert;
                //     TrainHeader.Modify;
                //     PAGE.RUN(page::"Training Needs", TrainHeader);
                // end;
                trigger OnAction()
                var
                    TrainingNeedRequest: Record "Training Needs Request";
                begin
                    TrainingNeedRequest.SetRange("Source Document No", Rec."Disciplinary Nos");
                    if TrainingNeedRequest.FindFirst() then
                        Page.Run(Page::"Training Needs Request card", TrainingNeedRequest)
                    else begin
                        TrainingNeedRequest.Reset();
                        TrainingNeedRequest.Init();
                        TrainingNeedRequest.No := '';
                        TrainingNeedRequest."Employee No" := Rec."Employee No";
                        TrainingNeedRequest.Validate("Employee No");
                        TrainingNeedRequest."Source Document No" := Rec."Disciplinary Nos";
                        TrainingNeedRequest."Need Source" := TrainingNeedRequest."Need Source"::Disciplinary;
                        TrainingNeedRequest.Insert(true);
                        TrainingNeedRequest.SetRange("Source Document No", Rec."Disciplinary Nos");
                        if Rec.FindFirst() then
                            Page.Run(Page::"Training Needs Request card", TrainingNeedRequest);
                    end;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetEditable();


    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetEditable();
    end;

    trigger OnOpenPage()
    begin
        SetEditable();
    end;

    var
        AssignmentMatrixX: Record "Assignment Matrix";
        HRMgt: Codeunit "HR Management";
        Deductions: Page "Payments_Deduction";
        EmailBigTxt: BigText;
        EditableTxt: Boolean;
        InStrm: InStream;
        OutStrm: OutStream;
        EmailTxt: Text;

    local procedure SetEditable()
    begin
        if Rec.Posted then
            EditableTxt := false
        else
            EditableTxt := true;

        Rec.CalcFields("E-Mail Body Text");
        rec."E-Mail Body Text".CreateInStream(InStrm);
        EmailBigTxt.Read(InStrm);
        EmailTxt := Format(EmailBigTxt);
    end;
}





