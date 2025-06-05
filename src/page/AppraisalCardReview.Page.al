page 52183 "Appraisal Card-Review"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Appraisal,Approvals';
    SourceTable = "Employee Appraisal";
    Caption = 'Appraisal Card-Review';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;
                Caption = 'General';
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                group("Period Under Review:")
                {
                    Caption = 'Period Under Review:';
                    field("Appraisal Period"; Rec."Appraisal Period")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Period field';
                        Caption = 'Appraisal Period';
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
                        Caption = 'Appraisal Type';
                    }
                    field("Appraisal Type Description"; Rec."Appraisal Type Description")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Type Description field';
                        Caption = 'Appraisal Type Description';
                    }
                }
                group("Personal Details")
                {
                    Caption = 'Personal Details';
                    field("Employee No"; Rec."Employee No")
                    {
                        Caption = 'Appraisee No';
                        ToolTip = 'Specifies the value of the Appraisee No field';
                    }
                    field("Appraisee Name"; Rec."Appraisee Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisee Name field';
                        Caption = 'Appraisee Name';
                    }
                    field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisee''s Job Title field';
                        Caption = 'Appraisee''s Job Title';
                    }
                    field("Job Grade"; Rec."Job Group")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Job Group field';
                        Caption = 'Job Group';
                    }
                }
                group("Appraiser:")
                {
                    Caption = 'Appraiser:';
                    field("Appraiser No"; Rec."Appraiser No")
                    {
                        ToolTip = 'Specifies the value of the Appraiser No field';
                        Caption = 'Appraiser No / Reporting To';
                    }
                    field("Appraiser ID"; Rec."Appraiser ID")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser ID field';
                        Caption = 'Appraiser ID';
                    }
                    field("Appraisers Name"; Rec."Appraisers Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisers Name field';
                        Caption = 'Appraisers Name';
                    }
                    field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser''s Job Title field';
                        Caption = 'Appraiser''s Job Title';
                    }
                }
                group("Performance Score")
                {
                    Caption = 'Performance Score';
                    field("Total Weighting"; Rec."Total Weighting")
                    {
                        ToolTip = 'Specifies the value of the Total Weighting field';
                        Caption = 'Total Weighting';
                    }
                    group(Control46)
                    {
                        ShowCaption = false;
                        Caption = 'Control46';
                        field("Total Mid-Year Rating"; Rec."Total Mid-Year")
                        {
                            ToolTip = 'Specifies the value of the Total Mid-Year field';
                            Caption = 'Total Mid-Year';
                        }
                        field("Total Final Year Rating"; Rec."Total FY Rating")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Total FY Rating field';
                            Caption = 'Total FY Rating';
                        }
                        field("Final Year Percentage Score"; Rec."Total Percentage FY Rating")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Total percentage score field';
                            Caption = 'Total percentage score';
                        }
                        field("Final Year Grade"; Rec."Grade final year rating")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Perfomance grade field';
                            Caption = 'Perfomance grade';
                        }
                        field("Total score(Appraisal goals + Attributes"; Rec."Total score")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Total score field';
                            Caption = 'Total score';
                        }
                    }
                    /*group(Control12)
                    {
                        ShowCaption = false;
                        Visible = "Type" = "Type"::"Final Year";
                        field("Total Final Self"; "Total Final Self")
                        {
                        }
                        field("Total Final Rating"; "Total Final Rating")
                        {
                        }
                    }
                    */
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field';
                        Caption = 'Status';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisal Status field';
                        Caption = 'Appraisal Status';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                }
            }
            group("Do We Agree?")
            {
                field("Appraisee Agreed"; Rec."Appraisee Agreed")
                {
                    ToolTip = 'Specifies the value of the Appraisee Agreed field.';
                    Visible = FinalVisible;
                }
                field("Appraiser Agreed"; Rec."Appraiser Agreed")
                {
                    ToolTip = 'Specifies the value of the Appraiser Agreed field.';
                    Visible = FinalVisible;
                }
            }
            part(Control8; "Appraisal Goals")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                UpdatePropagation = Both;
                Caption = 'Appraisal Goals';

            }
            part(Control9; "Appraisal Goals Self")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                UpdatePropagation = Both;
                Visible = false;
                Caption = 'Appraisal Goals Self';
            }
            part("Substantial Achievements"; "Appraisee's Appraisal Comments")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Substantial Achievements"));
                Caption = 'Substantial Achievements';
            }
            part("Significant issues that affected Performance during the period (positive)"; "Appraisee's Appraisal Comments")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Significant Positive Issues"));
                Visible = FinalVisible;
                Caption = 'Significant issues that affected Performance during the period (positive)';
            }
            part("Significant issues that affected Performance during the period (negative)"; "Appraisee's Appraisal Comments")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Significant Negative Issues"));
                Visible = FinalVisible;
                Caption = 'Significant issues that affected Performance during the period (negative)';
            }
            part("WorkRelatedAttributes"; "Appraisal work related attr")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Visible = FinalVisible;
                UpdatePropagation = both;
                Caption = 'Work Related Attributes';
            }
            field("Total Rating"; Rec."Total FY Attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Total rating field';
                Caption = 'Total rating';
            }
            field("Expected Rating"; Rec."Expected TR -attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Expected TR -attributes field';
                Caption = 'Expected TR -attributes';
            }
            field("Total Percentage Score"; Rec."Total Percentage-Attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Total percentage score field';
                Caption = 'Total percentage score';
            }
            field("Grade"; Rec."Grade-Attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Perfomance grade field';
                Caption = 'Perfomance grade';
            }

            label("SECTION V:  PERFORMANCE IMPROVEMENT PLAN/PROGRAMME")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION V:  PERFORMANCE IMPROVEMENT PLAN/PROGRAMME';
            }
            part("PerfomanceImprovement"; "Second Supervisor Comments")
            {
                Caption = 'To be completed jointly, by the Appraisee and the Appraiser at the end of the appraisal period (Comment on appropriate performance improvement plan e.g. training, job rotation, appropriate placement, counselling, etc)';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Perfomance Improvement Plan"));
                Visible = FinalVisible;
            }
            label("SECTION VI:  STAFF TRAINING AND DEVELOPMENT NEEDS")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION VI:  STAFF TRAINING AND DEVELOPMENT NEEDS';
            }
            part("StaffTraining"; "Second Supervisor Comments")
            {
                Caption = 'Appraisee Training and Development needs in order of priority as identified by appraisee and supervisor based on performance gaps to be completed jointly at the end of the appraisal period.';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Perfomance Improvement Plan"));
                Visible = FinalVisible;
            }
            part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisee's Appraisal Comments")
            {
                Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraisee));
                Visible = false;
            }
            part("Appraiser's Comments On The Performance Appraisal"; "HR Appraisal Comments")
            {
                Caption = 'Appraiser''s Comments On The Performance Appraisal';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraiser));
                Visible = false;
            }
            label("SECTION VI:  COMMENTS BY THE HEAD OF DEPARTMENT")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION VI:  COMMENTS BY THE HEAD OF DEPARTMENT';
            }
            label("Please comment appropriately:")
            {
                Style = None;
                StyleExpr = false;
                Visible = FinalVisible;
                Caption = 'Please comment appropriately:';
            }
            part("HOD"; "HR Appraisal Comments")
            {
                Caption = 'HOD';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Second Supervisor"));
                Visible = FinalVisible;
            }
            label("SECTION VII:  HUMAN RESOURCES DEPARTMENT ")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION VII:  HUMAN RESOURCES DEPARTMENT ';
            }
            part("Other recommended interventions"; "HR Appraisal Comments")
            {
                Caption = 'Other recommended interventions';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("HR"));
                Visible = FinalVisible;
            }
            part("Recommendations"; "HR Appraisal Comments")
            {
                Caption = 'Recommendations';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Other interventions"));
                Visible = FinalVisible;
            }
            part("Mitigating Factors"; "HR Appraisal Comments")
            {
                Caption = 'Mitigating Factors';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Mitigating Factors"));
                Visible = FinalVisible;
            }
            part("Developmental Action To Be Taken"; "HR Appraisal Dev Actions")
            {
                Caption = 'Developmental Action To Be Taken';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Dev Action"));
                Visible = FinalVisible;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create a training need")
            {
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create a Training need action';
                trigger OnAction()
                var
                    TrainingNeedRequest: Record "Training Needs Request";
                begin
                    TrainingNeedRequest.SetRange("Source Document No", Rec."Appraisal No");
                    if TrainingNeedRequest.FindFirst() then
                        PAGE.RUN(page::"Training Needs Request card", TrainingNeedRequest)
                    else begin
                        TrainingNeedRequest.Reset();
                        TrainingNeedRequest.Init();
                        TrainingNeedRequest.No := '';
                        TrainingNeedRequest."Employee No" := Rec."Employee No";
                        TrainingNeedRequest.Validate("Employee No");
                        TrainingNeedRequest."Source Document No" := Rec."Appraisal No";
                        TrainingNeedRequest."Need Source" := TrainingNeedRequest."Need Source"::Appraisal;
                        TrainingNeedRequest.Insert(true);
                        TrainingNeedRequest.SetRange("Source Document No", Rec."Appraisal No");
                        if Rec.FindFirst() then
                            PAGE.RUN(page::"Training Needs Request card", TrainingNeedRequest);
                    end;
                end;

            }
            action("Assign Bonus")
            {
                Caption = 'Assign bonus';
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Assign bonus action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) = false then
                        exit;

                    AssignmentMatrixX.Reset();
                    AssignmentMatrixX.SetRange("Employee No", Rec."Employee No");
                    AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Earning);
                    AssignmentMatrixX.SetRange(Closed, false);
                    Earnings.SetTableView(AssignmentMatrixX);
                    Earnings.RunModal();
                end;
            }
            action("Print Objectives")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';
                Caption = 'Print Objectives';

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeObjectives.SetTableView(EmployeeApp);
                    Commit();
                    EmployeeObjectives.RunModal();
                end;
            }
            action("Print Appraisal Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Appraisal Report action';
                Caption = 'Print Appraisal Report';

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeAppraisals.SetTableView(EmployeeApp);
                    Commit();
                    EmployeeAppraisals.RunModal();
                end;
            }
            action("Print Score Card")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';
                Caption = 'Print Score Card';

                trigger OnAction()
                begin
                    Clear(AppraisalScoreCard);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    AppraisalScoreCard.SetTableView(EmployeeApp);
                    AppraisalScoreCard.RunModal();
                end;
            }
            separator(Action34)
            {
            }
            action("Send For Approval")
            {
                Caption = 'Send For further Review';
                Enabled = DocReleased;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send For further Review action';

                trigger OnAction()
                begin
                    // if Status = Status::"Pending Approval" then
                    //     Error('Document already pending approval');

                    // if Status = Status::Completed then
                    //     Error('Appraisal is already complete');

                    // if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then
                    //     ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);
                    Rec."Appraisal Status" := Rec."Appraisal Status"::"Further review";
                    Commit();
                    CurrPage.Close();
                end;
            }
            action("Return for review")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = (Rec."Appraisal Status" = Rec."Appraisal Status"::Completed) and (Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review");
                ToolTip = 'Executes the Return for review action';
                Caption = 'Return for review';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;
                    Message('Appraisal has been returned to Review');
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
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Enum "Approval Document Type";
                begin

                    DocumentType := DocumentType::"Employee Appraisal";
                    ApprovalEntries.SetRecordFilters(DATABASE::"Employee Appraisal", DocumentType, Rec."Appraisal No");
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
                Caption = 'Lock Performance';

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
                Caption = 'Review Targets';

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
                Visible = FinalVisible;
                ToolTip = 'Executes the Complete Appraisal action';
                Caption = 'Complete Appraisal';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to complete this appraisal?', true) then begin
                        Rec."Appraisal Status" := Rec."Appraisal Status"::Completed;
                        Rec.Modify();
                    end;
                    CurrPage.Close();
                end;
            }
            action("Send to final year")
            {
                Image = ChangePaymentTolerance;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = MidVisible;
                ToolTip = 'Executes the Send to final year action';
                Caption = 'Send to final year';
                trigger OnAction()
                begin
                    if Rec.AppraisalType = Rec.AppraisalType::"Mid-Year" then HRManagement.SendToFinalYear(Rec);
                    // IF AppraisalType = AppraisalType::Q2 THEN HRManagement.SendToQ3(Rec);
                    // IF AppraisalType = AppraisalType::Q3 THEN HRManagement.SendToQ4(Rec);
                end;

            }
            action(SendToFinal)
            {
                Caption = 'Send To Final Year Review';
                Enabled = UnderReview and MidVisible;
                Image = ChangePaymentTolerance;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Send To Final Year Review action';

                trigger OnAction()
                begin
                    HRManagement.SendToFinalYearAppraisal(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        // CurrPage.UPDATE;

        SetControlAppearance();
        HRManagement.GetTotalRating(Rec);
    end;

    trigger OnOpenPage()
    begin
        //HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        //CurrPage.UPDATE;
        SetControlAppearance();
    end;

    var
        AssignmentMatrixX: Record "Assignment Matrix";
        EmployeeApp: Record "Employee Appraisal";
        EmployeeAppraisals: Report "Employee Appraisal - New";
        AppraisalScoreCard: Report "Employee Appraisal Scorecard";
        EmployeeObjectives: Report "Employee Objectives - New";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        HRManagement: Codeunit "HR Management";
        Earnings: Page Payments_Earnings;
        CanCancelApprovalForRecord: Boolean;
        DocReleased: Boolean;
        FinalVisible: Boolean;
        MidVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UnderReview: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";

    begin
        FinalVisible := true;
        UnderReview := true;
        MidVisible := true;

        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);

        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;

        /*  if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then
             UnderReview := true
         else
             UnderReview := false;

         if Rec."Appraisal Status" = Rec."Appraisal Status"::Completed then
             Completed := true
         else
             Completed := false;

         if Rec.AppraisalType = Rec.AppraisalType::"Final Year" then
             FinalVisible := true
         else
             FinalVisible := false;

         if Rec.AppraisalType = Rec.AppraisalType::"Mid-Year" then
             MidVisible := true
         else
             MidVisible := false; */

    end;
}
















