page 52037 "Appraisal Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Appraisal';
    SourceTable = "Employee Appraisal";
    Caption = 'Appraisal Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                label("Period Under Review:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Period Start"; Rec."Period Start")
                {
                    Caption = 'From';
                    ToolTip = 'Specifies the value of the From field';
                }
                field("Period End"; Rec."Period End")
                {
                    Caption = 'To';
                    ToolTip = 'Specifies the value of the To field';
                }
                label("PERSONAL PARTICULARS:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
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
                label("Appraiser:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type field';
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraiser ID field';
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ToolTip = 'Specifies the value of the Appraiser No field';
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
                label("Performance Score")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Values Total"; Rec."Values Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Values Total field';
                }
                field("Values Mean"; Rec."Values Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Values Mean field';
                }
                field("Competences Total"; Rec."Competences Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Competences Total field';
                }
                field("Competences Mean"; Rec."Competences Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Competences Mean field';
                }
                field("Curriculum Total"; Rec."Curriculum Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Curriculum Total field';
                }
                field("Curriculum Mean"; Rec."Curriculum Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Curriculum Mean field';
                }
                field("Research Total"; Rec."Research Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Research Total field';
                }
                field("Research Mean"; Rec."Research Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Research Mean field';
                }
                field("Initiative Total"; Rec."Initiative Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiative Total field';
                }
                field("Initiative Mean"; Rec."Initiative Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiative Mean field';
                }
                field("Managerial Total"; Rec."Managerial Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Managerial Total field';
                }
                field("Managerial  Mean"; Rec."Managerial  Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Managerial  Mean field';
                }
                label("Performance Targets:")
                {
                    Caption = 'Performance Targets';
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Target Score"; Rec."Target Score")
                {
                    Caption = 'Total Score';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Score field';
                }
                field("Target Avg"; Rec."Target Avg")
                {
                    Caption = 'Mean Score';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Mean Score field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part("Performance Rating"; "Performance Plan")
            {
                Caption = 'Performance Rating';
                Editable = (Rec."Appraisal Status" = Rec."Appraisal Status"::Setting) or (Rec."Appraisal Status" = Rec."Appraisal Status"::Review);
                Enabled = (Rec."Appraisal Status" = Rec."Appraisal Status"::Setting) or (Rec."Appraisal Status" = Rec."Appraisal Status"::Review);
                SubPageLink = "Appraisal No" = field("Appraisal No");
            }
            part(Control13; "Appraiser & Appraisee Comments")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                Visible = false;
            }
            label("Value/Core Competencies:")
            {
                Style = Strong;
                StyleExpr = true;
            }
            part("<Values>"; "Appraisal Values")
            {
                Caption = '<Values>';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter(Values));
            }
            part("Core Competences"; "Appraisal Core Competences")
            {
                Caption = 'Core Competences';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Core Competences"));
            }
            part("Curriculum Delivery"; "Appraisal Curriculum Delivery")
            {
                Caption = 'Curriculum Delivery';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Curriculum Delivery"));
            }
            part(Research; "Appraisal Research")
            {
                Caption = 'Research';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter(Research));
            }
            part("Initiative & Willingness"; "Initiative & Willingness")
            {
                Caption = 'Initiative & Willingness';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Initiative & Willingness"));
            }
            part("Managerial & Supervisory"; "Managerial & Supervisory")
            {
                Caption = 'Managerial & Supervisory';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Managerial & Supervisory"));
            }
            label("Appraisal Comments:")
            {
                Style = Strong;
                StyleExpr = true;
            }
            part(Control37; "Appraisee's Appraisal Comments")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraisee));
            }
            part("Comments by Second Supervisor"; "Second Supervisor Comments")
            {
                Caption = 'Comments by Second Supervisor';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Second Supervisor"));
            }
            part(Control39; "HR Appraisal Comments")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(HR));
            }
        }
        area(factboxes)
        {

            part(CommentsFactBox; "Approval Comments FactBox")
            {
                SubPageLink = "Document No." = field("Appraisal No");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146446),
                              "No." = FIELD("Appraisal No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Preview action';

                trigger OnAction()
                begin
                    /*
                    EmployeeApp.Reset();
                    EmployeeApp.SetRange("Appraisal No","Appraisal No");
                      if EmployeeApp.Find('-') then
                        Report.RunModal(000000,true,false,EmployeeApp);
                    */

                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckEmployeeAppraisalWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendEmployeeAppraisalRequestforApproval(Rec);
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
                    ApprovalsMgmt.OnCancelEmployeeAppraisalApprovalRequest(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Enum "Approval Document Type";
                begin

                    DocumentType := DocumentType::"Employee Appraisal";
                    ApprovalEntries.SetRecordfilters(Database::"Employee Appraisal", DocumentType, Rec."Appraisal No");
                    ApprovalEntries.Run();
                end;
            }
            action("Lock Performance")
            {
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
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
                ToolTip = 'Executes the Review Targets action';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;

                    Message('Appraisal has been opened for Review');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        HRManagement.UpdateAppraisalScores(Rec."Appraisal No", Rec."Employee No");
        CurrPage.Update();
    end;

    trigger OnOpenPage()
    begin
        HRManagement.UpdateAppraisalScores(Rec."Appraisal No", Rec."Employee No");
        CurrPage.Update();
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        HRManagement: Codeunit "HR Management";
}





