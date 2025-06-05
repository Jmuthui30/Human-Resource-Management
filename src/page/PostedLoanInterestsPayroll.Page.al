page 52270 "Posted Loan Interests-Payroll"
{
    ApplicationArea = All;
    CardPageID = "Posted Loan Interest-Payroll";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Header";
    SourceTableView = where(Posted = const(true),
                            Reversed = const(false));
    Caption = 'Posted Loan Interests-Payroll';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Period Reference"; Rec."Period Reference")
                {
                    ToolTip = 'Specifies the value of the Period Reference field';
                }
                field("Period Narration"; Rec."Period Narration")
                {
                    ToolTip = 'Specifies the value of the Period Narration field';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action13)
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





