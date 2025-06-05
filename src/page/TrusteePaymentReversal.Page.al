page 52264 "Trustee Payment Reversal"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Trustee Payment Reversal";
    Caption = 'Trustee Payment Reversal';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.posted;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created Date field';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ToolTip = 'Specifies the value of the Bank Account field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                group(History)
                {
                    Editable = false;

                    field(Posted; Rec.Posted)
                    {
                        ToolTip = 'Specifies the value of the Posted field';
                    }
                    field(Status; Rec.Status)
                    {
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field("User ID"; Rec."User ID")
                    {
                        ToolTip = 'Specifies the value of the User ID field';
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        ToolTip = 'Specifies the value of the Posted By field';
                    }
                    field("Posted Date-Time"; Rec."Posted Date-Time")
                    {
                        ToolTip = 'Specifies the value of the Posted Date-Time field';
                    }
                }
            }
            part(Control10; "Trustee Payment Lines")
            {
                Editable = not Rec.posted;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Reversal")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = not Rec.posted;
                ToolTip = 'Executes the Post Reversal action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post this reversal?', false) then
                        Payroll.ReverseTrusteePayment(Rec);
                end;
            }
        }
    }

    var
        Payroll: Codeunit Payroll;
}





