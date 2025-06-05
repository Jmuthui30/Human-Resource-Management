page 52241 "Payroll Request Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Payroll Requests";
    Caption = 'Payroll Request Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Applies; Rec.Applies)
                {
                    Caption = 'Applies To';
                    ToolTip = 'Specifies the value of the Applies To field';
                    Visible = false;

                    trigger OnValidate()
                    begin

                        case Rec.Applies of
                            Rec.Applies::All:
                                begin
                                    ShowAll := true;
                                    ShowGroup := false;
                                    ShowOne := false;
                                end;
                            Rec.Applies::Group:
                                begin
                                    ShowAll := false;
                                    ShowGroup := true;
                                    ShowOne := false;
                                end;
                            Rec.Applies::Specific:
                                begin
                                    ShowAll := false;
                                    ShowGroup := false;
                                    ShowOne := true;
                                end;
                        end;
                    end;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                group(Control19)
                {
                    ShowCaption = false;
                    Visible = ShowGroup;

                    field(Group; Rec.Group)
                    {
                        Visible = ShowGroup;
                        ToolTip = 'Specifies the value of the Group field';
                    }
                }
                group(Control20)
                {
                    Visible = true;

                    field("Employee No."; Rec."Employee No.")
                    {
                        ToolTip = 'Specifies the value of the Employee No. field';
                        Editable = false;
                    }
                    field("Employee Name"; Rec."Employee Name")
                    {
                        //Visible = ShowOne;
                        Editable = false;
                        ToolTip = 'Specifies the value of the Employee Name field';
                    }
                    field("Responsibility Center"; Rec."Responsibility Center")
                    {
                        ToolTip = 'Specifies the value of the Responsibility Center field';
                    }
                    field("Special Condition"; Rec."Special Condition")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Special Condition field';

                        trigger OnValidate()
                        begin
                            if Rec."Special Condition" <> Rec."Special Condition"::" " then
                                NormalCondition := false
                            else
                                NormalCondition := true;
                        end;
                    }
                    field(Gratuity; Rec.Gratuity)
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Gratuity field';
                    }
                    field(Locum; Rec.Locum)
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Locum field';

                        trigger OnValidate()
                        begin
                            if Rec.Locum then
                                ShowLocum := true else
                                ShowLocum := false;
                        end;
                    }
                    group(Control25)
                    {
                        ShowCaption = false;
                        Visible = ShowLocum;

                        field("Principal Employee Code"; Rec."Principal Employee Code")
                        {
                            ToolTip = 'Specifies the value of the Principal Employee Code field';
                        }
                        field("Principal Employee Name"; Rec."Principal Employee Name")
                        {
                            ToolTip = 'Specifies the value of the Principal Employee Name field';
                        }
                        field("Principal Employee Basic"; Rec."Principal Employee Basic")
                        {
                            ToolTip = 'Specifies the value of the Principal Employee Basic field';
                        }
                        field(Hours; Rec.Hours)
                        {
                            ToolTip = 'Specifies the value of the Hours field';
                        }
                    }
                }
                group(Control28)
                {
                    ShowCaption = false;
                    Visible = NormalCondition;

                    field("Code"; Rec.Code)
                    {
                        ToolTip = 'Specifies the value of the Code field';
                    }
                    field("Code Descripton"; Rec."Code Descripton")
                    {
                        ToolTip = 'Specifies the value of the Code Descripton field';
                    }
                    field("Date of Activity"; Rec."Date of Activity")
                    {
                        ToolTip = 'Specifies the value of the Date of Activity field.';
                        ShowMandatory = true;
                    }
                    field(Formula; Rec.Formula)
                    {
                        Editable = false;
                        Visible = Rec."Calculation Method" = Rec."Calculation Method"::Formula;
                        ToolTip = 'Specifies the value of the Formula field';
                    }
                    field(Percentage; Rec.Percentage)
                    {
                        Editable = false;
                        Visible = Rec."Calculation Method" = Rec."Calculation Method"::"% of Basic pay";
                        ToolTip = 'Specifies the value of the Percentage field';
                    }
                    field(Units; Rec.Units)
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Units field';
                    }
                }
                group("Overtime Calculation")
                {
                    Visible = Rec.Overtime;

                    field("Working Day Hours"; Rec."Working Day Hours")
                    {
                        ToolTip = 'Specifies the value of the  Working Days field.';
                    }
                    field("Non-Working Day Hours"; Rec."Non-Working Day Hours")
                    {
                        ToolTip = 'Specifies the value of the Non-Working Days field.';
                    }
                }
                group("Leave Allowance")
                {
                    Visible = Rec."Leave Allowance";
                    field("Leave Application Document"; Rec."Leave Application Document")
                    {
                        ToolTip = 'Specifies the value of the Leave Application Document field.';
                        Visible = false;
                    }
                    field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                    {
                        ToolTip = 'Specifies the value of the Total Leave Days Taken field.';
                        ShowMandatory = true;
                    }
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                group("Advance Details")
                {
                    Visible = Rec.Advance;
                    field("Advance Instalments"; Rec."Advance Instalments")
                    {
                        ToolTip = 'Specifies the value of the Advance Instalments field.';
                        ShowMandatory = true;
                    }
                    field("Monthly Repayment"; Rec."Monthly Repayment")
                    {
                        ToolTip = 'Specifies the value of the Monthly Repayment field.';
                        Editable = false;
                    }
                }
                group("Short Explanation")
                {
                    field(Remarks; Rec.Remarks)
                    {
                        ToolTip = 'Specifies the value of the Remarks field';
                        ShowMandatory = true;
                        MultiLine = true;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field';
                    }
                }
            }
            part(Control35; "Emp. Payment Req Lines")
            {
                SubPageLink = "Document No" = field("No.");
                Visible = false;
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146446),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Enabled = not OpenApprovalEntriesExist;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Send Approval Request?', false) then begin
                        Rec.TestField(Remarks);
                        Rec.TestField(Code);
                        if ApprovalsMngt.CheckPayrollRequestWorkflowEnabled(Rec) then
                            ApprovalsMngt.OnSendPayrollRequestforApproval(Rec);
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Enabled = CanCancelApprovalForRecord;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = false;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) then
                        ApprovalsMngt.OnCancelPayrollRequestApprovalRequest(Rec);
                end;
            }
            action(Approval)
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
                    ApprovalEntry.SetRange("Table ID", Database::"Payroll Requests");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            action(Calculate)
            {
                ToolTip = 'Executes the Calculate action';
                Visible = false;

                trigger OnAction()
                begin
                    // PayrollMgt.GetPureFormula("Employee No.",PayrollMgt.GetCurrentPay(),Formula);
                    Rec.UpdateChange();
                end;
            }
            action("Disburse Advance")
            {
                Image = Process;
                Enabled = not Rec."Advance Disbursed";
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Disburse action';
                Caption = 'Disburse Advance To FOSA';
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Disburse?', false) then
                        PayrollMgt.DisburseSalaryAdvance(Rec);
                end;
            }
            action(Post)
            {
                Image = Post;
                Enabled = Rec.Status = Rec.Status::Approved;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Post action';
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post?', false) then begin
                        PayrollMgt.PostPayrollRequest(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Rec."Calculation Method" := Rec."Calculation Method"::Formula;
        Rec.Applies := Rec.Applies::Specific;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Rec."Calculation Method" := Rec."Calculation Method"::Formula;
        Rec.Applies := Rec.Applies::Specific;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();

        NormalCondition := true;
        ShowAll := false;
        ShowGroup := false;
        ShowOne := false;
    end;

    var
        ApprovalsMngt: Codeunit "Approval Mgt HR Ext";
        PayrollMgt: Codeunit Payroll;
        CanCancelApprovalForRecord: Boolean;
        NormalCondition: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowAll: Boolean;
        ShowGroup: Boolean;
        ShowLocum: Boolean;
        ShowOne: Boolean;


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        case Rec.Applies of
            Rec.Applies::All:
                begin
                    ShowAll := true;
                    ShowGroup := false;
                    ShowOne := false;
                end;
            Rec.Applies::Group:
                begin
                    ShowAll := true;
                    ShowGroup := true;
                    ShowOne := false;
                end;
            Rec.Applies::Specific:
                begin
                    ShowAll := false;
                    ShowGroup := false;
                    ShowOne := true;
                end;
        end;
        if Rec.Locum then ShowLocum := true;
        if Rec."Special Condition" <> Rec."Special Condition"::" " then
            NormalCondition := false
        else
            NormalCondition := true;
    end;
}





