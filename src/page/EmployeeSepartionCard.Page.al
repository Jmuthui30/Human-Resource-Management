page 52011 "Employee Separtion Card"
{
    ApplicationArea = All;
    Caption = 'Employee Separtion Card';
    PageType = Card;
    SourceTable = "Employee Separation";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Not Rec.Posted;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Separation Type"; Rec."Separation Type")
                {
                    ToolTip = 'Specifies the value of the Separation Type field.';

                    trigger OnValidate()
                    begin
                        SetPageView();
                    end;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                group("Termination Details")
                {
                    Visible = TerminationRec;
                    field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                    {
                        ToolTip = 'Specifies the value of the Grounds for Termination Code field.';
                        //Visible = TerminationRec;
                    }
                    field("Termination Date"; Rec."Termination Date")
                    {
                        ToolTip = 'Specifies the value of the Termination Date field.';
                        //Visible = TerminationRec;
                    }
                }
                group("Financial Implication")
                {

                    field("Current Basic Pay"; Rec."Current Basic Pay")
                    {
                        ToolTip = 'Specifies the value of the Current Basic Pay field.';
                    }
                    field("Annual Leave Balance"; Rec."Annual Leave Balance")
                    {
                        ToolTip = 'Specifies the value of the Annual Leave Balance field.';
                    }
                    field("Leave Earned To Date"; Rec."Leave Earned To Date")
                    {
                        ToolTip = 'Specifies the value of the Leave Earned To Date field.';
                    }
                    field("Leave Liability"; Rec."Leave Liability")
                    {
                        ToolTip = 'Specifies the value of the Leave Liability field.';
                    }
                    field("Provident Fund - Employee"; Rec."Provident Fund - Employee")
                    {
                        ToolTip = 'Specifies the value of the Provident Fund - Employee field.';
                    }
                    field("Provident Fund - Employer"; Rec."Provident Fund - Employer")
                    {
                        ToolTip = 'Specifies the value of the Provident Fund - Employer field.';
                    }
                }

                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146746),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ProcessSeparation)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PeriodStatus;
                Enabled = Not Rec.Posted;
                Caption = 'Process Separation';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to process?', false) then begin
                        HRMgt.ProcessEmployeeSeparation(Rec);
                        Message('Processed Successfully');
                    end;

                    CurrPage.Close();
                end;
            }
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
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

    var
        HRMgt: Codeunit "HR Management";
        TerminationRec: Boolean;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;


    local procedure SetPageView()
    begin
        case Rec."Separation Type" of
            Rec."Separation Type"::Termination,
            Rec."Separation Type"::"Summary Dismissal":
                TerminationRec := true
            else
                TerminationRec := false;
        end;

        CurrPage.Update();
    end;
}






