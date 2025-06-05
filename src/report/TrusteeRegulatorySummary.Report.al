report 52103 "Trustee Regulatory Summary"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrusteeRegulatorySummary.rdl';
    Caption = 'Trustee Regulatory Summary';
    dataset
    {
        dataitem(AssignmentMatrix; "Assignment Matrix")
        {
            DataItemTableView = sorting("Payroll Period", Type, Code) where("Tax Relief" = const(false), "Non-Cash Benefit" = const(false), "Employee Type" = const(Trustee));
            RequestFilterFields = "Payroll Period", Type, "Code";
            RequestFilterHeading = 'Payroll';

            column(TIME; Time)
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT__Payroll_Period__0___month_text___year4____; UpperCase(Format("Payroll Period", 0, '<month text> <year4>')))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(PERIOD_Caption; PERIOD_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(COMPANY_SUMMARYCaption; COMPANY_SUMMARYCaptionLbl)
            {
            }
            column(CURRENT_AMOUNTCaption; CURRENT_AMOUNTCaptionLbl)
            {
            }
            column(PREVIOUS_MONTH_AMOUNTCaption; PREVIOUS_MONTH_AMOUNTCaptionLbl)
            {
            }
            column(VARIANCECaption; VARIANCECaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(CODECaption; CODECaptionLbl)
            {
            }
            column(Assignment_Matrix_X_Employee_No; "Employee No")
            {
            }
            column(Assignment_Matrix_X_Type; Type)
            {
            }
            column(Assignment_Matrix_X_Code; Code)
            {
            }
            column(Assignment_Matrix_X_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X_Reference_No; "Reference No")
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if AssignmentMatrix.Type = AssignmentMatrix.Type::Earning then begin
                    if Earning.Get(AssignmentMatrix.Code) then
                        if not Earning."Non-Cash Benefit" then
                            TotalNetPay := TotalNetPay + AssignmentMatrix.Amount;
                end
                else
                    TotalNetPay := TotalNetPay + AssignmentMatrix.Amount + AssignmentMatrix."Loan Interest";

                Assmatrix.Reset();
                Assmatrix.SetRange(Type, AssignmentMatrix.Type);
                Assmatrix.SetRange(Code, AssignmentMatrix.Code);
                Assmatrix.SetRange("Employee No", AssignmentMatrix."Employee No");
                Assmatrix.SetRange("Payroll Period", PreviousMonth);
                if Assmatrix.Find('-') then begin
                    PreviousAmount := PreviousAmount + Assmatrix.Amount + Assmatrix."Loan Interest";
                    if Assmatrix.Type = Assmatrix.Type::Earning then begin
                        if Earning.Get(Assmatrix.Code) then
                            if not Earning."Non-Cash Benefit" then
                                PrevTotalNetPay := PrevTotalNetPay + Assmatrix.Amount;

                    end
                    else
                        PrevTotalNetPay := PrevTotalNetPay + Assmatrix.Amount + Assmatrix."Loan Interest";
                end;

                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID", Database::"Payroll Approval");
                ApprovalEntries.SetRange("Document No.", PayrollMgt.GetPayrollApprovalCode(DateSpecified));
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[1] := ApprovalEntries."Sender ID";
                            ApproverDate[1] := ApprovalEntries."Date-Time Sent for Approval";
                            if UserSetup.Get(Approver[1]) then
                                UserSetup.CalcFields(Signature);
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then
                                UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next() = 0;

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Code);
                TotalNetPay := 0;
                PrevTotalNetPay := 0;
                PreviousAmount := 0;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number);

            column(ABS_CurrAmount_Number___ABS_PrevAmount_Number__; (CurrAmount[Number]) - (PrevAmount[Number]))
            {
            }
            column(PrevAmount_Number_; PrevAmount[Number])
            {
            }
            column(CurrAmount_Number_; CurrAmount[Number])
            {
            }
            column(Desc_Number_; Desc[Number])
            {
            }
            column(Ref_Number_; Ref[Number])
            {
            }
            column(NoOfEmployees_PrevNoOfEmployees; NoOfEmployees - PrevNoOfEmployees)
            {
            }
            column(PrevNoOfEmployees; PrevNoOfEmployees)
            {
            }
            column(ABS_PrevTotalEarnings__ABS_PrevTotalDeductions_; Abs(PrevTotalEarnings) - Abs(PrevTotalDeductions))
            {
            }
            column(ABS_CurrTotalEarnings__ABS_CurrTotalDeductions____ABS_PrevTotalEarnings__ABS_PrevTotalDeductions__; (Abs(CurrTotalEarnings) - Abs(CurrTotalDeductions)) - (Abs(PrevTotalEarnings) - Abs(PrevTotalDeductions)))
            {
            }
            column(NoOfEmployees; NoOfEmployees)
            {
            }
            column(ABS_CurrTotalEarnings__ABS_CurrTotalDeductions_; Abs(CurrTotalEarnings) - Abs(CurrTotalDeductions))
            {
            }
            column(No_of_Employees_; 'No of Employees')
            {
            }
            column(Text002; Text002)
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, i);
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
        DateSpecified := AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period");

        EmpRec.Reset();
        EmpRec.SetRange(EmpRec."Pay Period Filter", AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
        if EmpRec.Find('-') then
            repeat
                EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions", EmpRec."Loan Interest");
                if (EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest") <> 0 then
                    NoOfEmployees := NoOfEmployees + 1;
            until EmpRec.Next() = 0;

        //Previous Month
        PreviousMonth := CalcDate('-1M', AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
        EmpRec.Reset();
        EmpRec.SetRange(EmpRec."Pay Period Filter", PreviousMonth);
        if EmpRec.Find('-') then
            repeat
                EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions", EmpRec."Loan Interest");
                if (EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest") <> 0 then
                    PrevNoOfEmployees := PrevNoOfEmployees + 1;
            until EmpRec.Next() = 0;

        //Get the earnings and deductions
        PrevTotalEarnings := 0;
        CurrTotalEarnings := 0;
        PrevTotalDeductions := 0;
        CurrTotalDeductions := 0;
        i := 1;
        Desc[i] := Text003;
        i := i + 1;
        Earning.Reset();
        Earning.SetRange(Earning."Non-Cash Benefit", false);
        if Earning.Find('-') then
            repeat
                //Previous Month
                Earning.SetRange("Pay Period Filter");
                Earning.SetRange("Pay Period Filter", PreviousMonth);
                Earning.CalcFields("Total Amount");
                PrevAmount[i] := Earning."Total Amount";
                Desc[i] := Earning.Description;
                Ref[i] := Earning.Code;
                PrevTotalEarnings := PrevTotalEarnings + PrevAmount[i];

                //Current Month
                Earning.SetRange("Pay Period Filter");
                Earning.SetRange("Pay Period Filter", AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
                Earning.CalcFields("Total Amount");
                CurrAmount[i] := Earning."Total Amount";
                Desc[i] := Earning.Description;
                Ref[i] := Earning.Code;
                CurrTotalEarnings := CurrTotalEarnings + CurrAmount[i];

                //Increase Counter
                if (CurrAmount[i] <> 0) or (PrevAmount[i] <> 0) then
                    i := i + 1;

            until
             Earning.Next() = 0;
        //Get Total Earnings
        Desc[i] := Text000;
        PrevAmount[i] := PrevTotalEarnings;
        CurrAmount[i] := CurrTotalEarnings;
        i := i + 1;
        //

        Desc[i] := Text004;
        i := i + 1;

        DeductionRec.Reset();
        if DeductionRec.Find('-') then
            repeat
                //Previous Month
                DeductionRec.SetRange("Pay Period Filter");
                DeductionRec.SetRange("Pay Period Filter", PreviousMonth);
                DeductionRec.CalcFields("Total Amount", "Loan Interest");
                PrevAmount[i] := DeductionRec."Total Amount" + DeductionRec."Loan Interest";
                Desc[i] := DeductionRec.Description;
                Ref[i] := DeductionRec.Code;
                PrevTotalDeductions := PrevTotalDeductions + PrevAmount[i];

                //Current Month
                DeductionRec.SetRange("Pay Period Filter");
                DeductionRec.SetRange("Pay Period Filter", AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
                DeductionRec.CalcFields("Total Amount", "Loan Interest");
                CurrAmount[i] := DeductionRec."Total Amount" + DeductionRec."Loan Interest";
                Desc[i] := DeductionRec.Description;
                Ref[i] := DeductionRec.Code;
                CurrTotalDeductions := CurrTotalDeductions + CurrAmount[i];

                //Increase Counter
                if (CurrAmount[i] <> 0) or (PrevAmount[i] <> 0) then
                    i := i + 1;

            until
             DeductionRec.Next() = 0;
        //

        //Get Total Deductions
        Desc[i] := Text001;
        PrevAmount[i] := PrevTotalDeductions;
        CurrAmount[i] := CurrTotalDeductions;
        //
    end;

    var
        ApprovalEntries: Record "Approval Entry";
        Assmatrix: Record "Assignment Matrix";
        DeductionRec: Record Deductions;
        Earning: Record Earnings;
        EmpRec: Record Employee;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        PayrollMgt: Codeunit Payroll;
        Ref: array[200] of Code[20];
        Approver: array[10] of Code[50];
        DateSpecified: Date;
        PreviousMonth: Date;
        ApproverDate: array[10] of DateTime;
        CurrAmount: array[100] of Decimal;
        CurrTotalDeductions: Decimal;
        CurrTotalEarnings: Decimal;
        PrevAmount: array[100] of Decimal;
        PreviousAmount: Decimal;
        PrevTotalDeductions: Decimal;
        PrevTotalEarnings: Decimal;
        PrevTotalNetPay: Decimal;
        TotalNetPay: Decimal;
        i: Integer;
        LastFieldNo: Integer;
        NoOfEmployees: Integer;
        PrevNoOfEmployees: Integer;
        CODECaptionLbl: Label 'CODE';
        COMPANY_SUMMARYCaptionLbl: Label 'COMPANY SUMMARY';
        CURRENT_AMOUNTCaptionLbl: Label 'CURRENT AMOUNT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        PERIOD_CaptionLbl: Label 'PERIOD:';
        PREVIOUS_MONTH_AMOUNTCaptionLbl: Label 'PREVIOUS MONTH AMOUNT';
        Text000: Label 'Total Earnings';
        Text001: Label 'Total Deductions';
        Text002: Label 'Net Salary';
        Text003: Label 'Earnings';
        Text004: Label 'Deductions';
        VARIANCECaptionLbl: Label 'VARIANCE';
        Desc: array[200] of Text[100];

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;
}





