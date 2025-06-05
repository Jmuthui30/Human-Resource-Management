page 52056 "Training Request Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Training Request";
    Caption = 'Training Request Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::"Open";

                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request No. field';
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Designation; Rec.Designation)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field(Adhoc; Rec.Adhoc)
                {
                    ToolTip = 'Specifies the value of the Adhoc field';

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Training Need"; Rec."Training Need")
                {
                    Visible = not NeedRequest;
                    ToolTip = 'Specifies the value of the Training Need field';
                }
            }
            group("Training Details")
            {
                Caption = 'Training Details';
                Editable = false;
                Visible = NeedRequest = false;

                field(Description; Rec.Description)
                {
                    Caption = 'Training Description';
                    ToolTip = 'Specifies the value of the Training Description field';
                }
                field("Training Objective"; Rec."Training Objective")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Training Objective field';
                }
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    Caption = 'From';
                    ToolTip = 'Specifies the value of the From field';
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    Caption = 'To';
                    ToolTip = 'Specifies the value of the To field';
                }
                field("No. Of Days"; Rec."No. Of Days")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No. Of Days field';
                }
                field(Destination; Rec.Destination)
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Destination field';
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Venue field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Country Code"; Rec."Country Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Country Code field';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Cost of Training"; Rec."Cost of Training")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cost of Training field';
                }
                field("Cost of Training (LCY)"; Rec."Cost of Training (LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cost of Training (LCY) field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin

                    end;
                }
            }
            part("Training Need Request"; "Training Needs Request")
            {
                Visible = NeedRequest;
                SubPageLink = "Source Document No" = field("Request No."), "Employee No" = field("Employee No"), "Need Source" = const(Adhoc);
            }
            part(TrainingRequestLines; "Training Request Lines")
            {
                Visible = false;
                SubPageLink = "Document No." = field("Request No."),
                              "Training Need No" = field("Training Need");
            }
            part("Travelling Employees"; "Travelling Employees List")
            {
                Visible = false;
                Caption = 'Travelling Employees';
                SubPageLink = "Request No." = field("Request No.");
            }
        }
        area(factboxes)
        {

            part(CommentsFactBox; "Approval Comments FactBox")
            {
                SubPageLink = "Document No." = field("Request No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146446),
                              "No." = FIELD("Request No.");
            }
        }

    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin

                    if ApprovalsMgmt.CheckTrainingRequestWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendTrainingRequestforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelTrainingRequestApproval(Rec);
                end;
            }
            action("View Approvals")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Enum "Approval Document Type";
                begin

                    DocumentType := DocumentType::TrainingRequest;
                    ApprovalEntries.SetRecordFilters(Database::"Training Request", DocumentType, Rec."Request No.");
                    ApprovalEntries.Run();
                end;
            }
            /* action("Apply Imprest")
            {
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = DocReleased;
                ApplicationArea = All;
                ToolTip = 'Executes the Apply Imprest action';

                trigger OnAction()
                var
                    paymentlines: Record "Payment Lines";
                    payments: Record Payments;
                    ImprestTypes: Record "Receipts and Payment Types";
                    TrainingLines: Record "Training Request Lines";
                    DocNo: Code[50];
                begin
                    payments.Init();
                    payments."No." := '';
                    payments.TrainingNo := Rec."Training Need";
                    //payments."Account No." := "Employee No";
                    //payments.Validate("Account No.");
                    payments."Payment Type" := payments."Payment Type"::Imprest;
                    payments.Destination := Rec.Destination;
                    payments."Date of Project" := Rec."Planned Start Date";
                    payments."Date of Completion" := Rec."Planned End Date";
                    payments."No of Days" := Rec."No. Of Days";
                    payments."Account Type" := payments."Account Type"::Customer;
                    payments.Insert(true);
                    DocNo := payments."No.";

                    TrainingLines.Reset();
                    TrainingLines.SetRange("Document No.", Rec."Request No.");
                    if TrainingLines.Find('-') then
                        repeat
                            paymentlines.Init();
                            paymentlines.No := DocNo;
                            paymentlines."Payment Type" := paymentlines."Payment Type"::Imprest;
                            ImprestTypes.SetRange(Type, ImprestTypes.Type::Imprest);
                            ImprestTypes.SetRange(Training, true);
                            if ImprestTypes.FindFirst() then
                                paymentlines."Expenditure Type" := ImprestTypes.Code;
                            paymentlines.Validate("Expenditure Type");
                            paymentlines.Amount := TrainingLines.Amount;
                            paymentlines.Insert(true);
                        until TrainingLines.Next() = 0;
                    Page.Run(Page::"Imprest", payments);
                end;
            } */
        }

    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        CanCancelApprovalForRecord: Boolean;
        DocReleased: Boolean;
        NeedRequest: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        if (Rec.Adhoc = true) then
            NeedRequest := true
        else
            NeedRequest := false;

    end;
}





