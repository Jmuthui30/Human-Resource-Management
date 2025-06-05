table 52146 "Import Earn & Ded Header"
{
    DataClassification = CustomerContent;
    Caption = 'Import Earn & Ded Header';
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Type; Enum "Payroll Transaction Type")
        {
            Caption = 'Type';
        }
        field(3; "Code"; Code[20])
        {
            TableRelation = if (Type = filter(Earning)) Earnings
            else
            if (Type = filter(Deduction)) Deductions
            else
            if (Type = filter(Loan)) "Loan Product Type-Payroll";
            Caption = 'Code';

            trigger OnValidate()
            begin

                if Earnings.Get(Code) then
                    Description := Earnings.Description;

                if Deductions.Get(Code) then
                    Description := Deductions.Description;

                if LoanProd.Get(Code) then
                    Description := LoanProd.Description;
            end;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(5; "Pay Period"; Date)
        {
            TableRelation = "Payroll Period";
            Caption = 'Pay Period';

            trigger OnValidate()
            begin

                PayPeriod.Reset();
                PayPeriod.SetRange(Closed, false);
                if PayPeriod.FindFirst() then
                    if "Pay Period" <> PayPeriod."Starting Date" then
                        if "Pay Period" > PayPeriod."Starting Date" then
                            Error('Kindly close the previous periods before Posting');

                if PayPeriod.Get("Pay Period") then
                    if PayPeriod.Closed = true then
                        Error('The specified period %1 is closed', "Pay Period");

                PayPeriodText := Format("Pay Period", 0, '<Month Text> <Year4>');
                "Pay Period Text" := PayPeriodText;
            end;
        }
        field(6; "Pay Period Text"; Text[30])
        {
            Caption = 'Pay Period Text';
        }
        field(7; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open,"Pending Approval",Released;
            Caption = 'Status';
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(11; Total; Decimal)
        {
            CalcFormula = sum("Import Earn & Ded Lines".Amount where(No = field(No)));
            FieldClass = FlowField;
            Caption = 'Total';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        HRSetup.Get();
        NoSeriesMgt.InitSeries(HRSetup."Payroll Import Nos", xRec.No, 0D, No, "No. Series");
        Date := Today;
        "User ID" := UserId;
    end;

    var
        Deductions: Record Deductions;
        Earnings: Record Earnings;
        HRSetup: Record "Human Resources Setup";
        LoanProd: Record "Loan Product Type-Payroll";
        PayPeriod: Record "Payroll Period";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PayPeriodText: Text;
}





