page 52092 "Interview Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print Offer Letter,Applicant Profile';
    SourceTable = "Job Application";
    Caption = 'Interview Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Interviewed;

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    Editable = false;
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                    Editable = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant Type field';
                }
                field("Job Applied Code"; Rec."Job Applied Code")
                {
                    ToolTip = 'Specifies the value of the Job Applied Code field.';
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    Editable = false;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Editable = false;
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    ToolTip = 'Specifies the value of the Expected Reporting Date field';
                    Visible = false;
                }
                label("Interview Scores")
                {
                    Caption = 'Interview Scores';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Oral Average Score"; Rec."Oral Average Score")
                {
                    ToolTip = 'Specifies the value of the Oral Average Score field.';
                }
                field("Practical Average Score"; Rec."Practical Average Score")
                {
                    ToolTip = 'Specifies the value of the Practical Average Score field.';
                }
                field("Total Average Score"; Rec."Total Average Score")
                {
                    ToolTip = 'Specifies the value of the Total Average Score field.';
                }
            }
            label(Academic)
            {
                Style = Strong;
                StyleExpr = true;
                Visible = false;
            }
            part(Control16; "Interview Subpage")
            {
                Editable = Rec."Interviewed" = false;
                SubPageLink = "Applicant No" = field("No.");
                UpdatePropagation = Both;
            }
            label(Administration)
            {
                Style = Strong;
                StyleExpr = true;
                Visible = false;
            }
            part(Control25; "Oral Interview")
            {
                SubPageLink = "Applicant No" = field("No.");
                Visible = false;
            }
            part(Control26; "Oral Interview (Board)")
            {
                SubPageLink = "Applicant No" = field("No.");
                Visible = false;
            }
            part(Control27; "Practical Interview")
            {
                SubPageLink = "Applicant No" = field("No.");
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Complete Interview")
            {
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Complete Interview action';
                Enabled = not Rec.Interviewed;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to complete this Interview?', false) then
                        HRMgt.CompleteInterview(Rec);

                    CurrPage.Close();
                end;
            }
            action("Offer Letter")
            {
                Caption = 'Print Offer Letter';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = true;
                ToolTip = 'Executes the Offer Letter action';
                Enabled = Rec.Interviewed;

                trigger OnAction()
                begin
                    JobApplication.Reset();
                    JobApplication.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Letter of Offer", true, false, JobApplication);
                end;
            }
            action("Send Offer Letter")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Offer Letter action';
                //Enabled = not Rec.Interviewed;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to send offer letter via mail?', false) then
                        HRMgt.SendOfferLetterViaMail(Rec);
                end;
            }
            action("View Applicant Information")
            {
                Promoted = true;
                Image = View;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Submitted Applicant Card";
                RunPageLink = "No." = field("Applicant No.");
                RunPageMode = View;
                Caption = 'View Applicant Information';
            }
        }
    }

    var
        JobApplication: Record "Job Application";
        HRMgt: Codeunit "HR Management";

    procedure InterviewInvitation(ApplicantNo: Code[50]; InterviewDate: Text)
    var
        Applicants: Record Applicants;
        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Label 'Dear %1, <br><br>We refer to the interview which was held on <Strong>%2</Strong>, you are a successful candidate. Kindly pick your offer letter from the Human Resource Office<br> <br> <br>Kind Regards <br><br>%3.';
        Receipient: List of [Text];
        FormattedBody: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        Applicants.Reset();
        Applicants.SetRange("No.", ApplicantNo);
        if Applicants.Find('-') then begin
            CompanyInfo.Get();
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderName := CompanyInfo.Name;
            SenderAddress := CompanyInfo."E-Mail";
            Receipient.Add(Applicants."E-Mail");
            Subject := 'Job Offer Letter';
            TimeNow := (Format(Time));
            FormattedBody := StrSubstNo(NewBody, Applicants."First Name", InterviewDate, CompanyInfo.Name);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true);
            Email.Send(EmailMessage);
        end;
    end;
}





