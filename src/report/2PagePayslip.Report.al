report 52035 "2 Page Payslip"
{
    ApplicationArea = All;
    // ArrEarnings[1,1]
    // ArrEarningsAmt[1,1]
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/2PagePayslip.rdlc';
    Caption = '2 Page Payslip';
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "Pay Period Filter", "No.", "Global Dimension 1 Code";

            column(Addr_1__1_; Addr[1] [1])
            {
            }
            column(Addr_1__2_; Addr[1] [2])
            {
            }
            column(DeptArr_1_1_; DeptArr[1, 1])
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(Company_Name; CompanyName)
            {
            }
            column(CoRec_Picture; CompInfo.Picture)
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

                //Pick Logo
                if Employee.Company <> '' then
                    CompanyInfo.ChangeCompany(Employee.Company);
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                //



                Clear(Addr);
                Clear(DeptArr);
                Clear(BasicPay);
                Clear(EmpArray);
                Clear(ArrEarnings);
                Clear(ArrEarningsAmt);
                Clear(BalanceArray);
                Clear(ArrHeadings);
                GrossPay := 0;
                TotalDeduction := 0;
                Totalcoopshares := 0;
                Totalnssf := 0;
                NetPay := 0;
                i := 1;
                j := 1;

                Employee.CalcFields("Total Allowances", "Total Deductions");
                if Employee."Total Allowances" = 0 then
                    CurrReport.Skip();

                Addr[1] [1] := Employee."No.";
                Addr[1] [2] := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                //Get Department Name
                DimVal.Reset();
                DimVal.SetRange(Code, Employee."Global Dimension 1 Code");
                DimVal.SetRange("Global Dimension No.", 1);
                if DimVal.Find('-') then
                    DeptArr[1, 1] := DimVal.Name;

                //Get Earnings
                Earn.Reset();
                Earn.SetRange("Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SetRange("Non-Cash Benefit", false);
                if Earn.Find('-') then
                    repeat
                        AssignMatrix.Reset();
                        AssignMatrix.SetRange("Payroll Period", DateSpecified);
                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Earning);
                        AssignMatrix.SetRange("Employee No", Employee."No.");
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

                ArrEarnings[1, i] := 'GROSS PAY';
                Evaluate(ArrEarningsAmt[1, i], Format(GrossPay));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                j := j + 1;
                ArrHeadings[i] := j;
                i := i + 1;

                //Deductions
                ArrEarnings[1, i] := 'Deductions';
                j := j + 1;
                ArrHeadings[i] := j;

                i := i + 1;

                AssignMatrix.Reset();
                AssignMatrix.SetRange("Payroll Period", DateSpecified);
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SetRange("Employee No", Employee."No.");
                AssignMatrix.SetRange(Paye, true);
                if AssignMatrix.Find('-') then begin
                    ArrEarnings[1, i] := AssignMatrix.Description;
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                    TotalDeduction := TotalDeduction + Abs(AssignMatrix.Amount);
                end;
                i := i + 1;

                //Loans
                AssignMatrix.Reset();
                AssignMatrix.SetRange("Payroll Period", DateSpecified);
                AssignMatrix.SetFilter(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                AssignMatrix.SetRange("Employee No", Employee."No.");
                AssignMatrix.SetRange(Paye, false);
                if AssignMatrix.Find('-') then
                    repeat
                        LoanBalances.Reset();
                        LoanBalances.SetRange("Loan No", AssignMatrix."Reference No");
                        LoanBalances.SetRange("Deduction Code", AssignMatrix.Code);
                        if LoanBalances.Find('-') then
                            case LoanBalances."Interest Calculation Method" of
                                LoanBalances."Interest Calculation Method"::"Sacco Reducing Balance",
                                LoanBalances."Interest Calculation Method"::"Reducing Balance",
                                LoanBalances."Interest Calculation Method"::"Flat Rate":
                                    begin
                                        if Deduct.Get(AssignMatrix.Code) then
                                            if Deduct."Show Balance" then begin
                                                LoanBalances.SetRange("Date filter", 0D, DateSpecified);
                                                LoanBalances.CalcFields("Total Repayment", Receipts);
                                                BalanceArray[1, i] := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                            end;

                                        //Show Loan Interest Amount Seperately
                                        //Principal
                                        ArrEarnings[1, i] := AssignMatrix.Description;
                                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                        //Interest
                                        i := i + 1;
                                        ArrEarnings[1, i] := AssignMatrix.Description + '-Interest';
                                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Loan Interest")));
                                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                        BalanceArray[1, i] := 0;

                                        //Don't Show Zero Interest
                                        if AssignMatrix."Loan Interest" = 0 then
                                            i := i - 1;
                                    end;
                                else begin
                                    if Deduct.Get(AssignMatrix.Code) then
                                        if Deduct."Show Balance" then begin
                                            LoanBalances.SetRange("Date filter", 0D, DateSpecified);
                                            LoanBalances.CalcFields("Total Repayment", Receipts);
                                            BalanceArray[1, i] := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                        end;

                                    //Show Principal Only
                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                    ArrEarnings[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                end;
                            end
                        else begin
                            ArrEarnings[1, i] := AssignMatrix.Description + ' ' + AssignMatrix."Insurance No";
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        end;

                        TotalDeduction := TotalDeduction + Abs(AssignMatrix.Amount) + Abs(AssignMatrix."Loan Interest");

                        if Deduct.Get(AssignMatrix.Code) then
                            if Deduct."Show Balance" then begin
                                LoanBalances.Reset();
                                LoanBalances.SetRange("Loan No", AssignMatrix."Reference No");
                                LoanBalances.SetRange("Deduction Code", AssignMatrix.Code);
                                if LoanBalances.Find('-') then begin
                                    LoanBalances.SetRange("Date filter", 0D, DateSpecified);
                                    LoanBalances.CalcFields("Total Repayment", Receipts);
                                    case LoanBalances."Interest Calculation Method" of
                                        LoanBalances."Interest Calculation Method"::"Sacco Reducing Balance":
                                            ;
                                        /*
i:=i-1;
BalanceArray[1,i]:=(LoanBalances."Approved Amount"+LoanBalances."Total Repayment"-Abs(LoanBalances.Receipts));
i:=i+1;
*/
                                        else
                                    end; //BalanceArray[1,i]:=(LoanBalances."Approved Amount"+LoanBalances."Total Repayment"-ABS(LoanBalances.Receipts));
                                end else begin
                                    Deduct.SetRange("Employee Filter", Employee."No.");
                                    if (Deduct."Start date" <> 0D) and (Deduct."Start date" <= DateSpecified) then
                                        Deduct.SetRange("Pay Period Filter", Deduct."Start date", DateSpecified)
                                    else
                                        Deduct.SetRange("Pay Period Filter", 0D, DateSpecified);
                                    Deduct.CalcFields("Total Amount", "Total Amount Employer", "Share Top Up");
                                    BalanceArray[1, i] := Abs(Deduct."Total Amount") + Abs(Deduct."Total Amount Employer") + Abs(Deduct."Share Top Up");
                                end;
                            end;
                        i := i + 1;

                    until AssignMatrix.Next() = 0;


                ArrEarnings[1, i] := 'Total Deductions';
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
                NetPay := GrossPay - TotalDeduction;
                Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
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

                // taxation
                ArrEarnings[1, i] := 'Taxations';
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
                /*
                 Earn.Reset();
                 Earn.SetRange(Earn."Earning Type",Earn."Earning Type"::"Owner Occupier");
                 if Earn.Find('-') then begin
                  repeat
                   AssignMatrix.Reset();
                   AssignMatrix.SetRange(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SetRange(Type,AssignMatrix.Type::Payment);
                   AssignMatrix.SetRange(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SetRange(AssignMatrix."Basic Salary Code",false);
                   AssignMatrix.SetRange(Code,Earn.Code);
                   if AssignMatrix.Find('-') then begin
                    repeat
                     ArrEarnings[1,i]:=AssignMatrix.Description;
                     Evaluate(ArrEarningsAmt[1,i],Format(AssignMatrix.Amount));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                    i:=i+1;
                  until AssignMatrix.Next()=0;
                  end;
                until Earn.Next()=0;
               end;
               */
                // Taxable amount
                ArrEarnings[1, i] := 'Taxable Amount';
                Evaluate(ArrEarningsAmt[1, i], Format(Abs(TaxableAmt)));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := 'Tax Charged';
                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PAYE)));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                // Relief
                Earn.Reset();
                Earn.SetFilter(Earn."Earning Type", '%1|%2|%3', Earn."Earning Type"::"Tax Relief",
                Earn."Earning Type"::"Insurance Relief", Earn."Earning Type"::"Owner Occupier");
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
                /*
                ArrEarnings[1,i]:=' ';
                ArrEarningsAmt[1,i]:=' ';
                j:=j+1;
                ArrHeadings[i]:=j;


                 i:=i+1;
                 */
                //Information
                ArrEarnings[1, i] := 'Information';
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
                Ded.Reset();
                Ded.SetRange(Ded."Tax deductible", true);
                Ded.SetRange(Ded."Pay Period Filter", DateSpecified);
                Ded.SetRange(Ded."Employee Filter", Employee."No.");
                Ded.SetRange(Ded."Show on Payslip Information", true);
                if Ded.Find('-') then
                    repeat
                        //MESSAGE('fOUND');
                        Ded.CalcFields(Ded."Total Amount", Ded."Total Amount Employer");
                        if Ded."Total Amount Employer" <> 0 then begin
                            ArrEarnings[1, i] := Ded.Description + '(Employer)';
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(Ded."Total Amount Employer")));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                        end;
                    /* ArrEarnings[1,i]:=Ded.Description;
                     Evaluate(ArrEarningsAmt[1,i],Format(Abs(Ded."Total Amount")));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                     i:=i+1;*/



                    until Ded.Next() = 0;




                /*
                ArrEarnings[1,i]:=' ';
                ArrEarningsAmt[1,i]:=' ';
                j:=j+1;
                ArrHeadings[i]:=j;
                 i:=i+1;
                */
                ArrEarnings[1, i] := 'Employee Details';
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
                i := i + 1;

                ArrEarnings[1, i] := 'P.I.N';
                ArrEarningsAmt[1, i] := Employee."PIN Number";

                i := i + 1;
                if EmpBank.Get(Employee."Employee's Bank") then
                    BankName := EmpBank.Name;

                ArrEarnings[1, i] := 'Employee Bank';
                ArrEarningsAmt[1, i] := BankName;

                i := i + 1;
                ArrEarnings[1, i] := 'Bank Branch';
                if EmpBankBranch.Get(Employee."Employee's Bank", Employee."Bank Branch") then
                    ArrEarningsAmt[1, i] := EmpBankBranch."Branch Name";

                i := i + 1;
                ArrEarnings[1, i] := 'Account Number';
                ArrEarningsAmt[1, i] := Employee."Bank Account Number";

                i := i + 1;
                ArrEarnings[1, i] := 'Pension No';
                ArrEarningsAmt[1, i] := Employee."Social Security No.";
                /*
                i:=i+1;
                ArrEarnings[1,i]:='NHIF No';
                ArrEarningsAmt[1,i]:=Employee."NHIF No";
                */
                i := i + 1;
                ArrEarnings[1, i] := 'End of Payslip';

            end;

            trigger OnPreDataItem()
            begin
                CompRec.Get();
                Message2[1, 1] := CompRec."General Payslip Message";
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

    trigger OnPreReport()
    begin
        // CompanyInfo.GET();
        //CompanyInfo.CALCFIELDS(Picture);

        PayPeriodtext := Employee.GetFilter("Pay Period Filter");
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText := Format(PayrollMonth, 1, 4);

        if PayPeriodtext = '' then
            Error('Pay Period must be Specified for this Report');

        CompanyInfo.Get();
        //CompanyName:=CompanyInfo.Name;
        Evaluate(DateSpecified, Format(PayPeriodtext));
    end;

    var
        AssignMatrix: Record "Assignment Matrix";
        EmpBankBranch: Record "Bank Branches";
        EmpBank: Record Banks;
        CompanyInfo: Record "Company Information";
        CompInfo: Record "Company Information";
        Ded: Record Deductions;
        Deduct: Record Deductions;
        DimVal: Record "Dimension Value";
        Earn: Record Earnings;
        CompRec: Record "Human Resources Setup";
        LoanBalances: Record "Payroll Loan Application";
        DateSpecified: Date;
        PayrollMonth: Date;
        BalanceArray: array[3, 100] of Decimal;
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
        AmountCaptionLbl: Label 'Amount';
        CurrReport_PAGENOCaptionLbl: Label 'Copy';
        Dept_CaptionLbl: Label 'Dept:';
        EarningsCaptionLbl: Label 'Earnings';
        Employee_No_CaptionLbl: Label 'Employee No:';
        EmptyStringCaptionLbl: Label '**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************';
        Name_CaptionLbl: Label 'Name:';
        Pay_slipCaptionLbl: Label 'Pay slip';
        CompanyName: Text[30];
        PayPeriodtext: Text[30];
        PayrollMonthText: Text[30];
        DeptArr: array[3, 1] of Text[60];
        Addr: array[10, 100] of Text[250];
        ArrEarnings: array[3, 100] of Text[250];
        ArrEarningsAmt: array[3, 100] of Text[250];
        BankName: Text[250];
        BasicPay: array[3, 1] of Text[250];
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
}





