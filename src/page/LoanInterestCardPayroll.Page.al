page 52268 "Loan Interest Card-Payroll"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Post';
    SourceTable = "Loan Interest Header";
    Caption = 'Loan Interest Card-Payroll';
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
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Entered field';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Period Reference"; Rec."Period Reference")
                {
                    ToolTip = 'Specifies the value of the Period Reference field';
                }
                field("Period Narration"; Rec."Period Narration")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Period Narration field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                }
            }
            part(Control11; "Loan Interest Lines-Payroll")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Action14)
            {
                action(Suggest)
                {
                    Caption = 'Suggest Interest Lines';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Suggest Interest Lines action';

                    trigger OnAction()
                    begin
                        Payroll.SuggestLoanInterestLines(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'Post Interest';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Post Interest action';

                    trigger OnAction()
                    begin
                        if Confirm(PostConfirm, false) then
                            Payroll.PostLoanInterest(Rec);
                    end;
                }
                action(Clear)
                {
                    Caption = 'Clear Lines';
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Clear Lines action';

                    trigger OnAction()
                    begin
                        LoanInterestLines.SetRange("Document No.", Rec."No.");
                        LoanInterestLines.DeleteAll();
                    end;
                }
            }
        }
    }

    var
        LoanInterestLines: Record "Loan Interest Lines";
        Payroll: Codeunit Payroll;
        PostConfirm: Label 'Are you sure you want to post?';
}





