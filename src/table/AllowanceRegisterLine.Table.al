table 52157 "Allowance Register Line"
{
    DataClassification = CustomerContent;
    Caption = 'Allowance Register Line';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = if ("Employee Type" = const("Board Member")) Employee where("Employee Type" = const("Board Member"), Status = const(Active))
            else
            if ("Employee Type" = const("Staff")) Employee where("Employee Type" = filter(<> "Board Member"), Status = const(Active));

            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                "Employee Name" := '';
                if Employee.Get("Employee No.") then begin
                    Employee.TestField("Vendor No.");
                    "Employee Name" := Employee.FullName();
                end;

                case "Employee Type" of
                    "Employee Type"::"Board Member":
                        begin
                            "No of sittings" := 1;
                            Validate("No of sittings");
                        end;
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(4; "No of sittings"; Integer)
        {
            Caption = 'No of sittings';

            trigger OnValidate()
            begin
                if "No of sittings" > 0 then
                    Validate("Net Amount", ("No of sittings" * Rate));
            end;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Gross Amount';

            trigger OnValidate()
            begin
                //Commented because calculation based on net amount

                /* HRSetup.Get();
                HRSetup.TestField("Secondary PAYE %");

                if Amount > 0 then begin
                    EarningX.Get("Earning Code");
                    if EarningX.Taxable then
                        "PAYE Amount" := (Amount - EarningX."Tax Free Amount") * (HRSetup."Secondary PAYE %" / 100)
                    else
                        "PAYE Amount" := 0;
                end else
                    "PAYE Amount" := 0;

                "Net Amount" := Amount - "PAYE Amount"; */
            end;
        }
        field(6; "Payroll Period"; Date)
        {
            TableRelation = "Payroll Period";
            Caption = 'Payroll Period';
        }
        field(7; "PAYE Amount"; Decimal)
        {
            Caption = 'PAYE Amount';
        }
        field(8; "Employee Type"; Option)
        {
            Caption = 'Employee Type';
            OptionCaption = ' ,Staff,Board Member';
            OptionMembers = " ","Staff","Board Member";
        }
        field(10; "Earning Code"; Code[20])
        {
            TableRelation = Earnings.Code;
            Caption = 'Earning Code';

            trigger OnValidate()
            var
                Earnings: Record Earnings;
            begin
                Earnings.Get("Earning Code");
                If Earnings."Account No." = '' then
                    Message('G/L a/c not provided on earnings setup, kindly input manually');

                "Earning Description" := Earnings.Description;
                "Account Type" := Earnings."Account Type";
                "Account No." := Earnings."Account No.";
                "Earnings Calculation Method" := Earnings."Calculation Method";

                if "Employee Type" = "Employee Type"::Staff then
                    case "Earnings Calculation Method" of
                        "Earnings Calculation Method"::"Based on Salary Scale":
                            begin
                                SalaryScale.Reset();
                                SalaryScale.SetRange(Scale, HRManagement.GetEmployeeJobGroup("Employee No."));
                                if SalaryScale.FindFirst() then begin
                                    SalaryScaleAllowance.Reset();
                                    SalaryScaleAllowance.SetRange("Salary Scale", SalaryScale.Scale);
                                    SalaryScaleAllowance.SetRange("Earning Code", "Earning Code");
                                    if SalaryScaleAllowance.FindFirst() then begin
                                        "No of sittings" := 1;
                                        Rate := SalaryScaleAllowance.Amount;
                                        Validate("Net Amount", ("No of sittings" * Rate));
                                    end;
                                end;
                            end;
                    end;
            end;
        }
        field(11; "Earning Description"; Text[100])
        {
            Caption = 'Earning Description';
            Editable = false;
        }
        field(12; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';

            trigger OnValidate()
            var
                GrossAmt, TaxableAmt : Decimal;
            begin
                GrossAmt := 0;
                TaxableAmt := 0;

                HRSetup.Get();
                HRSetup.TestField("Secondary PAYE %");

                if "Net Amount" > 0 then begin
                    EarningX.Get("Earning Code");
                    if EarningX.Taxable then begin
                        case "Employee Type" of
                            //Tax for staff is calculated on net amount
                            "Employee Type"::Staff:
                                begin
                                    if EarningX."Tax Free Amount" > 0 then
                                        "PAYE Amount" := ("Net Amount" - EarningX."Tax Free Amount") * (HRSetup."Secondary PAYE %" / 100)
                                    else
                                        "PAYE Amount" := "Net Amount" * (HRSetup."Secondary PAYE %" / 100);
                                    GrossAmt := "Net Amount" + "PAYE Amount";
                                end;
                            //Tax for Board members is calculated on gross amount
                            "Employee Type"::"Board Member":
                                begin
                                    GrossAmt := "Net Amount" * (100 / (100 - HRSetup."Secondary PAYE %"));

                                    if EarningX."Tax Free Amount" > 0 then begin
                                        TaxableAmt := ("Net Amount" - EarningX."Tax Free Amount") / (1 - (HRSetup."Secondary PAYE %" / 100));
                                        "PAYE Amount" := TaxableAmt * (HRSetup."Secondary PAYE %" / 100);
                                        GrossAmt := TaxableAmt + EarningX."Tax Free Amount";
                                    end else
                                        "PAYE Amount" := GrossAmt - "Net Amount";
                                end;
                        end;
                        Validate(Amount, GrossAmt);
                    end else begin
                        Validate(Amount, "Net Amount");
                        "PAYE Amount" := 0;
                    end;
                end else begin
                    "PAYE Amount" := 0;
                    Amount := 0;
                end;
            end;
        }
        field(13; Rate; Decimal)
        {
            Caption = 'Rate(Exclusive Tax)';
            trigger OnValidate()
            begin
                if Rate > 0 then
                    Validate("Net Amount", (Rate * "No of sittings"));
            end;
        }
        field(14; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(15; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee;
            Caption = 'Account No.';
        }
        field(16; "Destination Code"; Code[20])
        {
            Caption = 'Destination Code';
            TableRelation = Destination."Destination Code";
            trigger OnValidate()
            begin
                if "Employee Type" = "Employee Type"::Staff then
                    case "Earnings Calculation Method" of
                        "Earnings Calculation Method"::"Based on Travel Rates":
                            begin
                                Destination.Reset();
                                Destination.SetRange("Destination Code", "Destination Code");
                                if Destination.FindFirst() then begin
                                    DestinationRate.Reset();
                                    DestinationRate.SetRange("Destination Code", Destination."Destination Code");
                                    DestinationRate.SetRange("Employee Job Group", HRManagement.GetEmployeeJobGroup("Employee No."));
                                    DestinationRate.SetRange("Payment Type", DestinationRate."Payment Type"::Earning);
                                    DestinationRate.SetRange("Advance Code", "Earning Code");
                                    if DestinationRate.FindFirst() then begin
                                        "No of sittings" := 1;
                                        Rate := DestinationRate."Daily Rate (Amount)";
                                        Validate("Net Amount", (Rate * "No of sittings"));
                                    end;
                                end;
                            end;
                    end;
            end;
        }
        field(17; "Date of Activity"; Date)
        {
            Caption = 'Date of Activity';
        }
        field(18; Remarks; Text[50])
        {
            Caption = 'Remarks';
        }
        field(19; "Earnings Calculation Method"; Option)
        {
            Caption = 'Calculation Method';
            OptionCaption = 'Flat amount,% of Basic pay,% of Gross pay,% of Insurance Amount,% of Taxable income,% of Basic after tax,Based on Hourly Rate,Based on Daily Rate,Formula,% of Annual Basic,% of Other Earnings,% of Mortgage Amount,Based on Salary Scale,Based on Travel Rates,% of NHIF Amount';
            OptionMembers = "Flat amount","% of Basic pay","% of Gross pay","% of Insurance Amount","% of Taxable income","% of Basic after tax","Based on Hourly Rate","Based on Daily Rate",Formula,"% of Annual Basic","% of Other Earnings","% of Mortgage Amount","Based on Salary Scale","Based on Travel Rates","% of NHIF Amount";
        }
        field(20; Posted; Boolean)
        {
            Caption = 'Posted';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Employee Type", "Employee No.", "Earning Code", "Date of Activity")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if AllowanceRec.Get("Document No.") then
            "Payroll Period" := AllowanceRec."Payroll Period"
        else
            "Payroll Period" := Payroll.GetCurrentPayPeriodDate();
    end;

    var
        AllowanceRec: Record "Allowance Register";
        Destination: Record Destination;
        DestinationRate: Record "Destination Rate Entry";
        EarningX: Record Earnings;
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        SalaryScale: Record "Salary Scale";
        SalaryScaleAllowance: Record "Salary Scale Allowance";
        HRManagement: Codeunit "HR Management";
        Payroll: Codeunit Payroll;
}





