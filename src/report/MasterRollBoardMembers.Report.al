report 52101 "Master Roll-Board Members"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/MasterRollBoardMembers.rdl';
    Caption = 'Master Roll-Board Members';
    dataset
    {
        dataitem(AssignmentMatrixX; "Assignment Matrix")
        {
            DataItemTableView = sorting("Employee No") where("Employee Type" = const(Trustee));
            RequestFilterFields = "Payroll Period";

            column(EmployeeNo; "Employee No")
            {
            }
            column(Type; Type)
            {
            }
            column(Code; Code)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Description; Description)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(CodeName; CodeName)
            {
            }
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
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
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GetDefaults(PayApprovalCode);
                NetPay := 0;
                TotalEarnings := 0;
                TotalDeductions := 0;

                if EmpRec.Get(AssignmentMatrixX."Employee No") then begin
                    EmpName := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";

                    Employee.Reset();
                    Employee.SetFilter("No.", EmpRec."No.");
                    Employee.SetRange("Pay Period Filter", DateSpecified);
                    if Employee.FindFirst() then begin
                        Employee.CalcFields("Total Allowances", "Total Deductions");
                        TotalEarnings := Employee."Total Allowances";
                        TotalDeductions := Employee."Total Deductions";
                        NetPay := Employee."Total Allowances" - Abs(Employee."Total Deductions");
                    end;
                end;


                case AssignmentMatrixX.Type of
                    AssignmentMatrixX.Type::Earning:
                        begin
                            Earnings.Get(AssignmentMatrixX.Code);
                            CodeName := Earnings.Description;
                        end;
                    AssignmentMatrixX.Type::Deduction:
                        begin
                            Deductions.Get(AssignmentMatrixX.Code);
                            CodeName := Deductions.Description;
                        end;
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
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        DateSpecified := AssignmentMatrixX.GetRangeMin("Payroll Period");
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

    end;

    var
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        Deductions: Record Deductions;
        Earnings: Record Earnings;
        Employee: Record Employee;
        EmpRec: Record Employee;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Payroll: Codeunit Payroll;
        Approver: array[10] of Code[50];
        PayApprovalCode: Code[50];
        DateSpecified: Date;
        ApproverDate: array[10] of DateTime;
        NetPay: Decimal;
        TotalDeductions: Decimal;
        TotalEarnings: Decimal;
        CodeName: Text;
        EmpName: Text;

    procedure GetDefaults(var PayAppCode: Code[50])
    begin
        PayApprovalCode := PayAppCode;
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;
}





