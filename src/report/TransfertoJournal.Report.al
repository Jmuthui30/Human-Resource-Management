report 52045 "Transfer to Journal"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Transfer to Journal';
    dataset
    {
        dataitem(Employees; Employee)
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                /*if Employees."Posting Group"<>EmpGroup then
                CurrReport.Skip();*/
                HRSetup.Get();
                Employees.TestField("Posting Group");

                TotalDebits := 0;
                TotalCredits := 0;
                TotalInterest := 0;
                BankCharges := 0;

                PayrollPeriod.Reset();
                PayrollPeriod.SetRange("Starting Date", Datefilter);
                if PayrollPeriod.Find('-') then
                    //PayrollPeriod.TESTFIELD("Pay Date");
                    Payday := PayrollPeriod."Starting Date";
                BankCharges := PayrollPeriod."Bank Charges";
                //  Message('bank is %1', BankCharges);
                Earn.Reset();
                Earn.SetRange("Reduces Tax", false);
                Earn.SetFilter("Account No.", '<>%1', '');
                Earn.SetRange("Non-Cash Benefit", false);
                if Earn.Find('-') then
                    repeat
                        if Earn."Basic Salary Code" = true then begin
                            PostingGroup.Reset();
                            PostingGroup.SetRange(PostingGroup.Code, Employees."Posting Group");
                            if PostingGroup.Find('-') then begin
                                AssignMatrix.Reset();
                                AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Earning);
                                AssignMatrix.SetRange(Code, Earn.Code);
                                AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                                AssignMatrix.SetRange("Payroll Period", Datefilter);
                                if AssignMatrix.Find('-') then begin
                                    AssignMatrix.CalcSums(Amount);
                                    GenJnline.Init();
                                    LineNumber := LineNumber + 10;
                                    //GenJnline."Journal Template Name":='GENERAL';
                                    GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                    GenJnline."Journal Batch Name" := JName;
                                    GenJnline."Line No." := GenJnline."Line No." + 10000;
                                    //IF PGMapping.GET("Employee Posting GroupX1".Code,Earnings1.Code,0) THEN
                                    PostingGroup.TestField("Salary Account");
                                    GenJnline."Account No." := PostingGroup."Salary Account";
                                    //GenJnline.VALIDATE("Account No.");
                                    GenJnline."Posting Date" := Payday;
                                    GenJnline.Description := Earn.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                    GenJnline."Document No." := Noseries;
                                    GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                    GenJnline.Validate("Shortcut Dimension 1 Code");
                                    GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                    GenJnline.Validate("Shortcut Dimension 2 Code");
                                    // GenJnline."Currency Code" := Employees."Currency Code";
                                    GenJnline.Validate("Currency Code");
                                    if Employees."Pay Mode" = 'BANK_INTERNAL' then
                                        GenJnline.Amount := (AssignMatrix.Amount + BankCharges)
                                    else
                                        GenJnline.Amount := (AssignMatrix.Amount);
                                    GenJnline.Validate(Amount);
                                    GenJnline."Employee Code" := AssignMatrix."Employee No";
                                    TotalDebits := TotalDebits + AssignMatrix.Amount;
                                    GenJnline."Gen. Bus. Posting Group" := '';
                                    GenJnline."Gen. Prod. Posting Group" := '';
                                    GenJnline."VAT Bus. Posting Group" := '';
                                    GenJnline."Emp Payroll Period" := Payday;
                                    if GenJnline.Amount <> 0 then
                                        GenJnline.Insert();
                                end;
                            end;
                        end;
                        //*****************************************************bank Charge
                        if Employees."Pay Mode" = 'BANK_INTERNAL' then begin
                            GenJnline.Init();
                            LineNumber := LineNumber + 10;
                            //GenJnline."Journal Template Name":='GENERAL';
                            GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                            GenJnline."Journal Batch Name" := JName;
                            GenJnline."Line No." := GenJnline."Line No." + 10000;
                            GenJnline."Account Type" := GenJnline."Account Type"::"G/L Account";
                            Earn.TestField("Account No.");
                            GenJnline."Account No." := HRSetup."Bank Charges Account";
                            //GenJnline.VALIDATE("Account No.");
                            GenJnline."Posting Date" := Payday;
                            GenJnline.Description := 'Bank Charge' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                            GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                            GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                            //  GenJnline."Currency Code" := Employees."Currency Code";
                            GenJnline.Validate("Currency Code");
                            GenJnline."Document No." := Noseries;
                            GenJnline.Amount := -BankCharges;
                            GenJnline.Validate(Amount);
                            GenJnline.Validate("Shortcut Dimension 1 Code");
                            GenJnline.Validate("Shortcut Dimension 2 Code");
                            GenJnline."Employee Code" := AssignMatrix."Employee No";
                            TotalDebits := TotalDebits + AssignMatrix.Amount;
                            GenJnline."Gen. Bus. Posting Group" := '';
                            GenJnline."Gen. Prod. Posting Group" := '';
                            GenJnline."VAT Bus. Posting Group" := '';
                            GenJnline."Emp Payroll Period" := Payday;
                            if GenJnline.Amount <> 0 then
                                GenJnline.Insert();
                        end;

                        //**********************************************************************Bank charges
                        if Earn."Basic Salary Code" = false then begin
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Earning);
                            AssignMatrix.SetRange(Code, Earn.Code);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                            AssignMatrix.SetRange("Payroll Period", Datefilter);
                            if AssignMatrix.Find('-') then begin
                                AssignMatrix.CalcSums(Amount);
                                GenJnline.Init();
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Earn."Account Type";
                                Earn.TestField("Account No.");
                                GenJnline."Account No." := Earn."Account No.";
                                //GenJnline.VALIDATE("Account No.");
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Earn.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                //  GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := (AssignMatrix.Amount);
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                TotalDebits := TotalDebits + AssignMatrix.Amount;
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                if GenJnline.Amount <> 0 then
                                    GenJnline.Insert();
                            end;
                        end;
                    until Earn.Next() = 0;


                //Deductions
                Ded.Reset();
                Ded.SetFilter("Account No.", '<>%1', '');
                if Ded.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SetRange(Code, Ded.Code);
                        //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                        AssignMatrix.SetRange("Payroll Period", Datefilter);
                        if AssignMatrix.Find('-') then begin
                            AssignMatrix.CalcSums(Amount);
                            if Ded."Customer Entry" = false then begin
                                GenJnline.Init();
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Ded."Account Type";
                                GenJnline."Account No." := Ded."Account No.";
                                GenJnline.Validate("Account No.");
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                //   GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := (AssignMatrix.Amount);
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then
                                    GenJnline.Insert();
                            end;

                            if Ded."Customer Entry" = true then begin
                                GenJnline.Init();
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := GenJnline."Account Type"::Customer;
                                Employees.TestField("Debtor Code");
                                GenJnline."Account No." := Employees."Debtor Code";
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                // GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
                                GenJnline.Amount := (AssignMatrix.Amount);//*(Allocation.Percentage/100));
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                //            IF Ded.Loan THEN BEGIN
                                //              GenJnline."Applies-to Doc. No.":=AssignMatrix."Reference No";
                                //              GenJnline.VALIDATE("Applies-to Doc. No.");
                                //            END;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then
                                    GenJnline.Insert();

                                //Insert Interest Entry
                                if Ded.Loan then begin
                                    LoanProductType.Reset();
                                    LoanProductType.SetRange("Deduction Code", Ded.Code);
                                    if LoanProductType.FindFirst() then
                                        if Ded2.Get(LoanProductType."Interest Deduction Code") then
                                            if AssignMatrix."Loan Interest" <> 0 then begin
                                                TotalInterest := TotalInterest + Abs(AssignMatrix."Loan Interest");
                                                GenJnline.Init();
                                                LineNumber := LineNumber + 10;
                                                //GenJnline."Journal Template Name":='GENERAL';
                                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                                GenJnline."Journal Batch Name" := JName;
                                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                                GenJnline."Account Type" := GenJnline."Account Type"::"G/L Account";
                                                Employees.TestField("Debtor Code");
                                                GenJnline."Account No." := Ded2."Account No.";
                                                GenJnline."Posting Date" := Payday;
                                                GenJnline.Description := Ded2.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                                //  GenJnline."Currency Code" := Employees."Currency Code";
                                                GenJnline.Validate("Currency Code");
                                                GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
                                                GenJnline.Amount := AssignMatrix."Loan Interest"; //*(Allocation.Percentage/100));
                                                GenJnline.Validate(Amount);
                                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                                GenJnline."External Document No." := AssignMatrix."Reference No";
                                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                                GenJnline."Gen. Bus. Posting Group" := '';
                                                GenJnline."Gen. Prod. Posting Group" := '';
                                                GenJnline."VAT Bus. Posting Group" := '';
                                                GenJnline."Emp Payroll Period" := Payday;
                                                if GenJnline.Amount <> 0 then
                                                    GenJnline.Insert();
                                            end;
                                end;
                            end;

                            // if AssignMatrix."Employer Amount" <> 0 then begin
                            //     GenJnline.Init();
                            //     LineNumber := LineNumber + 10;
                            //     //GenJnline."Journal Template Name":='GENERAL';
                            //     GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                            //     GenJnline."Journal Batch Name" := JName;
                            //     GenJnline."Line No." := GenJnline."Line No." + 10000;
                            //     GenJnline."Account Type" := Ded."Account Type Employer";
                            //     GenJnline."Account No." := Ded."Account No. Employer";
                            //     GenJnline."Posting Date" := Payday;
                            //     GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                            //     GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                            //     GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                            //     //GenJnline."Currency Code" := Employees."Currency Code";
                            //     GenJnline.Validate("Currency Code");
                            //     GenJnline."Document No." := Noseries;
                            //     GenJnline.Amount := (AssignMatrix."Employer Amount");
                            //     GenJnline.Validate(Amount);
                            //     GenJnline.Validate("Shortcut Dimension 1 Code");
                            //     GenJnline.Validate("Shortcut Dimension 2 Code");
                            //     GenJnline."Employee Code" := AssignMatrix."Employee No";
                            //     TotalCredits := TotalCredits + AssignMatrix.Amount;
                            //     GenJnline."Gen. Bus. Posting Group" := '';
                            //     GenJnline."Gen. Prod. Posting Group" := '';
                            //     GenJnline."VAT Bus. Posting Group" := '';
                            //     GenJnline."Emp Payroll Period" := Payday;
                            //     if GenJnline.Amount <> 0 then
                            //         GenJnline.Insert();
                            // end;

                            if AssignMatrix."Employer Amount" <> 0 then begin
                                GenJnline.Init();
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                GenJnline."Account Type" := Ded."Account Type";
                                GenJnline."Account No." := Ded."Account No.";
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                //  GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := -(AssignMatrix."Employer Amount");
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then
                                    GenJnline.Insert();
                            end;
                        end;
                    until Ded.Next() = 0;
                ///**********************************************************************************************************************

                Ded.Reset();
                Ded.SetFilter(Ded."Account No. Employer", '<>%1', '');
                Ded.SetRange(Ded."Tax deductible", false);
                if Ded.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SetRange(Code, Ded.Code);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                        AssignMatrix.SetRange("Payroll Period", Datefilter);
                        if AssignMatrix.Find('-') then begin
                            // if AssignMatrix."Employer Amount" <> 0 then begin
                            //     GenJnline.Init();
                            //     LineNumber := LineNumber + 10;
                            //     //GenJnline."Journal Template Name":='GENERAL';
                            //     GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                            //     GenJnline."Journal Batch Name" := JName;
                            //     GenJnline."Line No." := GenJnline."Line No." + 10000;
                            //     GenJnline."Account Type" := Ded."Account Type Employer";
                            //     GenJnline."Account No." := Ded."Account No. Employer";
                            //     GenJnline."Posting Date" := Payday;
                            //     GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                            //     GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                            //     GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                            //     //GenJnline."Currency Code" := Employees."Currency Code";
                            //     GenJnline.Validate("Currency Code");
                            //     GenJnline."Document No." := Noseries;
                            //     GenJnline.Amount := (AssignMatrix."Employer Amount");
                            //     GenJnline.Validate(Amount);
                            //     GenJnline.Validate("Shortcut Dimension 1 Code");
                            //     GenJnline.Validate("Shortcut Dimension 2 Code");
                            //     GenJnline."Employee Code" := AssignMatrix."Employee No";
                            //     TotalCredits := TotalCredits + AssignMatrix.Amount;
                            //     GenJnline."Gen. Bus. Posting Group" := '';
                            //     GenJnline."Gen. Prod. Posting Group" := '';
                            //     GenJnline."VAT Bus. Posting Group" := '';
                            //     GenJnline."Emp Payroll Period" := Payday;
                            //     if GenJnline.Amount <> 0 then
                            //         GenJnline.Insert();
                            // end;

                            if AssignMatrix."Employer Amount" <> 0 then begin
                                GenJnline.Init();
                                LineNumber := LineNumber + 10;
                                //GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                                GenJnline."Journal Batch Name" := JName;
                                GenJnline."Line No." := GenJnline."Line No." + 10000;
                                // GenJnline."Account Type" := Ded."Account Type";
                                // GenJnline."Account No." := Ded."Account No.";

                                GenJnline."Account Type" := Ded."Account Type Employer";
                                GenJnline."Account No." := Ded."Account No. Employer";
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Ded.Description + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                                GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                                GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                                //  GenJnline."Currency Code" := Employees."Currency Code";
                                GenJnline.Validate("Currency Code");
                                GenJnline."Document No." := Noseries;
                                GenJnline.Amount := -(AssignMatrix."Employer Amount");
                                GenJnline.Validate(Amount);
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline."Employee Code" := AssignMatrix."Employee No";
                                GenJnline."Gen. Bus. Posting Group" := '';
                                GenJnline."Gen. Prod. Posting Group" := '';
                                GenJnline."VAT Bus. Posting Group" := '';
                                GenJnline."Emp Payroll Period" := Payday;
                                TotalCredits := TotalCredits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then
                                    GenJnline.Insert();
                            end;
                        end;
                    until Ded.Next() = 0;
                //  Message('  TotalCredits %1 ', TotalCredits);
                Ded.Reset();
                Ded.SetFilter(Ded."Account No. Employer", '<>%1', '');

                if Ded.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SetRange(Code, Ded.Code);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employees."No.");
                        AssignMatrix.SetRange("Payroll Period", Datefilter);
                        if AssignMatrix.Find('-') then
                            if AssignMatrix."Employer Amount" <> 0 then
                                TotalDeduAmount := TotalDeduAmount + AssignMatrix."Employer Amount";
                    until Ded.Next() = 0;
                //        Message('   TotalDeduAmount%1 ', TotalDeduAmount);
                PostingGroup.Reset();
                PostingGroup.SetRange(PostingGroup.Code, Employees."Posting Group");
                if PostingGroup.Find('-') then begin
                    GenJnline.Init();
                    LineNumber := LineNumber + 10;
                    //GenJnline."Journal Template Name":='GENERAL';
                    GenJnline."Journal Template Name" := HRSetup."Payroll Journal Template";
                    GenJnline."Journal Batch Name" := JName;
                    GenJnline."Line No." := GenJnline."Line No." + 10000;
                    GenJnline."Account Type" := PostingGroup."Net Salary Account Type";
                    GenJnline."Account No." := PostingGroup."Net Salary Payable";
                    GenJnline."Posting Date" := Payday;
                    GenJnline.Description := 'Net Pay' + ' ' + Format(Datefilter, 0, '<month text> <year4>') + ' ' + Employees."No." + '-' + Employees."First Name";
                    GenJnline."Shortcut Dimension 1 Code" := Employees."Global Dimension 1 Code";
                    GenJnline.Validate("Shortcut Dimension 1 Code");
                    GenJnline."Shortcut Dimension 2 Code" := Employees."Global Dimension 2 Code";
                    GenJnline.Validate("Shortcut Dimension 2 Code");
                    //  GenJnline."Currency Code" := Employees."Currency Code";
                    GenJnline.Validate("Currency Code");
                    GenJnline."Document No." := Noseries;
                    EmpRec.Reset();
                    EmpRec.SetRange(EmpRec."No.", Employees."No.");
                    EmpRec.SetRange(EmpRec."Pay Period Filter", AssignMatrix."Payroll Period");
                    if EmpRec.Find('-') then
                        EmpRec.CalcFields(EmpRec."Net Pay", EmpRec."Basic Pay");
                    GenJnline.Amount := -(EmpRec."Basic Pay" + TotalDeduAmount); //Modified to include loan interest
                    GenJnline.Validate(Amount);
                    GenJnline."Employee Code" := AssignMatrix."Employee No";
                    GenJnline."Gen. Bus. Posting Group" := '';
                    GenJnline."Gen. Prod. Posting Group" := '';
                    GenJnline."VAT Bus. Posting Group" := '';
                    GenJnline."Emp Payroll Period" := Payday;
                    TotalCredits := TotalCredits + AssignMatrix.Amount;
                    if GenJnline.Amount <> 0 then
                        GenJnline.Insert();
                end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Payroll Period"; Datefilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Datefilter field';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PayrollPeriod.Reset();
                        if Page.RunModal(Page::"Pay Period", PayrollPeriod) = Action::LookupOK then
                            Datefilter := PayrollPeriod."Starting Date";
                    end;
                }
                field(EmpGroup; EmpGroup)
                {
                    Caption = 'Posting Group';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Group field';
                }
            }
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnInitReport()
    begin
        //EVALUATE(Datefilter,'10012013');
    end;

    trigger OnPostReport()
    begin
        Message('Successfully transfered to %1 Journal %2 Batch', HRSetup."Payroll Journal Template", JName);
    end;

    trigger OnPreReport()
    begin
        HRSetup.Get();
        HRSetup.TestField("Payroll Journal Template");
        //HRSetup.TESTFIELD("Payroll Journal No.");
        //HRSetup.TESTFIELD("Payroll Journal Batch");

        //JName:=COPYSTR(EmpGroup,1,3);
        JName := 'PAY';
        MonDate := Format(Datefilter);
        JName := JName + CopyStr(MonDate, 3, 7);


        GenJnline.Reset();
        //GenJnline.SETRANGE("Journal Template Name",'GENERAL');
        GenJnline.SetRange("Journal Template Name", HRSetup."Payroll Journal Template");
        GenJnline.SetRange("Journal Batch Name", JName);
        GenJnline.DeleteAll();

        /*
        GenJnlBatch.Reset();
        GenJnlBatch.SetRange(Name,JName);
        if not GenJnlBatch.Find('-') then
          begin
            GenJnlBatch.Init();
            GenJnlBatch."Journal Template Name":=HRSetup."Payroll Journal Template";
            GenJnlBatch.Name:=JName;
            GenJnlBatch.Description:=EmpGroup+' '+Format(Datefilter,0,'<month text> <year4>');
            GenJnlBatch.Insert();
         end;
        */

        GenJnlBatch.Reset();
        GenJnlBatch.Init();
        GenJnlBatch."Journal Template Name" := HRSetup."Payroll Journal Template";
        GenJnlBatch.Name := JName;
        //GenJnlBatch.Description:=EmpGroup+' '+FORMAT(Datefilter,0,'<month text> <year4>');
        GenJnlBatch.Description := 'Payroll ' + Format(Datefilter, 0, '<month text> <year4>');
        if not GenJnlBatch.Get(HRSetup."Payroll Journal Template", JName) then
            GenJnlBatch.Insert();


        GenJnlBatch.Reset();
        GenJnlBatch.SetRange(Name, JName);
        if GenJnlBatch.Find('-') then
            //Noseries:=NoSeriesMgt.GetNextNo('JOURNAL',TODAY,TRUE);
            Noseries := NoSeriesMgt.GetNextNo(HRSetup."Payroll Journal No.", Today, true);

    end;

    var
        TotalDeduAmount: Decimal;
        AssignMatrix: Record "Assignment Matrix";
        Ded: Record Deductions;
        Ded2: Record Deductions;
        Earn: Record Earnings;
        EmpRec: Record Employee;
        PostingGroup: Record "Employee HR Posting Group";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnline: Record "Gen. Journal Line";
        HRSetup: Record "Human Resources Setup";
        LoanProductType: Record "Loan Product Type-Payroll";
        PayrollPeriod: Record "Payroll Period";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpGroup: Code[10];
        TaxCode: Code[10];
        Noseries: Code[50];
        Datefilter: Date;
        Payday: Date;
        PeriodStartDate: Date;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;
        TotalInterest: Decimal;
        LineNumber: Integer;
        JName: Text[10];
        MonDate: Text[10];
        BankCharges: Decimal;

    procedure AdjustPostingGr()
    begin
        if AssignMatrix.Find('-') then
            repeat
                if EmpRec.Get(AssignMatrix."Employee No") then
                    AssignMatrix."Posting Group Filter" := EmpRec."Posting Group";
                AssignMatrix.Modify();
            until AssignMatrix.Next() = 0;
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

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Brackets";
        Employee: Record Employee;
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
}





