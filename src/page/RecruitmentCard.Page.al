page 52085 "Recruitment Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Portal Controls,Start Shortlist';
    SourceTable = "Recruitment Needs";
    Caption = 'Recruitment Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec."Submitted To Portal";

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Positions; Rec.Positions)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appointment Type field';
                }
                field("Appointment Type Description"; Rec."Appointment Type Description")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Appointment Type Description field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                    MultiLine = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Reason for Recruitment field';
                }
                field(Priority; Rec.Priority)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    Caption = 'Expected vacancy announcement date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Expected vacancy announcement date field';
                }
                field("Reason for Recruitment(text)"; Rec."Reason for Recruitment(text)")
                {
                    Caption = 'Reason for Recruitment';
                    Editable = false;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Reason for Recruitment field';
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Shortlisting Closed"; Rec."Shortlisting Closed")
                {
                    ToolTip = 'Specifies the value of the Shortlisting Closed field';
                    Enabled = false;
                }
                field("Shortlisting Started"; Rec."Shortlisting Started")
                {
                    ToolTip = 'Specifies the value of the Shortlisting Started field';
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Approved; Rec.Approved)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Approved field';
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Date Approved field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                }
                field("Total Recruitment Costs"; Rec."Total Recruitment Costs")
                {
                    ToolTip = 'Specifies the value of the Total Recruitment Costs field.';
                }
            }
            part(RecruitmentCosts; "Recruitment Costs")
            {
                Caption = 'Recruitment Costs';
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Need Code" = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Approvals")
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
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            group("Portal Controls")
            {
                action("Shortlist Started")
                {
                    Caption = 'Start Shortlisting';
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Image = AddContacts;
                    ToolTip = 'Executes the Shortlist Started action';
                    Enabled = not Rec."Shortlisting Started";

                    trigger OnAction()
                    var
                        ShortlistConfirmMsg: Label 'Are you sure you want to start the shortlisting process ?';
                    begin

                        if Confirm(ShortlistConfirmMsg, false) then begin
                            HRMgt.StartShortlist(Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action("Submit To Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = AddContacts;
                    ToolTip = 'Executes the Submit To Portal action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    ToolTip = 'Executes the Remove from Portal action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := false;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditable();
    end;

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
        HRMgt: Codeunit "HR Management";
        NOTEditable: Boolean;

    local procedure SetEditable()
    begin
        if Rec.Status = Rec.Status::Released then
            NOTEditable := false
        else
            NOTEditable := true;
    end;
}





