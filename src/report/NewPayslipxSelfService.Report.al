report 52067 "New Payslipx-Self Service"
{
    ApplicationArea = All;
    Caption = 'My Payslip';
    // ArrEarnings[1,1]
    // ArrEarningsAmt[1,1]
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/NewPayslipxSelfService.rdl';


    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.");
            column(Addr_1__1_; Addr[1] [1])
            {
            }
            column(Addr_1__2_; Addr[1] [2])
            {
            }
            column(Addr_1__3_; Addr[1] [3])
            {
            }
            column(Addr_1__4_; Addr[1] [4])
            {
            }
            column(Addr_1__5_; Addr[1] [5])
            {
            }
            column(Addr_1__6_; Addr[1] [6])
            {
            }
            column(DeptArr_1_1_; DeptArr[1, 1])
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(CoRec_Picture; CompInfo.Picture)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompEmail; CompInfo."E-Mail")
            {
            }
            column(Message2_1_1_; Message2[1, 1])
            {
            }
            column(Message1; Message1)
            {
            }
            column(STRSUBSTNO__Date__1__2__TODAY_TIME_; StrSubstNo('Date %1 %2', Today, Time))
            {
            }
            column(USERID; UserId)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            } */
            column(EarningsCaption; EarningsCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Dept_Caption; Dept_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Pay_slipCaption; Pay_slipCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            column(BalanceCaption; Balance_CaptionLbl)
            {
            }
            column(BPayCaptionLbl; BPayCaptionLbl)
            {
            }
            column(General_Payslip_Message; HRSetup."General Payslip Message")
            {

            }

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(BalanceArray_1_Number_; BalanceArray[1, Number])
                {
                }
                column(ArrEarnings_1_Number_; ArrEarnings[1, Number])
                {
                }
                column(ArrEarningsAmt_1_Number_; ArrEarningsAmt[1, Number])
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin

                    Integer.SetRange(Number, 1, i);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Pickup Logo
                // IF Employee.Company<>''  THEN
                // CompInfo.CHANGECOMPANY(Employee.Company);
                // CompInfo.GET;
                // CompInfo.CALCFIELDS(Picture);
                //
                //Employee.Reset();
                Clear(Addr);
                Clear(DeptArr);
                Clear(BasicPay);
                Clear(EmpArray);
                Clear(ArrEarnings);
                Clear(ArrEarningsAmt);
                Clear(BalanceArray);
                Clear(ArrHeadings);
                Clear(BalanceArrayAmt);
                GrossPay := 0;
                TotalDeduction := 0;
                Totalcoopshares := 0;
                Totalnssf := 0;
                NetPay := 0;
                i := 1;
                j := 1;

                CalcFields("Total Allowances", "Total Deductions");
                if Employee."Total Allowances" = 0 then
                    CurrReport.Skip();

                Addr[1] [1] := Employee."No.";
                Addr[1] [2] := Employee.FullName();
                //MESSAGE(Addr[1][2]);
                Addr[1] [3] := Employee."Date of Birth - Age";
                Addr[1] [4] := Format(Employee."Birth Date");
                Addr[1] [5] := Format(Employee."Salary Scale");
                Employee.CalcFields("Job Position Title");
                Addr[1] [6] := Format(Employee."Job Position Title");
                // get Department Name
                DeptArr[1, 1] := Employee."Responsibility Center";

                //DimVal.Reset();
                //DimVal.SetRange(DimVal.Code, Employee."Global Dimension 1 Code");
                //if DimVal.Find('-') then
                //DeptArr[1, 1] := DimVal.Name;


                /*// Earnings
                ArrEarnings[1,i]:='EARNINGS';
                j:=j+1;
                ArrHeadings[i]:=j;
                i:=i+1;*/

                //Get Basic Pay
                Earn.Reset();
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SetRange(Earn."Non-Cash Benefit", false);
                Earn.SetRange(Earn."Basic Salary Code", true);
                if Earn.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SetRange(Code, Earn.Code);
                        if AssignMatrix.Find('-') then
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                GrossPay := GrossPay + AssignMatrix.Amount;
                                i := i + 1;
                            until AssignMatrix.Next() = 0;
                    until Earn.Next() = 0;

                // Get Other Earnings
                Earn.Reset();
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SetRange(Earn."Non-Cash Benefit", false);
                Earn.SetRange(Earn."Basic Salary Code", false);
                Earn.SetRange(Gratuity, false);
                if Earn.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SetRange(Code, Earn.Code);
                        if AssignMatrix.Find('-') then
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                GrossPay := GrossPay + AssignMatrix.Amount;
                                i := i + 1;
                            until AssignMatrix.Next() = 0;
                    until Earn.Next() = 0;

                // Gross Pay
                ArrEarnings[1, i] := 'GROSS PAY';
                j := j + 1;
                ArrHeadings[i] := j;
                i := i + 1;

                ArrEarnings[1, i] := 'Gross Pay';
                Evaluate(ArrEarningsAmt[1, i], Format(GrossPay));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                j := j + 1;
                ArrHeadings[i] := j;
                i := i + 1;


                // taxations
                ArrEarnings[1, i] := 'TAX CALCULATIONS';
                j := j + 1;
                ArrHeadings[i] := j;
                /*
                i:=i+1;

                ArrEarnings[1,i]:=' ';
                ArrEarningsAmt[1,i]:=' ';
                j:=j+1;
                ArrHeadings[i]:=j;
                */

                i := i + 1;
                // Non Cash Benefits
                Earn.Reset();
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SetRange(Earn."Non-Cash Benefit", true);
                if Earn.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SetRange(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SetRange(Code, Earn.Code);
                        if AssignMatrix.Find('-') then
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.Next() = 0;
                    until Earn.Next() = 0;

                // end of non cash
                AssignMatrix.Reset();
                AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SetRange(AssignMatrix.Paye, true);
                if AssignMatrix.Find('-') then begin
                    ArrEarnings[1, i] := 'Pension contribution benefit';
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Less Pension Contribution")));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);


                    TaxableAmt := 0;
                    PAYE := 0;

                    TaxableAmt := AssignMatrix."Taxable amount";
                    PAYE := AssignMatrix.Amount;

                end;

                i := i + 1;
                // Taxable amount
                ArrEarnings[1, i] := 'Taxable Pay';
                if Employee."Secondary Employee" then
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(GrossPay)))
                else
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(TaxableAmt)));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                if PAYE > 0 then begin
                    i := i + 1;

                    ArrEarnings[1, i] := 'Tax Charged';
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(PAYE) + GetTaxRelief()));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                end;
                i := i + 1;

                // Relief
                Earn.Reset();
                Earn.SetFilter(Earn."Earning Type", '%1|%2|%3|%4|%5', Earn."Earning Type"::"Tax Relief",
                Earn."Earning Type"::"Insurance Relief", Earn."Earning Type"::"Owner Occupier",
                Earn."Earning Type"::"NHIF Relief", Earn."Earning Type"::"Housing Levy Relief");
                if Earn.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SetRange(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SetRange(Code, Earn.Code);
                        if AssignMatrix.Find('-') then
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.Next() = 0;
                    until Earn.Next() = 0;

                /*// Statutories
                ArrEarnings[1,i]:='STATUTORIES';
                j:=j+1;
                ArrHeadings[i]:=j;
                i:=i+1;

                DeductsRec.RESET;
                DeductsRec.SETRANGE(DeductsRec.Statutories,TRUE);
                IF DeductsRec.FIND('-') THEN BEGIN
                  REPEAT
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Code,DeductsRec.Code);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                      REPEAT
                        ArrEarnings[1,i]:=AssignMatrix.Description;
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                        ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                        TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                        i:=i+1;
                      UNTIL AssignMatrix.NEXT=0;
                    END;
                  UNTIL DeductsRec.NEXT=0;
                END;*/

                // Deductions
                ArrEarnings[1, i] := 'DEDUCTIONS';
                j := j + 1;
                ArrHeadings[i] := j;
                i := i + 1;

                DeductsRec.Reset();
                //DeductsRec.SETRANGE(Statutories,FALSE);
                if DeductsRec.Findset() then
                    repeat
                        //Loans
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SetFilter(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                        if AssignMatrix.FindSet() then
                            repeat
                                LoanBalances.Reset();
                                LoanBalances.SetRange("Loan No", AssignMatrix."Reference No");
                                LoanBalances.SetRange("Deduction Code", AssignMatrix.Code);
                                if LoanBalances.FindSet() then
                                    case LoanBalances."Interest Calculation Method" of
                                        LoanBalances."Interest Calculation Method"::"Sacco Reducing Balance",
                                        LoanBalances."Interest Calculation Method"::"Reducing Balance",
                                        LoanBalances."Interest Calculation Method"::"Flat Rate",
                                        LoanBalances."Interest Calculation Method"::Amortised:
                                            begin
                                                if Deduct.Get(AssignMatrix.Code) then
                                                    if Deduct."Show Balance" then begin
                                                        LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);

                                                        LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                                        BalanceArray[1, i] := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                                    end;

                                                //For Each Loan Show the interest amount separately:
                                                //Principal:
                                                ArrEarnings[1, i] := AssignMatrix.Description + '(' + AssignMatrix."Reference No" + ')';
                                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                                //Interest:
                                                i := i + 1;
                                                ArrEarnings[1, i] := AssignMatrix.Description + '-Interest';
                                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Loan Interest")));
                                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                                BalanceArray[1, i] := 0;

                                                //Don't show interest if it's zero
                                                if AssignMatrix."Loan Interest" = 0 then
                                                    i := i - 1;
                                            end;
                                        else begin

                                            if Deduct.Get(AssignMatrix.Code) then
                                                if Deduct."Show Balance" then begin
                                                    LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);

                                                    LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                                    BalanceArray[1, i] := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                                end;

                                            //Show Principal only:
                                            ArrEarnings[1, i] := AssignMatrix.Description;
                                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                        end;
                                    end
                                else begin
                                    if AssignMatrix."Reference No" <> '' then
                                        ArrEarnings[1, i] := AssignMatrix.Description + '(' + AssignMatrix."Reference No" + ')'
                                    else
                                        ArrEarnings[1, i] := AssignMatrix.Description;

                                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                end;
                                TotalDeduction := TotalDeduction + Abs(AssignMatrix.Amount) + Abs(AssignMatrix."Loan Interest");

                                if Deduct.Get(AssignMatrix.Code) then
                                    if Deduct."Show Balance" then begin
                                        LoanBalances.Reset();
                                        LoanBalances.SetRange(LoanBalances."Loan No", AssignMatrix."Reference No");
                                        LoanBalances.SetRange(LoanBalances."Deduction Code", AssignMatrix.Code);
                                        if LoanBalances.Find('-') then begin

                                            LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);

                                            LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                            case LoanBalances."Interest Calculation Method" of
                                                LoanBalances."Interest Calculation Method"::"Sacco Reducing Balance":
                                                    ;
                                                //i:=i-1;
                                                //BalanceArray[1,i]:=(LoanBalances."Approved Amount"+LoanBalances."Total Repayment"-ABS(LoanBalances.Receipts));
                                                //i:=1+1;
                                                else
                                            //BalanceArray[1,i]:=(LoanBalances."Approved Amount"+LoanBalances."Total Repayment"-ABS(LoanBalances.Receipts));
                                            end;
                                        end
                                        else begin
                                            Deduct.SetRange(Deduct."Employee Filter", Employee."No.");
                                            if (Deduct."Start date" <> 0D) and (Deduct."Start date" <= DateSpecified) then
                                                Deduct.SetRange(Deduct."Pay Period Filter", Deduct."Start date", DateSpecified)
                                            else
                                                Deduct.SetRange(Deduct."Pay Period Filter", DateSpecified);
                                            //Deduct.SetRange(Deduct."Pay Period Filter", 0D, DateSpecified);          //Share Top Up Added Below
                                            Deduct.SetRange("Reference Filter", AssignMatrix."Reference No");
                                            Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer", Deduct."Share Top Up");
                                            if not Deduct."Sacco Deduction" then
                                                BalanceArray[1, i] := (Abs(Deduct."Total Amount") + Abs(Deduct."Total Amount Employer") + Abs(Deduct."Share Top Up"));

                                            //Get balances using Opening Balance
                                            /*
                                            DeductionBalances.Reset();
                                            DeductionBalances.SetRange("Deduction Code", Deduct.Code);
                                            DeductionBalances.SetRange("Employee No", Employee."No.");
                                            DeductionBalances.SetRange("Loan No.", AssignMatrix."Reference No");
                                            if DeductionBalances.FindFirst() then begin
                                                if Deduct."Show Balance" then begin
                                                    case Deduct."Balance Type" of
                                                        Deduct."Balance Type"::Increasing:
                                                            begin
                                                                if Deduct."Exclude Employer Balance" then
                                                                    BalanceArray[1, i] := (DeductionBalances.Amount + Abs(Deduct."Total Amount") + Abs(Deduct."Share Top Up"))
                                                                else
                                                                    BalanceArray[1, i] := (DeductionBalances.Amount + Abs(Deduct."Total Amount") + Abs(Deduct."Total Amount Employer") + Abs(Deduct."Share Top Up"));
                                                            end;

                                                        Deduct."Balance Type"::Decreasing:
                                                            begin
                                                                if Deduct."Exclude Employer Balance" then
                                                                    BalanceArray[1, i] := DeductionBalances.Amount + Deduct."Total Amount" + Abs(Deduct."Share Top Up")
                                                                else
                                                                    BalanceArray[1, i] := DeductionBalances.Amount + Deduct."Total Amount" + Deduct."Total Amount Employer" + Abs(Deduct."Share Top Up");
                                                            end;
                                                    end;
                                                end;
                                            end;
                                            */
                                        end;
                                    end;
                                i := i + 1;
                            until AssignMatrix.Next() = 0;

                    until DeductsRec.Next() = 0;


                ArrEarnings[1, i] := 'TOTAL DEDUCTIONS';
                Evaluate(ArrEarningsAmt[1, i], Format(TotalDeduction));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                j := j + 1;
                ArrHeadings[i] := j;
                /*
                i:=i+1;

                ArrEarnings[1,i]:=' ';
                ArrEarningsAmt[1,i]:=' ';
                j:=j+1;
                ArrHeadings[i]:=j;
                */

                i := i + 1;

                // Net Pay
                ArrEarnings[1, i] := 'NET PAY';
                j := j + 1;
                ArrHeadings[i] := j;
                i := i + 1;

                ArrEarnings[1, i] := 'Net Pay';
                NetPay := GrossPay - TotalDeduction;
                Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                j := j + 1;
                ArrHeadings[i] := j;
                i := i + 1;

                /*//Employer Information
                ArrEarnings[1,i]:='Employer Info';
                j:=j+1;
                ArrHeadings[i]:=j;

                i:=i+1;
                Ded.RESET;
                Ded.SETRANGE(Ded."Tax deductible",TRUE);
                Ded.SETRANGE(Ded."Pay Period Filter",DateSpecified);
                Ded.SETRANGE(Ded."Employee Filter",Employee."No.");
                Ded.SETRANGE(Ded."Show on Payslip Information",TRUE);
                IF Ded.FIND('-') THEN
                REPEAT
                Ded.CALCFIELDS(Ded."Total Amount",Ded."Total Amount Employer");
                IF Ded."Total Amount Employer"<>0 THEN
                 BEGIN
                  ArrEarnings[1,i]:=Ded.Description+'(Employer)';
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Ded."Total Amount Employer")));
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                  i:=i+1;
                 END;
                 { ArrEarnings[1,i]:=Ded.Description;
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Ded."Total Amount")));
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                  i:=i+1;}
                UNTIL Ded.NEXT=0;
                */

                ArrEarnings[1, i] := 'Staff Information:';
                j := j + 1;
                ArrHeadings[i] := j;

                // Employee details
                /*
                i:=i+1;

                ArrEarnings[1,i]:=' ';
                ArrEarningsAmt[1,i]:=' ';
                j:=j+1;
                ArrHeadings[i]:=j;
                */


                /*
                i:=i+1;
                IF EmpBank.GET(Employee."Employee's Bank") THEN
                 BankName:=EmpBank.Name;

                ArrEarnings[1,i]:='Employee Bank';
                ArrEarningsAmt[1,i]:=BankName;

                i:=i+1;
                ArrEarnings[1,i]:='Bank Branch';
                IF EmpBankBranch.GET(Employee."Employee's Bank",Employee."Bank Branch") THEN
                ArrEarningsAmt[1,i]:=EmpBankBranch."Branch Name";

                i:=i+1;
                ArrEarnings[1,i]:='Bank Account Number';
                ArrEarningsAmt[1,i]:=Employee."Bank Account Number";

              */
                i := i + 1;
                ArrEarnings[1, i] := 'NSSF No';
                ArrEarningsAmt[1, i] := Employee."Social Security No.";
                i := i + 1;
                ArrEarnings[1, i] := 'NHIF No';
                ArrEarningsAmt[1, i] := Employee."NHIF No";
                i := i + 1;
                ArrEarnings[1, i] := 'Bank:';
                ArrEarningsAmt[1, i] := Employee."Employee Bank Name";
                i := i + 1;
                ArrEarnings[1, i] := 'Branch:';
                ArrEarningsAmt[1, i] := Employee."Employee Branch Name";
                i := i + 1;
                ArrEarnings[1, i] := 'Account No';
                ArrEarningsAmt[1, i] := Employee."Bank Account Number";
                i := i + 1;
                ArrEarnings[1, i] := 'P.I.N No';
                ArrEarningsAmt[1, i] := Employee."PIN Number";
                i := i + 1;
                ArrEarnings[1, i] := 'End of Payslip';

            end;

            trigger OnPreDataItem()
            var
                UserSetup: record "User Setup";
            begin
                if UserSetup.Get(UserId) then begin
                    UserSetup.TestField("Employee No.");
                    SetRange("No.", UserSetup."Employee No.");
                end else
                    Error('You have not been set up as a user. Kindly consult IT');

                // CompRec.GET;
                // //Message2[1,1]:=CompRec."General Payslip Message";
                //
                // CoRec.CALCFIELDS(Picture);
                /*
               CUser:=USERID;
               GetGroup.GetUserGroup(CUser,GroupCode);
               SETRANGE(Employee."Posting Group",GroupCode);
                */

            end;
        }

    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(RequestPayrollPeriod; RequestPayrollPeriod)
                {
                    Caption = 'Payroll Period';
                    TableRelation = "Payroll Period"."Starting Date";// where("Approval Status" = const(Approved));
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Period field';
                    ShowMandatory = true;
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

    trigger OnPreReport()
    begin

        PayPeriodtext := format(RequestPayrollPeriod);//Employee.GetFilter("Pay Period Filter");
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText := Format(PayrollMonth, 1, 4);

        if PayPeriodtext = '' then
            Error('Pay period must be specified for this report');
        CoRec.Get();
        CoName := CoRec.Name;
        //Evaluate(DateSpecified, Format(PayPeriodtext));

        DateSpecified := RequestPayrollPeriod;

        CompInfo.Get();
        CompInfo.CalcFields(Picture);

        HRSetup.Get();

    end;

    var
        AssignMatrix: Record "Assignment Matrix";
        CompInfo: Record "Company Information";
        CoRec: Record "Company Information";
        Deduct: Record Deductions;
        DeductsRec: Record Deductions;
        Earn: Record Earnings;
        HRSetup: Record "Human Resources Setup";
        LoanBalances: Record "Payroll Loan Application";
        DateSpecified: Date;
        PayrollMonth: Date;
        RequestPayrollPeriod: Date;
        BalanceArray: array[3, 100] of Decimal;
        BalanceArrayAmt: array[3, 100] of Decimal;
        EmpArray: array[10, 15] of Decimal;
        GrossPay: Decimal;
        NetPay: Decimal;
        PAYE: Decimal;
        TaxableAmt: Decimal;
        Totalcoopshares: Decimal;
        TotalDeduction: Decimal;
        Totalnssf: Decimal;
        ArrHeadings: array[100] of Integer;
        i: Integer;
        j: Integer;
        AmountCaptionLbl: Label 'AMOUNT';
        Balance_CaptionLbl: Label 'BALANCES';
        BPayCaptionLbl: Label 'BASIC SALARY';
        CurrReport_PAGENOCaptionLbl: Label 'Copy';
        Dept_CaptionLbl: Label 'Department:';
        EarningsCaptionLbl: Label 'EARNINGS';
        Employee_No_CaptionLbl: Label 'Employee No:';
        EmptyStringCaptionLbl: Label '**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************';
        Name_CaptionLbl: Label 'Name:';
        Pay_slipCaptionLbl: Label 'PAYSLIP';
        PayPeriodtext: Text[30];
        PayrollMonthText: Text[30];
        DeptArr: array[3, 1] of Text[60];
        Addr: array[10, 100] of Text[250];
        ArrEarnings: array[3, 100] of Text[250];
        ArrEarningsAmt: array[3, 100] of Text[250];
        BasicPay: array[3, 1] of Text[250];
        CoName: Text[250];
        Message1: Text[250];
        Message2: array[3, 1] of Text[250];


    procedure ChckRound(var AmtText: Text[30]) ChckRound: Text[30]
    var
        DecimalPos: Integer;
        Decimalstrlen: Integer;
        LenthOfText: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
    begin
        LenthOfText := StrLen(AmtText);
        DecimalPos := StrPos(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec := AmtText;
            DecimalAmt := '.00';
        end else begin
            AmtWithoutDec := CopyStr(AmtText, 1, DecimalPos - 1);
            DecimalAmt := CopyStr(AmtText, DecimalPos + 1, 2);
            Decimalstrlen := StrLen(DecimalAmt);
            if Decimalstrlen < 2 then
                DecimalAmt := '.' + DecimalAmt + '0'
            else
                DecimalAmt := '.' + DecimalAmt
        end;
        ChckRound := AmtWithoutDec + DecimalAmt;
    end;


    procedure CoinageAnalysis(var NetPay: Decimal; var ColNo: Integer)
    begin
    end;


    procedure GetPayPeriod()
    begin
    end;



    procedure GetTaxBracket(var TaxableAmount: Decimal)
    begin
    end;


    procedure GetTaxBracket1(var TaxableAmount: Decimal)
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

    local procedure GetTaxRelief(): Decimal
    var
        EarningRec: Record Earnings;
    begin
        EarningRec.Reset();
        EarningRec.SetRange("Earning Type", EarningRec."Earning Type"::"Tax Relief");
        EarningRec.SetFilter("Flat Amount", '<>%1', 0);
        if EarningRec.FindFirst() then
            exit(EarningRec."Flat Amount")
        else
            exit(0);
    end;
}













