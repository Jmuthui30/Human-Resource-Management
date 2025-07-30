report 52118 "Cash payment Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/CashPayment net.rdl';


    dataset
    {
        dataitem("Cash Payment"; "Cash Payment")
        {
            RequestFilterFields = "Payroll Period";
            column(Employee_No; "Employee No")
            {

            }
            column(EmployeeName; EmployeeName) { }
            column(Employee_Name; "Employee Name") { }
            column(Payroll_Period; "Payroll Period")
            { }
            column(Cash_Amount; "Cash Amount")
            { }
            column(Location; Location)
            { }
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
            column(IDNO; IDNO) { }
            column(Employee__Bank_Account_Number; Employee__Bank_Account_Number) { }
            column(NetPay; NetPay) { }
            column(BankBranch; BankBranch) { }
            column(BankName; BankName) { }
            column(CountNo; CountNo) { }
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
                CountNo := CountNo + 1;
                BankName := '';
                BankBranch := '';

                VarEmployee.Reset();
                VarEmployee.SetRange(VarEmployee."No.", "Employee No");
                if VarEmployee.Find('-') then begin
                    VarEmployee.CalcFields("Net Pay");
                    Employee__Bank_Account_Number := VarEmployee."Bank Account Number";
                    IDNO := VarEmployee."ID No.";
                    NetPay := VarEmployee."Net Pay";
                    EmployeeName := VarEmployee.FullName();

                    if EmpBank.Get(VarEmployee."Employee's Bank") then
                        BankName := EmpBank.Name;
                    if EmpBankBranch.Get(VarEmployee."Employee's Bank") then
                        BankBranch := EmpBankBranch."Branch Name";

                end;


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

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }


    }



    trigger OnInitReport()
    begin

    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

        DateSpecified := "Cash Payment".GetRangeMin("Cash Payment"."Payroll Period");

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Payroll: Codeunit Payroll;
        ApprovalEntries: Record "Approval Entry";
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
        EmployeeName: Text[2000];
        CountNo: Integer;
        EmpBankBranch: Record "Bank Branches";
        EmpBank: Record Banks;
        CompanyInfo: Record "Company Information";
        DateSpecified: Date;
        VarEmployee: Record Employee;
        BankBranch: Text[100];
        BankName: Text[100];
        Employee__Bank_Account_Number: Code[1000];
        NetPay: Decimal;
        IDNO: Code[20];


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