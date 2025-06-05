page 52272 "Posted Loan Interest-Payroll"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Post';
    SourceTable = "Loan Interest Header";
    Caption = 'Posted Loan Interest-Payroll';
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
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                group(Control23)
                {
                    ShowCaption = false;
                    Visible = Rec.Reversed;

                    field(Reversed; Rec.Reversed)
                    {
                        ToolTip = 'Specifies the value of the Reversed field';
                    }
                    field("Reversed By"; Rec."Reversed By")
                    {
                        ToolTip = 'Specifies the value of the Reversed By field';
                    }
                    field("Date Reversed"; Rec."Date Reversed")
                    {
                        ToolTip = 'Specifies the value of the Date Reversed field';
                    }
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
                Visible = false;

                action(Suggest)
                {
                    Caption = 'Suggest Interest Lines';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Suggest Interest Lines action';

                    trigger OnAction()
                    begin
                        //InvestmentPropertyMgt.SuggestPropertyInterestLines(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'Post Interest';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Post Interest action';

                    trigger OnAction()
                    begin
                        // IF CONFIRM(PostConfirm,FALSE) THEN
                        //  InvestmentPropertyMgt.PostPropertyInterest(Rec);
                    end;
                }
            }
            group(Action18)
            {
                action(Reverse)
                {
                    Caption = 'Reverse Interest Batch';
                    Enabled = not Rec.Reversed;
                    Image = ReverseRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Reverse Interest Batch action';

                    trigger OnAction()
                    var
                        GLRegister: Record "G/L Register";
                        GLRegister2: Record "G/L Register";
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        if Confirm('Are you sure you want to reverse Batch No. %1 ?', false, Rec."No.") then begin
                            GLRegister.Reset();
                            GLRegister.SetRange("Journal Batch Name", Rec."No.");
                            if GLRegister.Find('-') then begin
                                Clear(ReversalEntry);
                                ReversalEntry.SetHideDialog(false);
                                ReversalEntry.ReverseRegister(GLRegister."No.");
                                Commit();

                                //Check if fully reversed
                                GLRegister2.Reset();
                                GLRegister2.SetRange("No.", GLRegister."No.");
                                GLRegister2.SetRange(Reversed, true);
                                if GLRegister2.Find('-') then begin
                                    Rec.Reversed := true;
                                    Rec."Reversed By" := UserId;
                                    Rec."Date Reversed" := Today;
                                    Rec.Modify();
                                    Message('Successfully Reversed');
                                end;
                            end;
                        end;

                        CurrPage.Update();
                        CurrPage.Close();
                    end;
                }
            }
        }
    }
}





