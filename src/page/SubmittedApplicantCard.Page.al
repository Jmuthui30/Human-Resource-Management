page 52297 "Submitted Applicant Card"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Attachments';
    SourceTable = Applicants;
    Caption = 'Submitted Applicant Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Applicant Type field';

                    trigger OnValidate()
                    begin
                        EmployeeView();
                    end;
                }
                group(Employee)
                {
                    Visible = Employee;

                    field("Employee No"; Rec."Employee No")
                    {
                        ToolTip = 'Specifies the value of the Employee No field';
                    }
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Full Name field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field';
                }
                field(Employ; Rec.Employ)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employ field';
                }
                field("Applicant Status"; Rec."Applicant Status")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Applicant Status field';
                }
                field(Submitted; Rec.Submitted)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Submitted field';
                }
                group(Personal)
                {
                    Caption = 'Personal';

                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field("Marital Status"; Rec."Marital Status")
                    {
                        ToolTip = 'Specifies the value of the Marital Status field';
                    }
                    field("Ethnic Origin"; Rec."Ethnic Origin")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Ethnic Origin field';
                    }
                    field(Disabled; Rec.Disabled)
                    {
                        ToolTip = 'Specifies the value of the Disabled field';
                        Visible = false;
                        trigger OnValidate()
                        begin

                            DisabilityView();
                        end;
                    }
                    group(Control17)
                    {
                        ShowCaption = false;
                        //  Visible = Disabling;
                        Visible = false;
                        field("Disabling Details"; Rec."Disabling Details")
                        {
                            ToolTip = 'Specifies the value of the Disabling Details field';
                        }
                    }
                    field("Date Of Birth"; Rec."Date Of Birth")
                    {
                        ToolTip = 'Specifies the value of the Date Of Birth field';
                    }
                    field(Age; Rec.Age)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Age field';
                    }
                }
                group(Communication)
                {
                    Caption = 'Communication';

                    field("Cellular Phone Number"; Rec."Cellular Phone Number")
                    {
                        ToolTip = 'Specifies the value of the Cellular Phone Number field';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ToolTip = 'Specifies the value of the E-Mail field';
                    }
                    field("Postal Address"; Rec."Postal Address")
                    {
                        ToolTip = 'Specifies the value of the Postal Address field';
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ToolTip = 'Specifies the value of the Post Code field';
                    }
                    field("Residential Address"; Rec."Residential Address")
                    {
                        ToolTip = 'Specifies the value of the Residential Address field';
                    }
                }
                field("Current Gross Salary"; Rec."Current Gross Salary")
                {
                    Visible = false;
                }
                field("Expected Gross Salary"; Rec."Expected Gross Salary")
                {
                }
                field("Applicant Remarks"; Rec."Applicant Remarks")
                {
                    ToolTip = 'Specifies the value of the Why do you think you are qualified for this job? field.';
                    MultiLine = true;
                }
            }
            part(JobApplied; "Jobs Applied")
            {
                SubPageLink = "Applicant No." = field("No.");
            }
            part(Education; "Applicant Job Education")
            {
                Caption = 'Academic Qualifications';
                SubPageLink = "Applicant No." = field("No.");
            }
            part(Experience; "Applicant Job Experience")
            {
                Caption = 'Job Experience';
                SubPageLink = "Applicant No." = field("No.");
            }
            part(ProfessionalCourses; "Applicant Job Prof Course")
            {
                Caption = 'Professional Courses';
                SubPageLink = "Applicant No." = field("No.");
            }
            part(ProfessionalMembership; "Applicant Job Prof Membership")
            {
                Caption = 'Professional Body Membership';
                SubPageLink = "Applicant No." = field("No.");
            }
            part(Qualification; "Applicant Qualification")
            {
                Caption = 'Qualification';
                SubPageLink = No = field("No.");
                Visible = false;
            }
            part(Control29; "Applicant's Employment History")
            {
                SubPageLink = "Application No" = field("No.");
                Visible = false;
            }
            part(Referees; Referees)
            {
                SubPageLink = No = field("No.");
            }
            part(Hobbies; "Applicant Hobbies")
            {
                Caption = 'Hobbies';
                SubPageLink = "No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part(JobApplicantPicture; "Job Applicant Picture")
            {
                SubPageLink = "No." = field("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146603),
                              "No." = FIELD("No.");
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
        area(Processing)
        {
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
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
        }
    }

    trigger OnInit()
    begin
        Employee := false;
    end;

    trigger OnOpenPage()
    begin
        EmployeeView();
        DisabilityView();
    end;

    var
        Disabling: Boolean;
        Employee: Boolean;

    local procedure DisabilityView()
    begin
        if Rec.Disabled = Rec.Disabled::Yes then
            Disabling := true
        else
            Disabling := false;
    end;

    local procedure EmployeeField()
    begin
        Rec."Employee No" := '';
    end;

    local procedure EmployeeView()
    begin
        if Rec."No." <> '' then
            if Rec."Applicant Type" <> Rec."Applicant Type"::Internal then
                Employee := false
            else
                Employee := true;
    end;

    local procedure GetAge(StartDate: Date): Text[200]
    var
        Dates: Codeunit "Dates Management";
    begin
        Rec.Age := '';
        if StartDate = 0D then
            StartDate := Today;
        Rec.Age := Dates.DetermineAge(Rec."Date Of Birth", Today);
    end;
}





