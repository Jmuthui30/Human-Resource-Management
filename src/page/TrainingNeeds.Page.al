page 52170 "Training Needs"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Training';
    SourceTable = "Training Need";
    Caption = 'Training Needs';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field.';
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Training Objectives field';
                }
                field(Provider; Rec.Provider)
                {
                    ToolTip = 'Specifies the value of the Training Provider field';
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ToolTip = 'Specifies the value of the Provider Name field';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Open/Closed"; Rec."Open/Closed")
                {
                    ToolTip = 'Specifies the value of the Open/Closed field';
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duration Units field';
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duration field';
                }
                field("Country Code"; Rec."Country Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Country Code field';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cost Of Training field';
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cost Of Training (LCY) field';
                }
                field(Location; Rec.Location)
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Location field';
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Venue field';
                }
                group(More)
                {
                    Caption = 'More Details';

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field(DimVal1; Rec.DimVal1)
                    {
                        Caption = 'Name';
                        Visible = false;
                        ToolTip = 'Specifies the value of the Name field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
                    field(DimVal2; Rec.DimVal2)
                    {
                        Caption = '&Name';
                        Visible = false;
                        ToolTip = 'Specifies the value of the &Name field';
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field("No. of Participants"; Rec."No. of Participants")
                    {
                        ToolTip = 'Specifies the value of the No. of Participants field';
                    }
                    field("Need Source"; Rec."Need Source")
                    {
                        ToolTip = 'Specifies the value of the Need Source field';
                    }
                    field("Total Cost"; Rec."Total Cost")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Total Cost field';
                    }
                    field("Total PerDiem"; Rec."Total PerDiem")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Total PerDiem field';
                    }
                }
                group(Control23)
                {
                    ShowCaption = false;
                    Visible = false;

                    field(Qualification; Rec.Qualification)
                    {
                        ToolTip = 'Specifies the value of the Qualification field';
                    }
                    field("Re-Assessment Date"; Rec."Re-Assessment Date")
                    {
                        ToolTip = 'Specifies the value of the Re-Assessment Date field';
                    }
                    field(Source; Rec.Source)
                    {
                        ToolTip = 'Specifies the value of the Source field';
                    }
                    field(Post; Rec.Post)
                    {
                        ToolTip = 'Specifies the value of the Post field';
                    }
                    field(Posted; Rec.Posted)
                    {
                        ToolTip = 'Specifies the value of the Posted field';
                    }
                    field("Department Code"; Rec."Department Code")
                    {
                        ToolTip = 'Specifies the value of the Department Code field';
                    }
                }
            }
            part(Control39; "Training Needs Lines")
            {
                //Visible = true;
                SubPageLink = "Document No." = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Ready)
            {
                Caption = 'Set As Ready For Application';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Set As Ready For Application action';
                Visible = false;

                trigger OnAction()
                var
                    HRNofications: Codeunit "HR Notifications";
                begin
                    if Confirm('Are you sure you want to set this need as ready for application ?', false) then begin
                        //   Committment.TrainingNeedCommittment(Rec,ErrorMsg);
                        //    IF ErrorMsg<>'' THEN
                        //      ERROR(ErrorMsg);
                        Rec.Status := Rec.Status::Application;
                        Rec.Modify();

                        if Confirm('Do you want to notify all employees by mail?', false) then
                            HRNofications.NotifyTrainingNeeds(Rec);
                    end;
                end;
            }
            action(Close)
            {
                Caption = 'Close Need';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Close Need action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this need?', false) then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify();
                    end;
                end;
            }
            action("Proposed Training Participants")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Training participants";
                Visible = Rec.Status <> Rec.Status::Closed;
                ToolTip = 'Executes the Proposed Training Participants action';
            }
            action("Approved Training Participants")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Approved Training Request List";
                RunPageLink = "Training Need" = field(Code),
                              Status = filter(Released);
                ToolTip = 'Executes the Approved Training Participants action';
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status := Rec.Status::Application;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Application;
    end;

    var
        GLBudgetEntry: Record "G/L Budget Entry";
        GLEntry: Record "G/L Entry";
        TrainingNeedsLines: Record "Training Needs Lines";
        BudgetStartDate: Date;
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        Expenses: Decimal;
        AccountNoFilter: Text;

    local procedure SetView()
    var
        GenLedSetup: Record "General Ledger Setup";
        AccountNo: Code[20];
    begin
        AccountNoFilter := '';
        AccountNo := '';
        BudgetAmount := 0;
        Expenses := 0;
        BudgetAvailable := 0;
        GenLedSetup.Get();
        BudgetStartDate := GenLedSetup."Current Budget Start Date";
        TrainingNeedsLines.Reset();
        TrainingNeedsLines.SetCurrentKey("G/L Account");
        TrainingNeedsLines.SetRange("Document No.", Rec.Code);
        if TrainingNeedsLines.FindFirst() then
            repeat
                if TrainingNeedsLines."G/L Account" <> '' then
                    if AccountNoFilter <> '' then begin
                        if TrainingNeedsLines."G/L Account" <> AccountNo then
                            AccountNoFilter += '|' + TrainingNeedsLines."G/L Account";
                        AccountNo := TrainingNeedsLines."G/L Account";
                    end else begin
                        AccountNoFilter := TrainingNeedsLines."G/L Account";
                        AccountNo := TrainingNeedsLines."G/L Account";
                    end;
            until TrainingNeedsLines.Next() = 0;

        GLBudgetEntry.Reset();
        GLBudgetEntry.SetFilter("G/L Account No.", AccountNoFilter);
        GLBudgetEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        GLBudgetEntry.SetRange(Date, BudgetStartDate, Today);
        if GLBudgetEntry.FindFirst() then begin
            GLBudgetEntry.CalcSums(Amount);
            BudgetAmount := GLBudgetEntry.Amount;
        end;

        GLEntry.Reset();
        GLEntry.SetFilter("G/L Account No.", AccountNoFilter);
        GLEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        GLEntry.SetRange("Posting Date", BudgetStartDate, Today);
        if GLEntry.FindFirst() then begin
            GLEntry.CalcSums(Amount);
            Expenses := GLEntry.Amount;
        end;

        BudgetAvailable := BudgetAmount - Expenses;
        // GLAccount.RESET;
        // GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
        // GLAccount.SETFILTER(GLAccount."No.",AccountNoFilter);
        // GLAccount.SETRANGE(GLAccount."Dimension Set ID Filter","Dimension Set ID");
        // GLAccount.SETRANGE(GLAccount."Date Filter",BudgetStartDate,TODAY);
        // IF GLAccount.FIND('-') THEN
        //  BEGIN
        //    GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change","Approved Budget","Disbursed Budget");
        //    BudgetAmount:=GLAccount."Approved Budget";
        //    Expenses:=GLAccount."Net Change";
        //    BudgetAvailable:=GLAccount."Approved Budget"-GLAccount."Net Change";
        //  END;
    end;
}





