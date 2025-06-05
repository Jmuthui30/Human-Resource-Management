report 52198 "Master Roll Report new"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/MasterRollReportnew.rdl';
    Caption = 'Master Roll Report new';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee Type" = filter(<> "Board Member"), Status = const(Active));
            RequestFilterFields = "Pay Period Filter", "No.";

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
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
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
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
            {
            }
            column(DedDesc_1_; DedDesc[1])
            {
            }
            column(DedDesc_2_; DedDesc[2])
            {
            }
            column(DedDesc_3_; DedDesc[3])
            {
            }
            column(DedDesc_4_; DedDesc[4])
            {
            }
            column(Other_Deductions_; 'Other Deductions')
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
            column(EarnDesc_4_; EarnDesc[4])
            {
            }
            column(EarnDesc_5_; EarnDesc[5])
            {
            }
            column(EarnDesc_6_; EarnDesc[6])
            {
            }
            column(EarnDesc_7_; EarnDesc[7])
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(PIN_Number; Employee."PIN Number")
            {
            }
            column(Allowances_1_; Allowances[1])
            {
            }
            column(Allowances_2_; Allowances[2])
            {
            }
            column(Allowances_3_; Allowances[3])
            {
            }
            column(Deductions_1_; Deductions[1])
            {
            }
            column(Deductions_2_; Deductions[2])
            {
            }
            column(Deductions_3_; Deductions[3])
            {
            }
            column(Deductions_4_; Deductions[4])
            {
            }
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Allowances_5_; Allowances[5])
            {
            }
            column(Allowances_4_; Allowances[4])
            {
            }
            column(Allowances_6_; Allowances[6])
            {
            }
            column(Allowances_7_; Allowances[7])
            {
            }
            column(Employee_Company; Company)
            {
            }
            column(Employee__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Employee__Job_Title_; "Job Title")
            {
            }
            column(Allowances_1__Control1000000009; Allowances[1])
            {
            }
            column(Allowances_2__Control1000000018; Allowances[2])
            {
            }
            column(Allowances_3__Control1000000032; Allowances[3])
            {
            }
            column(Deductions_1__Control1000000034; Deductions[1])
            {
            }
            column(Deductions_2__Control1000000035; Deductions[2])
            {
            }
            column(Deductions_3__Control1000000036; Deductions[3])
            {
            }
            column(Deductions_4__Control1000000037; Deductions[4])
            {
            }
            column(OtherDeduct_Control1000000038; OtherDeduct)
            {
            }
            column(NetPay_Control1000000039; NetPay)
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; StrSubstNo('Employees=%1', counter))
            {
            }
            column(Prepared_By______________________________________________________; 'Prepared By.....................................................')
            {
            }
            column(Approved_By_____________________________________________________; 'Approved By....................................................')
            {
            }
            column(Approved_By_____________________________________________; 'Approved By............................................')
            {
            }
            column(Allowances_4__Control1000000054; Allowances[4])
            {
            }
            column(Allowances_5__Control1000000055; Allowances[5])
            {
            }
            column(Allowances_6__Control1000000056; Allowances[6])
            {
            }
            column(MASTER_ROLLCaption; MASTER_ROLLCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_CompanyCaption; FieldCaption(Company))
            {
            }
            column(Employee__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Employee__Job_Title_Caption; FieldCaption("Job Title"))
            {
            }
            column(Basic_Pay; "Basic Pay") { }
            column(Net_Pay; "Net Pay") { }
            column(SIF17; SIF17) { }
            column(SIF8; SIF8) { }
            column(TaxableIncome; TaxableIncome) { }
            column(PIT20; PIT20) { }
            column(Advance; Advance) { }
            column(SaccoPIT20; SaccoPIT20) { }
            column(TotalDeductions; TotalDeductions) { }
            column(MedicalInsurancePIT20; MedicalInsurancePIT20) { }
            column(Gratuity; Gratuity) { }
            column(TotalStaffCost; TotalStaffCost) { }
            column(Total_Deductions; "Total Deductions") { }
            //column(OtherDeduct;OtherDeduct){}

            // Net Pay
            // Gross Pay
            // Medical Insurance
            // Gratuity
            // Total Staff Cost
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(Allowances_Number_; Allowances[Number])
                {
                }
                column(EarnDesc_1__Control1000000060; EarnDesc[Number])
                {
                }
                column(Earncode_Number_; Earncode[Number])
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
                GetDefaults(PayApprovalCode);

                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions", "Loan Interest");
                //Commented temporarily
                /* if (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest") = 0 then
                    CurrReport.Skip(); */

                //Commentedtemporariy
                counter := counter + 1;
                NetPay := Employee."Total Allowances" + Employee."Total Deductions";
                //EVALUATE(EmployeeNo,"No.");


                TaxableIncome := 0;
                Advance := 0;
                OtherEarn := 0;
                OtherDeduct := 0;
                Totallowances := 0;
                OtherDeduct := 0;
                TotalDeductions := 0;
                SIF17 := 0;
                SIF8 := 0;
                MedicalInsurancePIT20 := 0;
                PIT20 := 0;
                SaccoPIT20 := 0;
                TotalStaffCost := 0;
                Assignmat.Reset();
                Assignmat.SetRange("Employee No", Employee."No.");
                Assignmat.SetRange(Type, Assignmat.Type::Deduction);
                Assignmat.SetRange("Payroll Period", DateSpecified);

                if Assignmat.FindSet() then
                    repeat
                        case Assignmat.Code of
                            'GRATUITY':
                                Gratuity := Assignmat."Employer Amount";
                            'SIF':
                                begin
                                    SIF17 := Assignmat."Employer Amount";
                                    SIF8 := -Assignmat.Amount;
                                end;
                            'MI':
                                MedicalInsurancePIT20 := Assignmat."Employer Amount";
                            'PIT':
                                begin
                                    PIT20 := -Assignmat.Amount;
                                    TaxableIncome := Assignmat."Taxable amount";
                                end;

                            'SACCO':
                                SaccoPIT20 := -Assignmat.Amount;
                            'STAFF_LOAN':
                                Advance := -Assignmat.Amount;
                        end;
                    until Assignmat.Next() = 0;
                TotalDeductions := PIT20 + Advance;
                TotalStaffCost := "Basic Pay" + SIF17 + MedicalInsurancePIT20 + Gratuity;

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

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        DateSpecified := Employee.GetRangeMin(Employee."Pay Period Filter");


        //






        //
    end;

    var
        Grosspay: Decimal;
        SIF8: Decimal;
        SIF17: Decimal;
        TaxableIncome: Decimal;

        Advance: Decimal;
        SaccoPIT20: Decimal;

        TotalDeductionsPIT20: Decimal;

        NetPayPIT20: Decimal;

        GrossPayPIT20: Decimal;

        MedicalInsurancePIT20: Decimal;

        PIT20: Decimal;

        Gratuity: Decimal;
        TotalStaffCost: Decimal;
        ApprovalEntries: Record "Approval Entry";
        Assignmat: Record "Assignment Matrix";
        CompanyInfo: Record "Company Information";
        DedRec: Record Deductions;
        EarnRec: Record Earnings;
        HRSetup: Record "Human Resources Setup";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Payroll: Codeunit Payroll;
        Earncode: array[1000] of Code[20];
        Approver: array[10] of Code[50];
        PayApprovalCode: Code[50];
        DateSpecified: Date;
        ApproverDate: array[10] of DateTime;
        Allowances: array[1000] of Decimal;
        Deductions: array[100] of Decimal;
        NetPay: Decimal;
        OtherDeduct: Decimal;
        OtherEarn: Decimal;
        TotalDeductions: Decimal;
        TotalLoanInterest: Decimal;
        Totallowances: Decimal;
        counter: Integer;
        i: Integer;
        NoOfDeductions: Integer;
        NoOfEarnings: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MASTER_ROLLCaptionLbl: Label 'MASTER ROLL';
        DedDesc: array[100] of Text[150];
        EarnDesc: array[1000] of Text[150];

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





