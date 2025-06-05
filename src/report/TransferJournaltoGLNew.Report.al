report 52078 "Transfer Journal to GL-New"
{
    ApplicationArea = All;
    Caption = 'Transfer Payroll to Journal';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Employee Posting GroupX"; "Employee HR Posting Group")
        {
            DataItemTableView = where("Employee Type" = filter(<> Trustee));
            RequestFilterFields = "Pay Period Filter", "Code";

            column(Employee_Posting_GroupX_Code; Code)
            {
            }
            column(Employee_Posting_GroupX_Pay_Period_Filter; "Pay Period Filter")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "Posting Group" = field(Code), "Pay Period Filter" = field("Pay Period Filter");
                DataItemTableView = where("Employee Type" = filter(<> "Board Member"));
                RequestFilterFields = "No.";

                column(COMPANYNAME; CompanyName)
                {
                }
                column(Employee_Posting_GroupX__Description; "Employee Posting GroupX".Description)
                {
                }
                column(Employee_Posting_GroupX__Code; "Employee Posting GroupX".Code)
                {
                }
                column(Payroll_Journal_summary_reportCaption; Payroll_Journal_summary_reportCaptionLbl)
                {
                }
                column(Employee_No_; "No.")
                {
                }
                column(Employee_Posting_Group; "Posting Group")
                {
                }
                column(Employee_Pay_Period_Filter; "Pay Period Filter")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Employee.CalcFields("Total Allowances", "Total Deductions", "Loan Interest", "Basic Pay");

                    TotalNetPay := Employee."Basic Pay";// TotalNetPay + (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest");
                    //********************8
                    GrossAmout := 0;

                    // AppTimeSheet.Reset();
                    // AppTimeSheet.SetRange(AppTimeSheet."Employee No.", "No.");
                    // if AppTimeSheet.Find('-') then
                    //     repeat
                    GrossAmout := AppTimeSheet."Amount Allocated ch";

                    LineNumber := LineNumber + 10000;

                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := BatchTemplate;
                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Line No." := LineNumber;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := '510054';
                    GenJnlLine.Validate("Account No.");
                    GenJnlLine."Posting Date" := Payday;
                    GenJnlLine.Description := AppTimeSheet."Project Code" + '_Salary' + Format(DateSpecified, 0, '<month text> <year4>');
                    GenJnlLine."Document No." := Payperiodtext;
                    GenJnlLine."Shortcut Dimension 1 Code" := AppTimeSheet."Donor Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := AppTimeSheet."Project Code";
                    GenJnlLine.Amount := Round(TotalNetPay);
                    GenJnlLine.Validate(Amount);
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert()
                    // until AppTimeSheet.Next() = 0;

                    //  end;

                end;

                trigger OnPostDataItem()
                begin
                    TotalCredits := TotalCredits + TotalNetPay;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("No.");
                end;
            }
            dataitem(Earnings; Earnings)
            {
                DataItemLink = "Posting Group Filter" = field(Code), "Pay Period Filter" = field("Pay Period Filter"), "Employee Type Filter" = field("Employee Type Filter");
                DataItemTableView = sorting(Code);

                column(Earnings_Description; Description)
                {
                }
                column(Earnings__Total_Amount_; "Total Amount")
                {
                }
                column(Earnings_Code; Code)
                {
                }
                column(Earnings_Posting_Group_Filter; "Posting Group Filter")
                {
                }
                column(Earnings_Pay_Period_Filter; "Pay Period Filter")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // Counter := Counter + 1;
                    // Percentage := Round(Counter / TotalCount * 10000, 1);
                    // Window.Update(2, Percentage);

                    // Earnings.CalcFields("Total Amount");
                    //EarningsCopy.SETRANGE(EarningsCopy."Pay Period Filter",DateSpecified,CALCDATE('1M',DateSpecified)-1);
                    // AppTimeSheet.Reset();
                    // AppTimeSheet.SetRange(AppTimeSheet."Employee No", "No.");
                    // if AppTimeSheet.Find('-') then begin
                    //     repeat
                    //         TotalNetPay := TotalNetPay / AppTimeSheet."Billable Time";
                    //     until AppTimeSheet.Next() = 0;

                    // end;
                    //   Message('totat net pay is %1', TotalNetPay);

                    // TotalDebits := TotalDebits + "Total Amount";
                    // if Earnings."Total Amount" = 0 then
                    //     CurrReport.Skip();


                    // LineNumber := LineNumber + 10000;
                    // Earnings.TestField(Earnings."Account No.");

                    // GenJnlLine.Init();
                    // GenJnlLine."Journal Template Name" := BatchTemplate;
                    // GenJnlLine."Journal Batch Name" := BatchName;
                    // GenJnlLine."Line No." := LineNumber;
                    // GenJnlLine."Account Type" := Earnings."Account Type";
                    // GenJnlLine."Account No." := Earnings."Account No.";
                    // GenJnlLine.Validate("Account No.");
                    // GenJnlLine."Posting Date" := Payday;
                    // GenJnlLine.Description := Earnings.Description + 'test 324S' + Format(DateSpecified, 0, '<month text> <year4>');
                    // GenJnlLine."Document No." := Payperiodtext;
                    // GenJnlLine."Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    // GenJnlLine.Amount := Round(Earnings."Total Amount");
                    // GenJnlLine.Validate(Amount);
                    // if GenJnlLine.Amount <> 0 then
                    //     GenJnlLine.Insert()
                end;

                trigger OnPreDataItem()
                begin
                    Earnings.SetRange(Earnings."Non-Cash Benefit", false);
                    Earnings.SetRange(Gratuity, false);
                    Earnings.SetFilter("Employee Type Filter", '<>%1', Earnings."Employee Type Filter"::Trustee);

                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            dataitem(Employer; Deductions)
            {
                DataItemLink = "Posting Group Filter" = field(Code), "Employee Type Filter" = field("Employee Type Filter");
                DataItemTableView = sorting(Code);

                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);

                    Employer.CalcFields(Employer."Total Amount Employer");
                    LineNumber := LineNumber + 10000;

                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := BatchTemplate;
                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Line No." := LineNumber;
                    GenJnlLine."Account Type" := Employer."Account Type Employer";
                    GenJnlLine."Account No." := Employer."Account No. Employer";
                    GenJnlLine.Validate("Account No.");
                    GenJnlLine."Posting Date" := Payday;
                    GenJnlLine.Description := Employer.Description + ' -Employer  ' + Format(DateSpecified, 0, '<month text> <year4>');
                    GenJnlLine."Document No." := Payperiodtext;
                    GenJnlLine.Amount := Round(Employer."Total Amount Employer");
                    GenJnlLine.Validate(Amount);
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                end;

                trigger OnPreDataItem()
                begin
                    Employer.SetRange(Employer."Pay Period Filter", DateSpecified);

                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            dataitem(Deductions; Deductions)
            {
                DataItemLink = "Posting Group Filter" = field(Code), "Employee Type Filter" = field("Employee Type Filter");
                DataItemTableView = sorting(Code) where(Loan = const(false), "Sacco Deduction" = const(false));

                column(Deductions_Description; Description)
                {
                }
                column(Deductions__Total_Amount_; "Total Amount")
                {
                }
                column(Deductions_Code; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);

                    Deductions.CalcFields(Deductions."Total Amount", Deductions."Total Amount Employer");
                    if Deductions."Total Amount" = 0 then
                        CurrReport.Skip();


                    LineNumber := LineNumber + 10000;

                    TotalCredits := Abs(TotalCredits) + Abs("Total Amount");

                    Deductions.TestField(Deductions."Account No.");
                    GenJnlLine."Journal Template Name" := BatchTemplate;
                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Line No." := LineNumber;
                    GenJnlLine."Account Type" := Deductions."Account Type";
                    GenJnlLine."Account No." := Deductions."Account No.";
                    GenJnlLine.Validate("Account No.");
                    GenJnlLine."Posting Date" := Payday;
                    GenJnlLine.Description := Deductions.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                    GenJnlLine."Document No." := Payperiodtext;
                    GenJnlLine.Amount := Round(Deductions."Total Amount");
                    GenJnlLine.Validate(Amount);
                    if (GenJnlLine.Amount <> 0) and (not TransferLoans) then
                        GenJnlLine.Insert();

                    if Deductions."Total Amount Employer" <> 0 then begin
                        //TotalSSF := ABS(Deductions."Total Amount") + ABS(Deductions."Total Amount Employer");
                        TotalSSF := Abs(Deductions."Total Amount Employer");
                        Deductions.TestField(Deductions."Account No. Employer");

                        LineNumber := LineNumber + 10000;
                        GenJnlLine.Init();
                        GenJnlLine."Journal Template Name" := BatchTemplate;
                        GenJnlLine."Journal Batch Name" := BatchName;
                        GenJnlLine."Line No." := LineNumber;
                        GenJnlLine."Account Type" := Deductions."Account Type";
                        GenJnlLine."Account No." := Deductions."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Date" := Payday;
                        GenJnlLine.Description := Deductions.Description + '-Employer ' + Format(DateSpecified, 0, '<month text> <year4>');
                        GenJnlLine."Document No." := Payperiodtext;
                        GenJnlLine.Amount := -Round(TotalSSF);
                        GenJnlLine.Validate(Amount);
                        GenJnlLine.Insert();

                        TotalDebits := TotalDebits + Abs(Deductions."Total Amount Employer");
                        TotalCredits := TotalCredits + TotalSSF;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Deductions.SetRange(Deductions."Pay Period Filter", DateSpecified);
                    Deductions.SetFilter("Employee Type Filter", '<>%1', Deductions."Employee Type Filter"::Trustee);

                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            dataitem(HRLoansRec; Deductions)
            {
                DataItemLink = "Posting Group Filter" = field(Code), "Employee Type Filter" = field("Employee Type Filter");
                DataItemTableView = sorting(Code) where(Loan = const(true), "Sacco Deduction" = const(false));

                column(LoansRec_Description; Description)
                {
                }
                column(LoansRec__Total_Amount_; "Total Amount")
                {
                }
                column(LoansRec_Code; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);

                    HRLoansRec.CalcFields("Total Amount");
                    TotalCredits := Abs(TotalCredits) + Abs("Total Amount") + Abs("Loan Interest");

                    //Internal Loans
                    AssignmentMat.Reset();
                    AssignmentMat.SetRange(AssignmentMat.Type, AssignmentMat.Type::Deduction);
                    AssignmentMat.SetRange(AssignmentMat.Code, HRLoansRec.Code);
                    AssignmentMat.SetRange(AssignmentMat."Payroll Period", DateSpecified);
                    if AssignmentMat.Find('-') then
                        repeat
                            LoanApp.Reset();
                            LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                            if LoanApp.Find('+') then
                                if Loanproduct.Get(LoanApp."Loan Product Type") then
                                    if Loanproduct.Internal then begin
                                        //Principal Repayment
                                        LineNumber := LineNumber + 10000;

                                        GenJnlLine.Init();
                                        GenJnlLine."Journal Template Name" := BatchTemplate;
                                        GenJnlLine."Journal Batch Name" := BatchName;
                                        GenJnlLine."Line No." := LineNumber;
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                        LoanApp.Reset();
                                        LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                                        if LoanApp.Find('+') then
                                            GenJnlLine."Account No." := LoanApp."Debtors Code";
                                        GenJnlLine.Validate("Account No.");
                                        GenJnlLine."Posting Date" := Payday;
                                        GenJnlLine.Description := HRLoansRec.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                                        GenJnlLine."Document No." := Payperiodtext;
                                        GenJnlLine.Amount := Round(AssignmentMat.Amount);
                                        GenJnlLine.Validate(Amount);
                                        GenJnlLine."Payroll Loan No." := AssignmentMat."Reference No";
                                        GenJnlLine."Payroll Loan Transaction Type" := GenJnlLine."Payroll Loan Transaction Type"::"Principal Repayment";
                                        GenJnlLine."Applies-to Doc. No." := AssignmentMat."Reference No";
                                        GenJnlLine.Validate("Applies-to Doc. No.");
                                        GenJnlLine."Employee Code" := AssignmentMat."Employee No";
                                        GenJnlLine."Emp Payroll Period" := DateSpecified;
                                        GenJnlLine."Emp Payroll Code" := AssignmentMat.Code;
                                        if (GenJnlLine.Amount <> 0) and not (InsertedinJournal(BatchTemplate, BatchName, AssignmentMat."Employee No",
                                                DateSpecified, GenJnlLine.Amount, GenJnlLine."Document No.", AssignmentMat.Code)) then
                                            GenJnlLine.Insert();

                                        //Interest Repayment
                                        LineNumber := LineNumber + 10000;

                                        GenJnlLine.Init();
                                        GenJnlLine."Journal Template Name" := BatchTemplate;
                                        GenJnlLine."Journal Batch Name" := BatchName;
                                        GenJnlLine."Line No." := LineNumber;
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                        LoanApp.Reset();
                                        LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                                        if LoanApp.Find('+') then
                                            GenJnlLine."Account No." := LoanApp."Debtors Code";
                                        GenJnlLine."Posting Date" := Payday;
                                        GenJnlLine.Description := HRLoansRec.Description + ' Interest ' + Format(DateSpecified, 0, '<month text> <year4>');
                                        GenJnlLine."Document No." := Payperiodtext;
                                        GenJnlLine.Amount := Round(AssignmentMat."Loan Interest");
                                        GenJnlLine.Validate(Amount);
                                        GenJnlLine."Payroll Loan No." := AssignmentMat."Reference No";
                                        GenJnlLine."Period Reference" := AssignmentMat."Payroll Period";
                                        GenJnlLine."Payroll Loan Transaction Type" := GenJnlLine."Payroll Loan Transaction Type"::"Interest Repayment";
                                        GenJnlLine."Employee Code" := AssignmentMat."Employee No";
                                        GenJnlLine."Emp Payroll Period" := DateSpecified;
                                        GenJnlLine."Emp Payroll Code" := AssignmentMat.Code + '-INT';
                                        //Post Interest Application
                                        if HRLoansRec.Loan then begin
                                            if GetPayPeriodLoanInterestDocNo(GenJnlLine."Account No.", GenJnlLine."Period Reference") <> '' then
                                                GenJnlLine."Applies-to Doc. No." := GetPayPeriodLoanInterestDocNo(GenJnlLine."Account No.", GenJnlLine."Period Reference");
                                            GenJnlLine.Validate("Applies-to Doc. No.");
                                        end;
                                        if (GenJnlLine.Amount <> 0) and not (InsertedinJournal(BatchTemplate, BatchName, AssignmentMat."Employee No",
                                                DateSpecified, GenJnlLine.Amount, GenJnlLine."Document No.", GenJnlLine."Emp Payroll Code")) then
                                            GenJnlLine.Insert();
                                    end;
                        until AssignmentMat.Next() = 0;

                    TotalDebits := TotalDebits + Abs(HRLoansRec."Total Amount Employer");
                    TotalCredits := TotalCredits + HRLoansRec."Total Amount";
                end;

                trigger OnPreDataItem()
                begin
                    HRLoansRec.SetRange(HRLoansRec."Pay Period Filter", DateSpecified);

                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            dataitem(EmpGratuity; Earnings)
            {
                DataItemLink = "Posting Group Filter" = field(Code), "Employee Type Filter" = field("Employee Type Filter");
                DataItemTableView = sorting(Code);

                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);

                    EmpGratuity.CalcFields("Total Amount");
                    TotalCredits := Abs(TotalCredits) + Abs("Total Amount");

                    AssignmentMat.Reset();
                    AssignmentMat.SetRange(AssignmentMat.Type, AssignmentMat.Type::Earning);
                    AssignmentMat.SetRange(AssignmentMat.Code, EmpGratuity.Code);
                    AssignmentMat.SetRange(AssignmentMat."Payroll Period", DateSpecified);
                    AssignmentMat.SetRange(Gratuity, true);
                    if AssignmentMat.FindSet(true) then
                        //   repeat
                        if EmpRec.Get(AssignmentMat."Employee No") then
                            EmpName := EmpRec.FullName();

                    //Employee Gratuity
                    LineNumber := LineNumber + 10000;

                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := BatchTemplate;
                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Line No." := LineNumber;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                    GenJnlLine."Account No." := GetGratuityVendorNo(AssignmentMat."Employee No");
                    GenJnlLine.Validate("Account No.");
                    GenJnlLine."Bal. Account Type" := EmpGratuity."Account Type";
                    GenJnlLine."Bal. Account No." := EmpGratuity."Account No.";
                    GenJnlLine."Posting Date" := Payday;
                    GenJnlLine.Description := EmpGratuity.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>') + '-' + EmpName;
                    GenJnlLine."Document No." := Payperiodtext;
                    GenJnlLine.Amount := -Round(AssignmentMat.Amount);
                    GenJnlLine.Validate(Amount);
                    GenJnlLine."Employee Code" := EmpRec."No.";
                    GenJnlLine."Emp Payroll Period" := DateSpecified;
                    GenJnlLine."Emp Payroll Code" := AssignmentMat.Code;
                    if (GenJnlLine.Amount <> 0) and not InsertedinJournal(BatchTemplate, BatchName, GenJnlLine."Employee Code",
                         DateSpecified, GenJnlLine.Amount, GenJnlLine."Document No.", AssignmentMat.Code) then
                        GenJnlLine.Insert();
                    //    until AssignmentMat.Next() = 0;

                    TotalCredits := TotalCredits + EmpGratuity."Total Amount";
                end;

                trigger OnPreDataItem()
                begin
                    EmpGratuity.SetRange(EmpGratuity."Pay Period Filter", DateSpecified);
                    EmpGratuity.SetRange("Non-Cash Benefit", false);
                    EmpGratuity.SetRange(Gratuity, true);
                    EmpGratuity.SetFilter("Employee Type Filter", '<>%1', EmpGratuity."Employee Type Filter"::Trustee);
                    TotalCount := Count;
                    Counter := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalncomeTax := 0;
                TotalBasic := 0;
                Totalgross := 0;
                "Employee Posting GroupX".TestField("Net Salary Payable");

                PayablesAccType := "Employee Posting GroupX"."Net Salary Account Type";
                PayablesAcc := "Employee Posting GroupX"."Net Salary Payable";
            end;
        }
        dataitem(Summary; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Summary_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LineNumber := LineNumber + 10000;

                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := BatchTemplate;
                GenJnlLine."Journal Batch Name" := BatchName;
                GenJnlLine."Line No." := LineNumber;
                GenJnlLine."Account Type" := PayablesAccType;
                GenJnlLine."Account No." := PayablesAcc;
                GenJnlLine.Validate("Account No.");
                GenJnlLine."Posting Date" := Payday;
                GenJnlLine.Description := 'Salary payable' + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                GenJnlLine."Document No." := Payperiodtext;
                GenJnlLine.Amount := -Round(TotalNetPay);
                GenJnlLine.Validate(Amount);
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPostReport()
    var
        ConfirmOpenJournal: Label 'The Payroll Journal for %1 has been Generated to Template %3 - Batch %2. Do you want to Open the Journal? ';
    begin
        Window.Close();

        if Confirm(ConfirmOpenJournal, false, Payperiodtext, BatchTemplate, BatchName) then
            if Batch.Get(BatchTemplate, BatchName) then
                GenJnlManagement.TemplateSelectionFromBatch(Batch);
    end;

    trigger OnPreReport()
    begin
        PostingPeriod := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        Payperiodtext := Format(PostingPeriod, 0, '<Month Text,3> <Year4>');
        GetPeriodFilter := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        DateSpecified := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");

        //  if not PayrollMgt.CheckIfPayrollApproved(DateSpecified) then
        //    Error('%1 Payroll period needs to be approved first before transfering to journal', DateSpecified);

        if PayrollPeriod.Get(DateSpecified) then
            Payday := PayrollPeriod."Pay Date";

        if Payday = 0D then
            Message(Text002, DateSpecified);

        LineNumber := 0;
        TotalCount := 0;
        Counter := 0;

        GetCurrentPeriod();

        if PeriodStartDate <> PayrollPeriod."Starting Date" then
            if not Confirm(Text001, false) then
                CurrReport.Quit();

        AdjustPostingGr();

        Window.Open('Generating Entries: #1###############' +
                    'Progress : @2@@@@@@@@@@@@@@@');

        Window.Update(1, Payperiodtext);

        HRSetup.Get();
        HRSetup.TestField("Payroll Journal Template");
        HRSetup.TestField("Payroll Journal Batch");

        BatchTemplate := HRSetup."Payroll Journal Template";
        BatchName := HRSetup."Payroll Journal Batch";

        /*
        HRSetup.Get();
        HRSetup.TestField("Payroll Journal Template");
        case HRSetup."Generate Payroll Batch" of
          HRSetup."Generate Payroll Batch"::" ",
          HRSetup."Generate Payroll Batch"::Yes:
            begin
              JName := 'PAY';
              MonDate := Format(PeriodStartDate);
              JName := JName + CopyStr(MonDate,3,7);
            end;
          HRSetup."Generate Payroll Batch"::No:
            begin
              HRSetup.TestField("Payroll Journal Batch");
              JName := HRSetup."Payroll Journal Batch";
            end;
        end;
        */

        //Delete Journal Entries
        Batch.Init();
        Batch."Journal Template Name" := BatchTemplate;
        Batch.Name := BatchName;
        if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
            Batch.Insert();

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", BatchTemplate);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll();

    end;

    var
        AssignmentMat: Record "Assignment Matrix";
        EmpRec: Record Employee;
        Batch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        HRSetup: Record "Human Resources Setup";
        Loanproduct: Record "Loan Product Type-Payroll";
        LoanApp: Record "Payroll Loan Application";
        PayrollPeriod: Record "Payroll Period";
        GenJnlManagement: Codeunit GenJnlManagement;
        PayrollMgt: Codeunit Payroll;
        TransferLoans: Boolean;
        TaxCode: Code[10];
        BatchTemplate: Code[20];
        PayablesAcc: Code[20];
        DateSpecified: Date;
        GetPeriodFilter: Date;
        Payday: Date;
        PeriodStartDate: Date;
        PostingPeriod: Date;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        TotalBasic: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;
        GrossAmout: Decimal;
        Totalgross: Decimal;
        TotalncomeTax: Decimal;
        TotalNetPay: Decimal;
        TotalSSF: Decimal;
        Window: Dialog;
        PayablesAccType: Enum "Gen. Journal Account Type";
        Counter: Integer;
        LastFieldNo: Integer;
        LineNumber: Integer;
        TotalCount: Integer;
        Net_PayCaptionLbl: Label 'Net Pay';
        Payroll_Journal_summary_reportCaptionLbl: Label 'Payroll Journal summary report';
        Text001: Label 'You are about to transfer the payroll summary for the wrong period, you want to continue?';
        Text002: Label 'The pay date must be specified for the period %1';
        BatchName: Text[30];
        Payperiodtext: Text[30];
        EmpName: Text[70];
        AppTimeSheet: Record "Employee Working  Line";

    procedure AdjustPostingGr()
    begin
        AssignmentMat.Reset();
        AssignmentMat.SetRange("Payroll Period", DateSpecified);
        if AssignmentMat.Find('-') then
            repeat
                if EmpRec.Get(AssignmentMat."Employee No") then
                    AssignmentMat."Posting Group Filter" := EmpRec."Posting Group";
                AssignmentMat.Modify();
            until AssignmentMat.Next() = 0;
    end;

    procedure GetCurrentPeriod()
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.SetRange(PayPeriodRec.Closed, false);
        if PayPeriodRec.Find('-') then
            PeriodStartDate := PayPeriodRec."Starting Date";
    end;

    procedure GetPayPeriod(var PayPeriods: Record "Payroll Period")
    begin
        PayrollPeriod := PayPeriods;
    end;

    procedure GetPayPeriodLoanInterestDocNo(CustomerNo: Code[50]; PayPeriod: Date): Code[100]
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", CustomerNo);
        CustLedgEntry.SetRange("Period Reference", PayPeriod);
        CustLedgEntry.SetRange("Payroll Loan Transaction Type", CustLedgEntry."Payroll Loan Transaction Type"::"Interest Due");
        CustLedgEntry.SetRange(Reversed, false);
        if CustLedgEntry.FindFirst() then
            exit(CustLedgEntry."Document No.");
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Brackets";
        EndTax: Boolean;
        Tax: Decimal;
        TotalTax: Decimal;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := PayrollRounding(AmountRemaining);
        EndTax := false;

        TaxTable.SetRange("Table Code", TaxCode);

        if TaxTable.Find('-') then
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if (TaxableAmount) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next() = 0) or EndTax = true;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax?" then
            IncomeTax := 0;
    end;

    procedure IsGratuity(Earn: Code[30]): Boolean
    begin


    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin

        HRsetup.Get();
        if HRsetup."Payroll Rounding Precision" = 0 then
            Error('You must specify the rounding precision under HR setup');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    local procedure GetGratuityVendorNo(StaffNo: Code[50]): Code[100]
    var
        Emp: Record Employee;
    begin
        if Emp.Get(StaffNo) then
            if Emp."Gratuity Vendor No." <> '' then
                exit(Emp."Gratuity Vendor No.");
        //else
        //      Message('Kindly define Gratuity Vendor No. for StaffNo %1 in the Employee Card', StaffNo);
    end;

    local procedure InsertedinJournal(GenTemplate: Code[50]; GenBatch: Code[50]; EmpCode: Code[50]; DatePeriod: Date; Amt: Decimal; DocNo: Code[50]; DedCode: Code[50]): Boolean
    var
        GenJournal: Record "Gen. Journal Line";
    begin
        GenJournal.Reset();
        GenJournal.SetRange("Journal Template Name", GenTemplate);
        GenJournal.SetRange("Journal Batch Name", GenBatch);
        GenJournal.SetRange("Document No.", DocNo);
        GenJournal.SetRange("Employee Code", EmpCode);
        GenJournal.SetRange("Emp Payroll Period", DatePeriod);
        GenJournal.SetRange("Emp Payroll Code", DedCode);
        if GenJournal.FindFirst() then
            exit(true)
        else
            exit(false)
    end;
}





