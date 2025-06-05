page 52185 "Appraisal Card-Completed"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Appraisal,Approvals';
    SourceTable = "Employee Appraisal";
    Caption = 'Appraisal Card-Completed';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;

                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                group("Period Under Review:")
                {
                    field("Appraisal Period"; Rec."Appraisal Period")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Period field';
                    }
                    field("Period Start"; Rec."Period Start")
                    {
                        Caption = 'From';
                        Editable = false;
                        ToolTip = 'Specifies the value of the From field';
                    }
                    field("Period End"; Rec."Period End")
                    {
                        Caption = 'To';
                        Editable = false;
                        ToolTip = 'Specifies the value of the To field';
                    }
                    field("Appraisal Type"; Rec.AppraisalType)
                    {
                        ToolTip = 'Specifies the value of the Appraisal Type field';
                    }
                    field("Appraisal Type Description"; Rec."Appraisal Type Description")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Type Description field';
                    }
                }
                group("Personal Details")
                {
                    field("Employee No"; Rec."Employee No")
                    {
                        Caption = 'Appraisee No';
                        ToolTip = 'Specifies the value of the Appraisee No field';
                    }
                    field("Appraisee Name"; Rec."Appraisee Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisee Name field';
                    }
                    field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisee''s Job Title field';
                    }
                    field("Job Grade"; Rec."Job Group")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Job Group field';
                    }
                }
                group("Appraiser:")
                {
                    field("Appraiser No"; Rec."Appraiser No")
                    {
                        ToolTip = 'Specifies the value of the Appraiser No field';
                    }
                    field("Appraiser ID"; Rec."Appraiser ID")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser ID field';
                    }
                    field("Appraisers Name"; Rec."Appraisers Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisers Name field';
                    }
                    field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser''s Job Title field';
                    }
                }
                group("Performance Score")
                {
                    field("Total Weighting"; Rec."Total Weighting")
                    {
                        ToolTip = 'Specifies the value of the Total Weighting field';
                    }
                    group(Control46)
                    {
                        ShowCaption = false;

                        field("Total Mid-Year"; Rec."Total Mid-Year")
                        {
                            ToolTip = 'Specifies the value of the Total Mid-Year field';
                        }
                        field("Total FY Rating"; Rec."Total FY Rating")
                        {
                            Visible = UnderReview;
                            ToolTip = 'Specifies the value of the Total FY Rating field';
                        }
                        field("Total Percentage FY Rating"; Rec."Total Percentage FY Rating")
                        {
                            Visible = UnderReview;
                            ToolTip = 'Specifies the value of the Total percentage score field';
                        }
                        field("Grade final year rating"; Rec."Grade final year rating")
                        {
                            Visible = UnderReview;
                            ToolTip = 'Specifies the value of the Perfomance grade field';
                        }
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Appraisal Status field';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                }
            }
            part(Control8; "Appraisal Goals-Completed")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                UpdatePropagation = Both;
            }
            part("Significant issues that affected Performance during the period (positive and/or negative)"; "Second Supervisor Comments")
            {
                Caption = 'Significant issues that affected Performance during the period (positive and/or negative)';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Significant Positive Issues"));
            }
            part("Other Substantial Achievements (Optional)"; "Second Supervisor Comments")
            {
                Caption = 'Other Substantial Achievements (Optional)';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Substantial Achievements"));
            }
            part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisee's Appraisal Comments")
            {
                Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraisee));
                Visible = false;
            }
            part("Appraiser's Comments On The Performance Appraisal"; "Second Supervisor Comments")
            {
                Caption = 'Appraiser''s Comments On The Performance Appraisal';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraiser));
            }
            part("Departmental Head's Comments (If not the APPRAISER)"; "Second Supervisor Comments")
            {
                Caption = 'Departmental Head''s Comments (If not the APPRAISER)';
                Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Second Supervisor"));
                Visible = UnderReview or Completed;
            }
            part("Trust Secretary's Comments"; "Second Supervisor Comments")
            {
                Caption = 'Trust Secretary''s Comments';
                Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Trust Secretary"));
                Visible = UnderReview or Completed;
            }
            part("Developmental Action To Be Taken"; "Second Supervisor Comments")
            {
                Caption = 'Developmental Action To Be Taken';
                Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Dev Action"));
                Visible = UnderReview or Completed;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Objectives")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeObjectives.SetTableView(EmployeeApp);
                    EmployeeObjectives.RunModal();
                end;
            }
            action("Print Report")
            {
                Caption = 'Print Appraisal Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Appraisal Report action';

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeAppraisals.SetTableView(EmployeeApp);
                    EmployeeAppraisals.RunModal();
                end;
            }
            separator(Action34)
            {
            }
            action("Send For Approval")
            {
                Caption = 'Send For Review';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send For Review action';

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);

                    Commit();
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Review Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Review Request action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelNewEmpAppraisalRequestApproval(Rec);
                    Commit();
                    CurrPage.Close();
                end;
            }
            action(ViewApprovals)
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
                    ApprovalEntry.SetRange("Document No.", Rec."Appraisal No");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            separator(Action35)
            {
            }
            action("Lock Performance")
            {
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Lock Performance action';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Set;

                    Message('Performance Locked');
                end;
            }
            action("Review Targets")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ToolTip = 'Executes the Review Targets action';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;

                    Message('Appraisal has been opened for Review');
                end;
            }
            action("Complete Appraisal")
            {
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = UnderReview;
                ToolTip = 'Executes the Complete Appraisal action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to complete this appraisal?', false) then begin
                        Rec."Appraisal Status" := Rec."Appraisal Status"::Completed;
                        Rec.Modify();
                    end;
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        // CurrPage.UPDATE;
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        //HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        //CurrPage.UPDATE;
        SetControlAppearance();
    end;

    var
        EmployeeApp: Record "Employee Appraisal";
        EmployeeAppraisals: Report "Employee Appraisal - New";
        EmployeeObjectives: Report "Employee Objectives - New";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        CanCancelApprovalForRecord: Boolean;
        Completed: Boolean;
        DocReleased: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UnderReview: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);

        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;

        if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then
            UnderReview := true
        else
            UnderReview := false;

        if Rec."Appraisal Status" = Rec."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;
    end;
}





