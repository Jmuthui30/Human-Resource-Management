report 52037 "Loan Repayment Schedule-HR"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/LoanRepaymentSchedule-HR.rdl';
    Caption = 'Loan Repayment Schedule-HR';
    dataset
    {
        dataitem("Repayment Schedule"; "Payroll Repayment Schedule")
        {
            DataItemTableView = sorting("Loan No", "Employee No", "Repayment Date") order(ascending);
            RequestFilterFields = "Loan No", "Employee No";

            column(Repayment_Schedule__Repayment_Schedule___Employee_No_; "Employee No")
            {
            }
            column(LoanApp__Employee_Name_; LoanApp."Employee Name")
            {
            }
            column(Repayment_Schedule__Repayment_Schedule___Loan_No_; "Loan No")
            {
            }
            column(LoanCategory_Description; LoanCategory.Description)
            {
            }
            column(Repayment_Schedule__Loan_Amount_; "Loan Amount")
            {
            }
            column(Rate; Rate)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Duration; Duration)
            {
            }
            column(IssuedDate; IssuedDate)
            {
            }
            column(COMPANYNAMES; CompanyName)
            {
            }
            column(Repayment_Schedule__Monthly_Repayment_; "Monthly Repayment")
            {
            }
            column(Repayment_Schedule__Repayment_Date_; "Repayment Date")
            {
            }
            column(Repayment_Schedule__Principal_Repayment_; "Principal Repayment")
            {
            }
            column(Repayment_Schedule__Monthly_Interest_; "Monthly Interest")
            {
            }
            column(LoanBalance; LoanBalance)
            {
            }
            column(CumInterest; CumInterest)
            {
            }
            column(CumPrincipalRepayment; CumPrincipalRepayment)
            {
            }
            column(CumMonthlyRepayment; CumMonthlyRepayment)
            {
            }
            column(Repayment_Schedule__Repayment_Schedule___Instalment_No_; "Instalment No")
            {
            }
            column(Repayment_Schedule__Monthly_Repayment__Control1000000043; "Monthly Repayment")
            {
            }
            column(Repayment_Schedule__Principal_Repayment__Control1000000014; "Principal Repayment")
            {
            }
            column(Repayment_Schedule__Monthly_Interest__Control1000000015; "Monthly Interest")
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Loan_No_Caption; Loan_No_CaptionLbl)
            {
            }
            column(Loan_CategoryCaption; Loan_CategoryCaptionLbl)
            {
            }
            column(Loan_AmountCaption; Loan_AmountCaptionLbl)
            {
            }
            column(Loan_InterestCaption; Loan_InterestCaptionLbl)
            {
            }
            column(Loan_DurationCaption; Loan_DurationCaptionLbl)
            {
            }
            column(DISBURSMENT_DATECaption; DISBURSMENT_DATECaptionLbl)
            {
            }
            column(Loan_Repayment_ScheduleCaption; Loan_Repayment_ScheduleCaptionLbl)
            {
            }
            column(Monthly_RepaymentCaption; Monthly_RepaymentCaptionLbl)
            {
            }
            column(InterestCaption; InterestCaptionLbl)
            {
            }
            column(Principal_RepaymentCaption; Principal_RepaymentCaptionLbl)
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
            {
            }
            column(InterestCaption_Control1000000009; InterestCaption_Control1000000009Lbl)
            {
            }
            column(Principal_RepaymentCaption_Control1000000038; Principal_RepaymentCaption_Control1000000038Lbl)
            {
            }
            column(Monthly_RepaymentCaption_Control1000000039; Monthly_RepaymentCaption_Control1000000039Lbl)
            {
            }
            column(Loan_RepaymentCaption; Loan_RepaymentCaptionLbl)
            {
            }
            column(CummilativeCaption; CummilativeCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo.County)
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                i := i + 1;
                if LoanApp.Get("Repayment Schedule"."Loan No") then begin//,"Repayment Schedule"."Loan Deduction Code") THEN BEGIN
                    Duration := LoanApp.Instalment;
                    IssuedDate := LoanApp."Issued Date";


                    LoanCategory.Get("Repayment Schedule"."Loan Category");
                    TotalPrincipalRepayment := TotalPrincipalRepayment + "Repayment Schedule"."Principal Repayment";

                    if i = 1 then
                        LoanBalance := LoanApp."Approved Amount"
                    else
                        LoanBalance := LoanApp."Approved Amount" - TotalPrincipalRepayment + "Repayment Schedule"."Principal Repayment";

                    CumInterest := CumInterest + "Repayment Schedule"."Monthly Interest";
                    CumMonthlyRepayment := CumMonthlyRepayment + "Repayment Schedule"."Monthly Repayment";
                    CumPrincipalRepayment := CumPrincipalRepayment + "Repayment Schedule"."Principal Repayment";
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Employee No");
                i := 0;
                j := 0;
                CUser := UserId;
                //GetGroup.GetUserGroup(CUser,GroupCode);
                //SETRANGE("Repayment Schedule"."Payroll Group",GroupCode);
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
    end;

    var
        CompanyInfo: Record "Company Information";
        LoanCategory: Record "Loan Product Type-Payroll";
        LoanApp: Record "Payroll Loan Application";
        CUser: Code[50];
        IssuedDate: Date;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        LoanBalance: Decimal;
        Rate: Decimal;
        TotalPrincipalRepayment: Decimal;
        Duration: Integer;
        i: Integer;
        j: Integer;
        LastFieldNo: Integer;
        CummilativeCaptionLbl: Label 'Cummilative';
        DISBURSMENT_DATECaptionLbl: Label 'DISBURSMENT DATE';
        Due_DateCaptionLbl: Label 'Due Date';
        Employee_No_CaptionLbl: Label 'Employee No.';
        InterestCaption_Control1000000009Lbl: Label 'Interest';
        InterestCaptionLbl: Label 'Interest';
        Loan_AmountCaptionLbl: Label 'Loan Amount';
        Loan_BalanceCaptionLbl: Label 'Loan Balance';
        Loan_CategoryCaptionLbl: Label 'Loan Category';
        Loan_DurationCaptionLbl: Label 'Loan Duration';
        Loan_InterestCaptionLbl: Label 'Loan Interest';
        Loan_No_CaptionLbl: Label 'Loan No.';
        Loan_Repayment_ScheduleCaptionLbl: Label 'Loan Repayment Schedule';
        Loan_RepaymentCaptionLbl: Label 'Loan Repayment';
        Monthly_RepaymentCaption_Control1000000039Lbl: Label 'Monthly Repayment';
        Monthly_RepaymentCaptionLbl: Label 'Monthly Repayment';
        Name_CaptionLbl: Label 'Name:';
        Principal_RepaymentCaption_Control1000000038Lbl: Label 'Principal Repayment';
        Principal_RepaymentCaptionLbl: Label 'Principal Repayment';
        TotalCaptionLbl: Label 'Total';
}





