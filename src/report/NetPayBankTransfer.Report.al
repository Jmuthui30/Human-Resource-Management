report 52064 "Net Pay Bank Transfer"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/NetPayBankTransfer.rdl';
    Caption = 'Net Pay Bank Transfer';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee type" = filter(<> "Board Member"));
            RequestFilterFields = "Pay Period Filter", "Pay Mode", "No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(TIME; Time)
            {
            }
            column(Net_Pay_; 'Net Pay')
            {
            }
            column(PF_No__; 'PF No.')
            {
            }
            column(Name_; 'Name')
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Employee__National_ID_; "ID No.")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankBranch; BankBranch)
            {
            }
            column(Sort_Code; GetSortCode("No."))
            {
            }
            column(Employee__Bank_Account_Number_; "Bank Account Number")
            {
            }
            column(NetPay_Control1000000039; NetPay)
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; StrSubstNo('Employees=%1', counter))
            {
            }
            column(NET_PAY_TO_BANKCaption; NET_PAY_TO_BANKCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ID_NumberCaption; ID_NumberCaptionLbl)
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(BranchCaption; BranchCaptionLbl)
            {
            }
            column(Account_NumberCaption; Account_NumberCaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(Approving_OfficerCaption; Approving_OfficerCaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption_Control1000000021; DESIGNATION____________________________________________________________Caption_Control1000000021Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000022; DATE_____________________________________________________________________Caption_Control1000000022Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000023; NAME_________________________________________________________________________Caption_Control1000000023Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000024; SIGNATURE___________________________________________________________Caption_Control1000000024Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            column(BankCharges; BankCharges)
            { }
            column(Pay_Mode; "Pay Mode") { }
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

            // "No.", Status;
            trigger OnAfterGetRecord()
            begin
                BankName := '';
                BankBranch := '';
                BankCharges := 0;

                if EmpBank.Get(Employee."Employee's Bank") then;
                BankName := EmpBank.Name;

                if EmpBankBranch.Get(Employee."Employee's Bank", Employee."Bank Branch") then;
                BankBranch := EmpBankBranch."Branch Name";


                if "Pay Mode" = 'BANK_INTERNAL' then begin
                    PayrollPeriod.Reset();
                    PayrollPeriod.SetRange("Starting Date", DateSpecified);
                    if PayrollPeriod.Find('-') then
                        BankCharges := PayrollPeriod."Bank Charges";
                end;

                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions", "Loan Interest");
                if (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest") = 0 then
                    CurrReport.Skip();
                counter := counter + 1;
                CashAmountNetPay := 0;

                cashPayment.Reset();
                cashPayment.SetRange("Employee No", Employee."No.");
                cashPayment.SetRange("Payroll Period", DateSpecified);
                if cashPayment.FindFirst() then begin
                    CashAmountNetPay := cashPayment."Cash Amount";
                end;
                //   Message('cash is %1', CashAmountNetPay);

                //  // Standard Net Pay Calculation: (Allowances) - (Deductions + Loan Interest)
                //  Message('allo is %1..#.dec is %2', Employee."Total Allowances", Employee."Total Deductions");
                NetPay := (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest" + BankCharges) - (CashAmountNetPay);
                NetPay := Round(NetPay, RoundPrecision, RoundDirection);

                // NetPay := Round(Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest", RoundPrecision, RoundDirection);

                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID", Database::"Payroll Approval");
                if PayApprovalCode <> '' then
                    ApprovalEntries.SetRange("Document No.", PayApprovalCode)
                else
                    ApprovalEntries.SetRange("Document No.", Payroll.GetPayrollApprovalCode(DateSpecified));
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
                //CurrReport.CreateTotals(Allowances, Deductions, OtherEarn, OtherDeduct, NetPay);
                HRSetup.Get();
            end;
        }
    }

    requestpage
    {
        layout
        {
            // area(content)
            // {
            //     group("Pay Method")
            //     {
            //         field("Pay Mode"; Employee."Pay Mode")
            //         {
            //             ApplicationArea = All;
            //             ToolTip = 'The Caption property for PageField "Pay Mode" must be filled in';
            //         }

            //     }
            // }

        }
    }
    labels
    {
    }

    trigger OnInitReport()
    begin

    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

        DateSpecified := Employee.GetRangeMin(Employee."Pay Period Filter");
        Payroll.GetPayrollRounding(RoundPrecision, RoundDirection);

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Earncode: array[1000] of Code[20];
        Approver: array[10] of Code[50];
        PayApprovalCode: Code[50];
        ApproverDate: array[10] of DateTime;
        Allowances: array[1000] of Decimal;
        Deductions: array[100] of Decimal;
        ApprovalEntries: Record "Approval Entry";
        BankCharges: Decimal;
        CashAmountNetPay: Decimal;
        EmployeePayModes: Record "Employee Pay Modes";
        cashPayment: Record "Cash Payment";
        EmpBankBranch: Record "Bank Branches";
        EmpBank: Record Banks;
        CompanyInfo: Record "Company Information";
        HRSetup: Record "Human Resources Setup";
        Payroll: Codeunit Payroll;
        DateSpecified: Date;
        NetPay: Decimal;
        RoundPrecision: Decimal;
        counter: Integer;
        Account_NumberCaptionLbl: Label 'Account Number';
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        BankCaptionLbl: Label 'Bank';
        BranchCaptionLbl: Label 'Branch';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DATE_____________________________________________________________________Caption_Control1000000022Lbl: Label 'DATE ....................................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        DESIGNATION____________________________________________________________Caption_Control1000000021Lbl: Label 'DESIGNATION ...........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        ID_NumberCaptionLbl: Label 'ID Number';
        NAME_________________________________________________________________________Caption_Control1000000023Lbl: Label 'NAME  .......................................................................';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        NET_PAY_TO_BANKCaptionLbl: Label 'NET PAY TO BANK';
        SIGNATURE___________________________________________________________Caption_Control1000000024Lbl: Label 'SIGNATURE ..........................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        RoundDirection: Text;
        BankBranch: Text[100];
        BankName: Text[100];
        PayrollPeriod: Record "Payroll Period";

    procedure GetSortCode(No: Code[50]): Code[50]
    begin
        if Employee.Get(No) then
            exit(Employee."Employee Bank Sort Code");
    end;

    procedure GetDefaults(var PayAppCode: Code[50])
    begin
        PayApprovalCode := PayAppCode;
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        users: Record User;
    begin
        Users.RESET;
        Users.SETRANGE("User Name", UserCode);
        IF Users.FINDFIRST THEN
            EXIT(Users."Full Name");
        exit(UserCode);
    end;
}





