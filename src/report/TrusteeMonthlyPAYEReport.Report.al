report 52089 "Trustee Monthly PAYE Report"
{
    ApplicationArea = All;
    Caption = 'Monthly PAYE Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrusteeMonthlyPAYEReport.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee Type" = filter("Board Member"));
            RequestFilterFields = "Pay Period Filter";

            column(UPPERCASE_FORMAT_DateSpecified_0___month_text____year4____; UpperCase(Format(DateSpecified, 0, '<month text>  <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(SortBy; SortBy)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text____year4_____Control5; UpperCase(Format(DateSpecified, 0, '<month text>  <year4>')))
            {
            }
            column(CoName_Control9; CoName)
            {
            }
            column(SortBy_Control29; SortBy)
            {
            }
            column(FORMAT_TODAY_0_4__Control22; Format(Today, 0, 4))
            {
            }
            column(USERID_Control24; UserId)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(First_Name_________Middle_Name________Last_Name_; "First Name" + '  ' + "Middle Name" + '  ' + "Last Name")
            {
            }
            column(Employee__PIN_Number_; "PIN Number")
            {
            }
            column(Employee_Employee__Taxable_Income_; Employee."Taxable Income")
            {
            }
            column(ABS_Employee__Cumm__PAYE__; Abs(Employee."Cumm. PAYE"))
            {
            }
            column(TotalTaxable; TotalTaxable)
            {
            }
            column(ABS_TotalPaye_; Abs(TotalPaye))
            {
            }
            column(RecordNo; RecordNo)
            {
            }
            column(Employee_NamesCaption; Employee_NamesCaptionLbl)
            {
            }
            column(FilterCaption; FilterCaptionLbl)
            {
            }
            column(PIN_NumberCaption; PIN_NumberCaptionLbl)
            {
            }
            column(USERCaption; USERCaptionLbl)
            {
            }
            column(PAYE_KshsCaption; PAYE_KshsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MONTHLY_PAYE_REPORT_Caption; MONTHLY_PAYE_REPORT_CaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(Pay_NumberCaption; Pay_NumberCaptionLbl)
            {
            }
            column(TAXABLE_PAYCaption; TAXABLE_PAYCaptionLbl)
            {
            }
            column(PERIODCaption_Control27; PERIODCaption_Control27Lbl)
            {
            }
            column(Employee_NamesCaption_Control12; Employee_NamesCaption_Control12Lbl)
            {
            }
            column(Pay_NumberCaption_Control7; Pay_NumberCaption_Control7Lbl)
            {
            }
            column(PIN_NumberCaption_Control13; PIN_NumberCaption_Control13Lbl)
            {
            }
            column(PAYE_KshsCaption_Control15; PAYE_KshsCaption_Control15Lbl)
            {
            }
            column(USERCaption_Control26; USERCaption_Control26Lbl)
            {
            }
            column(CurrReport_PAGENO_Control23Caption; CurrReport_PAGENO_Control23CaptionLbl)
            {
            }
            column(FilterCaption_Control30; FilterCaption_Control30Lbl)
            {
            }
            column(MONTHLY_PAYE_REPORT_Caption_Control47; MONTHLY_PAYE_REPORT_Caption_Control47Lbl)
            {
            }
            column(TAXABLE_PAYCaption_Control1000000001; TAXABLE_PAYCaption_Control1000000001Lbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(Approving_OfficerCaption; Approving_OfficerCaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption_Control1000000007; DESIGNATION____________________________________________________________Caption_Control1000000007Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000008; DATE_____________________________________________________________________Caption_Control1000000008Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000009; NAME_________________________________________________________________________Caption_Control1000000009Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000010; SIGNATURE___________________________________________________________Caption_Control1000000010Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }

            //, , "No.", "Global Dimension 1 Code", "Global Dimension 2 Code"
            trigger OnAfterGetRecord()
            begin
                CfMpr := 0;


                /*
                 if EmpBank.Get("Employee's Bank","Bank Branch") then
                    BankName:=EmpBank.Name; */

                Employee.CalcFields("Taxable Allowance", "Tax Deductible Amount", Employee."Cumm. PAYE");
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions", Employee."Taxable Income");
                Employee.CalcFields("Benefits-Non Cash", "Total Savings", "Retirement Contribution");

                if Employee."Cumm. PAYE" = 0 then
                    CurrReport.Skip();
                TotalPaye := TotalPaye + Employee."Cumm. PAYE";
                TotalTaxable := TotalTaxable + Employee."Taxable Income";
                RecordNo := RecordNo + 1;

            end;

            trigger OnPreDataItem()
            begin
                CompanyRec.Get();
                CoName := CompanyRec.Name;
                if BeginDate = DateSpecified then
                    Employee.SetRange(Status, Employee.Status::Active);
                NoOfRecords := Count;
                DeptFilter := '';
                ProjFilter := '';
                SecLocFilter := '';
                NoFilter := '';
                if Employee.GetFilter("Global Dimension 1 Code") <> '' then
                    DeptFilter := 'Dept ' + Employee.GetFilter("Global Dimension 1 Code");
                if Employee.GetFilter("No.") <> '' then
                    NoFilter := 'No ' + Employee.GetFilter("No.");
                if Employee.GetFilter("Global Dimension 2 Code") <> '' then
                    ProjFilter := 'Proj ' + Employee.GetFilter("Global Dimension 2 Code");
                /*if Employee.GetFilter(Location) <> '' then
                 SecLocFilter:='Sec/Loc ' + Employee.GetFilter(Location);*/

                SortBy := NoFilter + DeptFilter + ProjFilter + SecLocFilter;
                /*CUser:=UserId;
                GetGroup.GetUserGroup(CUser,GroupCode);
                SetRange(Employee."Posting Group",GroupCode);*/

                //EVALUATE(EmployeeNo,"No.");

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
        GetPayPeriod();
        PayPeriodtext := Employee.GetFilter("Pay Period Filter");
        if PayPeriodtext = '' then
            Error('Pay period must be specified for this report');
        DateSpecified := Employee.GetRangeMin("Pay Period Filter");
        HoldDate := Employee.GetRangeMin("Pay Period Filter");
        if PayPeriod.Get(DateSpecified) then
            PayPeriodtext := PayPeriod.Name;
        Year := Date2DMY(HoldDate, 3);
        PayPeriodtext := PayPeriodtext + '-' + Format(Year);
        EndDate := CalcDate('1M', DateSpecified - 1);
    end;

    var
        CompanyRec: Record "Company Information";
        PayPeriod: Record "Payroll Period";
        TaxCode: Code[10];
        BeginDate: Date;
        DateSpecified: Date;
        EndDate: Date;
        HoldDate: Date;
        AmountRemaining: Decimal;
        CfMpr: Decimal;
        IncomeTax: Decimal;
        TotalPaye: Decimal;
        TotalTaxable: Decimal;
        NoOfRecords: Integer;
        RecordNo: Integer;
        Year: Integer;
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
        CurrReport_PAGENO_Control23CaptionLbl: Label 'Page';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DATE_____________________________________________________________________Caption_Control1000000008Lbl: Label 'DATE ....................................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        DESIGNATION____________________________________________________________Caption_Control1000000007Lbl: Label 'DESIGNATION ...........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        Employee_NamesCaption_Control12Lbl: Label 'Employee Names';
        Employee_NamesCaptionLbl: Label 'Employee Names';
        FilterCaption_Control30Lbl: Label 'Filter';
        FilterCaptionLbl: Label 'Filter';
        MONTHLY_PAYE_REPORT_Caption_Control47Lbl: Label 'MONTHLY PAYE REPORT ';
        MONTHLY_PAYE_REPORT_CaptionLbl: Label 'MONTHLY PAYE REPORT ';
        NAME_________________________________________________________________________Caption_Control1000000009Lbl: Label 'NAME  .......................................................................';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        Pay_NumberCaption_Control7Lbl: Label 'Pay Number';
        Pay_NumberCaptionLbl: Label 'Pay Number';
        PAYE_KshsCaption_Control15Lbl: Label 'PAYE Kshs';
        PAYE_KshsCaptionLbl: Label 'PAYE Kshs';
        PERIODCaption_Control27Lbl: Label 'PERIOD';
        PERIODCaptionLbl: Label 'PERIOD';
        PIN_NumberCaption_Control13Lbl: Label 'PIN Number';
        PIN_NumberCaptionLbl: Label 'PIN Number';
        SIGNATURE___________________________________________________________Caption_Control1000000010Lbl: Label 'SIGNATURE ..........................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        TAXABLE_PAYCaption_Control1000000001Lbl: Label 'TAXABLE PAY';
        TAXABLE_PAYCaptionLbl: Label 'TAXABLE PAY';
        TOTALSCaptionLbl: Label 'TOTALS';
        USERCaption_Control26Lbl: Label 'USER';
        USERCaptionLbl: Label 'USER';
        DeptFilter: Text[30];
        PayPeriodtext: Text[30];
        ProjFilter: Text[30];
        SecLocFilter: Text[30];
        SortBy: Text[30];
        NoFilter: Text[40];
        CoName: Text[80];

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            PayPeriodtext := PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
        end;
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Brackets";
        EndTax: Boolean;
        Tax: Decimal;
        TotalTax: Decimal;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := Round(AmountRemaining, 0.01);
        EndTax := false;

        TaxTable.SetRange("Table Code", TaxCode);

        if TaxTable.Find('-') then
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if Round((TaxableAmount), 0.01) > TaxTable."Upper Limit" then
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





