codeunit 52010 "Commitments Mgt HR"
{
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];

    procedure TrainingRequestCommittment(var TrainingRequest: Record "Training Request"; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        TrainingRequestLines: Record "Training Request Lines";
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        StartDate: Date;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        LineNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        TrainingRequest.TestField("Training Need");
        TrainingRequest.TestField("Planned Start Date");
        StartDate := TrainingRequest."Planned Start Date";
        LineNo := 0;
        TrainingRequestLines.Reset();
        TrainingRequestLines.SetRange(TrainingRequestLines."Document No.", TrainingRequest."Request No.");
        if TrainingRequestLines.FindFirst() then begin
            Committments.Reset();
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(TrainingRequestLines."G/L Account") then begin
                    LineNo += 10000;
                    Committments.Init();
                    Committments."Commitment No" := TrainingRequest."Request No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::"Training Request";
                    Committments."Commitment Date" := Today;
                    Committments."Global Dimension 1 Code" := TrainingRequest."Global Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := TrainingRequest."Global Dimension 2 Code";
                    Committments.Account := TrainingRequestLines."G/L Account";
                    Committments."Committed Amount" := TrainingRequestLines.Amount;

                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", TrainingRequestLines."G/L Account");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", TrainingRequest."Dimension Set ID");
                    FetchDimValue(TrainingRequest."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", StartDate);
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, TrainingRequestLines."G/L Account");
                    if GenLedSetup."Use Dimensions For Budget" then
                        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", TrainingRequest."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", StartDate);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    if LineCommitted(TrainingRequest."Request No.", TrainingRequestLines."G/L Account", LineNo) then
                        Message('Line No %1 has been committed', LineNo)
                    else
                        if CommittedAmount + TrainingRequestLines.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                                , TrainingRequest."Global Dimension 1 Code", TrainingRequest."Global Dimension 2 Code",
                                Abs(BudgetAvailable - (CommittedAmount + TrainingRequestLines.Amount)), BudgetAvailable - CommittedAmount, TrainingRequest.FieldCaption("Global Dimension 1 Code"),
                                TrainingRequest.FieldCaption("Global Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                                , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + TrainingRequestLines.Amount)), BudgetAvailable - CommittedAmount, TrainingRequest.FieldCaption("Global Dimension 1 Code"),
                                TrainingRequest.FieldCaption("Global Dimension 2 Code"));
                            LineError := true;
                        end;
                    Committments.User := UserId;
                    Committments."Document No" := TrainingRequest."Request No.";
                    Committments.No := TrainingRequestLines."G/L Account";
                    Committments."Line No." := LineNo;
                    Committments."Account Type" := Committments."Account Type"::"G/L Account";
                    Committments.Description := TrainingRequest.Description;
                    Committments."Dimension Set ID" := TrainingRequest."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(TrainingRequest."Request No.", TrainingRequestLines."G/L Account", LineNo) then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        TrainingRequestLines.Committed := true;
                        TrainingRequestLines.Modify();
                        //            IF LineError=FALSE THEN
                        //              MESSAGE('Items Committed Successfully and the balance is %1',
                        //              ABS(BudgetAvailable-(CommittedAmount+TrainingRequestLines.Amount)));
                    end;
                end;
            until TrainingRequestLines.Next() = 0;
            if LineError = false then
                Message('Items Committed Successfully and the balance is %1', Abs(BudgetAvailable - (CommittedAmount + TrainingRequestLines.Amount)));
            //    TrainingRequest.Status:=TrainingNeed.Status::Application;
            //    TrainingNeed.MODIFY;
        end;
    end;

    local procedure LineCommitted(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer) Exists: Boolean
    var
        Committed: Record "Commitment Entries";
    begin
        //Modified by Brian
        // Exists:=FALSE;
        // Committed.RESET;
        // Committed.SETRANGE(Committed."Commitment No",CommittmentNo);
        // Committed.SETRANGE(Committed.No,No);
        // Committed.SETRANGE(Committed."Line No.",LineNo);
        // Committed.SETFILTER(Committed."Commitment Type",'%1|%2',Committed."Commitment Type"::Commitment,Committed."Commitment Type"::"Commitment Reversal");
        // IF Committed.FIND('-') THEN
        //  BEGIN
        //    Committed.CALCSUMS("Committed Amount");
        //    IF Committed."Committed Amount"=0 THEN
        //      Exists:=FALSE
        //    ELSE
        //      Exists:=TRUE;
        //  END;

        Exists := false;
        Committed.Reset();
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-') then
            Exists := true;
    end;

    procedure FetchDimValue(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20]; var DimValueName: array[8] of Text)
    var
        DimSetEntry: Record "Dimension Set Entry";
        i: Integer;
    begin
        GetGLSetup();
        for i := 1 to 8 do begin
            ShortcutDimCode[i] := '';
            if GLSetupShortcutDimCode[i] <> '' then
                if DimSetEntry.Get(DimSetID, GLSetupShortcutDimCode[i]) then begin
                    DimSetEntry.CalcFields("Dimension Name", "Dimension Value Name");
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
                    DimValueName[i] := DimSetEntry."Dimension Value Name";
                end;
        end;
    end;

    local procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;

    local procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean
    var
        CashManagementSetups: Record "General Ledger Setup";
    begin
        /* GLAccountRec.Reset();
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst() then
            if GLAccountRec."Votebook Entry" then
                exit(true)
            else
                exit(false); */
        CashManagementSetups.Get();
        exit(CashManagementSetups."Check For Commitments");
    end;
}



