page 52315 "Long List Card"
{
    ApplicationArea = All;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Generate Shortlist,Report,Send E-Mails,Close Shortlisting';
    SourceTable = "Recruitment Needs";
    Caption = 'Short List Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Positions; Rec.Positions)
                {
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field("Shortlisting Closed"; Rec."Shortlisting Closed")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortlisting Closed field';
                }
                field("No. of Applicants"; Rec."No. of Applicants")
                {
                    ToolTip = 'Specifies the value of the No. of Qualified Applicants field.';
                }
                field("Qualified Applicants"; Rec."Qualified Applicants")
                {
                    ToolTip = 'Specifies the value of the Qualified Applicants field.';
                }
                field("Non-Qualified Applicants"; Rec."Non-Qualified Applicants")
                {
                    ToolTip = 'Specifies the value of the Non-Qualified Applicants field.';
                }
            }
            group(Details)
            {
                Caption = 'Shortlisting Criteria';
                Editable = not Rec."Shortlisting Closed";
                field("Field of Study"; Rec."Field of Study")
                {
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Education Type"; Rec."Education Type")
                {
                    ToolTip = 'Specifies the value of the Education Type field';
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ToolTip = 'Specifies the value of the Proficiency Level field';
                }
                field("Experience industry"; Rec."Experience industry")
                {
                    ToolTip = 'Specifies the value of the Experience industry field';
                }
                field("Minimum years of experience"; Rec."Minimum years of experience")
                {
                    ToolTip = 'Specifies the value of the Minimum years of experience field';
                }
                field("Maximum years of experience"; Rec."Maximum years of experience")
                {
                    ToolTip = 'Specifies the value of the Maximum years of experience field';
                }
                field("Professional Course"; Rec."Professional Course")
                {
                    ToolTip = 'Specifies the value of the Professional Course field';
                }
                field("Professional Membership"; Rec."Professional Membership")
                {
                    ToolTip = 'Specifies the value of the Professional Membership field';
                }
            }
            part("Applicants"; "Applicant ShortList Lines")
            {
                Caption = 'Applicants';
                SubPageLink = "Need Code" = field("No.");
                UpdatePropagation = Both;
                Editable = not Rec."Shortlisting Closed";
            }
            part("Applied Applicants"; "Applied Applicants")
            {
                Caption = 'Applicants';
                Visible = false;
            }

        }
    }

    actions
    {
        area(Navigation)
        {
            action("Suggest Applicants")
            {
                Image = Suggest;
                Enabled = not Rec."Shortlisting Closed";

                trigger OnAction()
                begin
                    HRNotify.SuggestShortlistApplicants(Rec);
                end;
            }
            action("Long List")
            {
                Caption = 'Long List Applicants';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Short List action';
                Image = CalculateRemainingUsage;
                Enabled = not Rec."Shortlisting Closed";

                trigger OnAction()
                begin
                    HRNotify.ShortlistApplicants(Rec);
                    CurrPage.Update();
                end;
            }
            action("Mail Qualified Applicants")
            {
                Caption = 'Mail Qualified Applicants';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Mail Qualified Applicants action';
                Enabled = not Rec."Shortlisting Closed";

                trigger OnAction()
                begin
                    if Confirm(EmailApplicantsConfirmMsg, false) then begin
                        HRNotify.MailQualifiedShortlistApplicants(Rec);
                        Message(ApplicantsInvitedSuccessMsg);
                    end;

                    CurrPage.Close();
                end;
            }
            action("Mail Unqualified Applicants")
            {
                Caption = 'Mail Unqualified Applicants';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Mail Qualified Applicants action';

                trigger OnAction()
                begin
                    if Confirm(EmailApplicantsConfirmMsg, false) then begin
                        HRNotify.MailUnqualifiedShortlistApplicants(Rec);
                        Message(UnqualifiedApplicantsSuccessMsg);
                    end;

                    CurrPage.Close();
                end;
            }
            action("Close Shortlisting")
            {
                Caption = 'Close Longlisting';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Executes the Close Shortlisting action';
                Enabled = not Rec."Shortlisting Closed";

                trigger OnAction()
                begin
                    if Confirm(ShortlistingConfirmCloseMsg, false, Rec.Description) then begin
                        HRNotify.CloseShortlisting(Rec);
                        Message(ShortlistingClosedMsg, Rec."No.", Rec.Description);
                    end;

                    CurrPage.Close();
                end;
            }
            action("Interview Results")
            {
                ToolTip = 'Executes the Interview Results action';
            }
            action(Reopen)
            {
                ToolTip = 'Executes the Reopen action';

                trigger OnAction()
                begin
                    Rec."Shortlisting Closed" := false;
                end;
            }
        }
    }

    var
        HRNotify: Codeunit "HR Management";
        ApplicantsInvitedSuccessMsg: Label 'Qualified Applicants invited for Interviews successfully.';
        EmailApplicantsConfirmMsg: Label 'Do you want to E-mail the Applicants?';
        ShortlistingClosedMsg: Label 'Shortlisting %1 for Job %2 Closed';
        ShortlistingConfirmCloseMsg: Label 'Are you sure you want to Close the Shortlisting process for Job %1';
        UnqualifiedApplicantsSuccessMsg: Label 'Unqualified Applicants have been notified successfully.';
}





