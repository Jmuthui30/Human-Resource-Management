table 52141 "Payroll Requests"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Requests';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Applies; Option)
        {
            OptionCaption = 'All,Group,Specific';
            OptionMembers = All,Group,Specific;
            Caption = 'Applies';

            trigger OnValidate()
            begin
                InsertLines();
            end;
        }
        field(3; Group; Code[20])
        {
            TableRelation = "Employment Contract";
            Caption = 'Group';

            trigger OnValidate()
            begin
                InsertLines();
            end;
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Responsibility Center" := Emp."Responsibility Center";

                    if "Leave Allowance" then begin
                        //Leave Balance
                        LeavePeriod.SetRange(Closed, false);
                        if LeavePeriod.FindLast() then;

                        LeaveTypes.SetRange("Annual Leave", true);
                        if LeaveTypes.FindLast() then;

                        EmpCopy.Reset();
                        EmpCopy.Copy(Employee);
                        EmpCopy.SetRange("Leave Period Filter", LeavePeriod."Leave Period Code");
                        EmpCopy.SetRange("Leave Type Filter", LeaveTypes.Code);
                        EmpCopy.CalcFields("Leave Days Taken");
                        "Total Leave Days Taken" := EmpCopy."Leave Days Taken";
                    end;

                end;
            end;
        }
        field(5; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
        }
        field(6; Type; Option)
        {
            OptionCaption = ' ,Earning,Deduction';
            OptionMembers = " ",Earning,Deduction;
            Caption = 'Type';
        }
        field(7; "Code"; Code[20])
        {
            TableRelation = if (Type = const(Earning)) Earnings
            else
            if (Type = const(Deduction)) Deductions;
            Caption = 'Code';

            trigger OnValidate()
            begin
                case Type of
                    Type::Earning:
                        begin
                            if Earning.Get(Code) then;
                            "Code Descripton" := Earning.Description;
                            "Calculation Method" := Earning."Calculation Method";
                            Percentage := Earning.Percentage;
                            Formula := Earning.Formula;
                            Overtime := Earning.OverTime;
                            "Leave Allowance" := Earning."Leave Allowance";
                        end;
                    Type::Deduction:
                        begin
                            if Deduction.Get(Code) then;
                            "Code Descripton" := Deduction.Description;
                            "Calculation Method" := Deduction."Calculation Method";
                            Advance := Deduction.Advance;
                            if Advance then
                                "Advance Instalments" := 6; //Default months
                        end;
                end;
            end;
        }
        field(8; "Calculation Method"; Option)
        {
            OptionCaption = 'Flat amount,% of Basic pay,% of Gross pay,% of Insurance Amount,% of Taxable income,% of Basic after tax,Based on Hourly Rate,Based on Daily Rate,Formula';
            OptionMembers = "Flat amount","% of Basic pay","% of Gross pay","% of Insurance Amount","% of Taxable income","% of Basic after tax","Based on Hourly Rate","Based on Daily Rate",Formula;
            Caption = 'Calculation Method';
        }
        field(9; "Flat Amount"; Decimal)
        {
            Caption = 'Flat Amount';
        }
        field(10; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(11; Formula; Code[100])
        {
            Caption = 'Formula';
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(13; Units; Decimal)
        {
            Caption = 'Units';
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                Amount := PayrollMgt.PayrollRounding(Amount);

                if Advance then
                    Validate("Advance Instalments");
            end;
        }
        field(15; "Payroll Period"; Date)
        {
            TableRelation = "Payroll Period" where(Closed = const(false));
            Caption = 'Payroll Period';
        }
        field(16; Locum; Boolean)
        {
            Caption = 'Locum';
        }
        field(17; "Principal Employee Code"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Principal Employee Code';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then begin
                    "Principal Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Principal Employee Basic" := PayrollMgt.GetCurrentBasicPay("Principal Employee Code", "Payroll Period");
                end;
            end;
        }
        field(18; "Principal Employee Name"; Text[100])
        {
            Caption = 'Principal Employee Name';
        }
        field(19; "Principal Employee Basic"; Decimal)
        {
            Caption = 'Principal Employee Basic';
        }
        field(20; Hours; Decimal)
        {
            Caption = 'Hours';

            trigger OnValidate()
            begin
                Amount := ("Principal Employee Basic" * Hours / 30);
                Validate(Amount);
            end;
        }
        field(21; "Working Day Hours"; Decimal)
        {
            Caption = 'Weekday';

            trigger OnValidate()
            begin
                Earning.Get(Code);
                if Earning.OverTime then begin
                    Earning.TestField("Overtime Workday Factor");

                    Employee.Get("Employee No.");
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Basic Pay");

                    if "Non-Working Day Hours" <> 0 then
                        Amount := Amount + (((Employee."Basic Pay" / 22) / 8) * "Working Day Hours" * Earning."Overtime Workday Factor")
                    else
                        Amount := (((Employee."Basic Pay" / 22) / 8) * "Working Day Hours" * Earning."Overtime Workday Factor");

                    Validate(Amount);
                end;
            end;
        }
        field(22; Gratuity; Boolean)
        {
            Caption = 'Gratuity';

            trigger OnValidate()
            begin
                if Gratuity then
                    if Employee.Get("Employee No.") then begin
                        "Months Worked" := PayrollMgt.CalculateMonths(Employee."Contract Start Date", Employee."Contract End Date");
                        Amount := "Months Worked" * PayrollMgt.GetCurrentBasicPay("Employee No.", "Payroll Period") * Percentage / 100;
                        Validate(Amount);
                    end;
            end;
        }
        field(23; "Months Worked"; Integer)
        {
            Caption = 'Months Worked';
        }
        field(24; "Code Descripton"; Text[30])
        {
            Caption = 'Code Descripton';
        }
        field(25; "Special Condition"; Option)
        {
            OptionMembers = " ",Suspend,"Re-Instatement";
            Caption = 'Special Condition';
        }
        field(26; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(27; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Rejected,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Rejected,Approved,Posted;
            Caption = 'Status';
        }
        field(28; Overtime; Boolean)
        {
            Caption = 'Overtime';
        }
        field(29; "Non-Working Day Hours"; Decimal)
        {
            Caption = 'Weekend/Holiday';

            trigger OnValidate()
            begin
                Earning.Get(Code);
                if Earning.OverTime then begin
                    Earning.TestField("Overtime Non Working Factor");

                    Employee.Get("Employee No.");
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Basic Pay");

                    if "Working Day Hours" <> 0 then
                        Amount := Amount + (((Employee."Basic Pay" / 22) / 8) * "Non-Working Day Hours" * Earning."Overtime Non Working Factor")
                    else
                        Amount := (((Employee."Basic Pay" / 22) / 8) * "Non-Working Day Hours" * Earning."Overtime Non Working Factor");

                    Validate(Amount);
                end;
            end;
        }
        field(30; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(31; "Leave Allowance"; Boolean)
        {
            Caption = 'Leave Allowance';
        }
        field(32; "Leave Application Document"; Code[50])
        {
            TableRelation = "Leave Application"."Application No" where("Employee No" = field("Employee No."), Status = const(Released), "Leave Allowance Payable" = const(true));
            Caption = 'Leave Application Document';
        }
        field(33; "Total Leave Days Taken"; Decimal)
        {
            Caption = 'Total Leave Days Taken';

            trigger OnValidate()
            begin
                Earning.Get(Code);
                if Earning."Leave Allowance" then begin
                    Employee.Get("Employee No.");
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Basic Pay");

                    Amount := Employee."Basic Pay" * (Earning.Percentage / 100);
                    Validate(Amount);
                end;
            end;
        }
        field(34; "Date of Activity"; Date)
        {
            Caption = 'Date of Activity';
        }
        field(35; "Responsibility Center"; Code[100])
        {
            Caption = 'Responsibility Centre';
            TableRelation = "Responsibility Center".Code;

        }
        field(36; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
        }
        field(37; "Posted At"; DateTime)
        {
            Caption = 'Posted At';
        }
        field(38; "Advance Disbursed"; Boolean)
        {
            Caption = 'Advance Disbursed';
        }
        field(39; "Advance Disbursed By"; Code[50])
        {
            Caption = 'Advance Disbursed By';
        }
        field(40; "Advance Disbursed At"; DateTime)
        {
            Caption = 'Advance Disbursed At';
        }
        field(41; Advance; Boolean)
        {
            Caption = 'Advance';
            DataClassification = ToBeClassified;
        }
        field(42; "Advance Instalments"; Decimal)
        {
            Caption = 'Advance Instalments';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Advance Instalments" > 0 then begin
                    if Amount > 0 then
                        "Monthly Repayment" := Round(Amount / "Advance Instalments")
                    else
                        "Monthly Repayment" := 0;
                end else
                    "Monthly Repayment" := 0;
            end;
        }
        field(43; "Monthly Repayment"; Decimal)
        {
            Caption = 'Monthly Repayment';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        HRSetup: Record "Human Resources Setup";
        PayrollRequests: Record "Payroll Requests";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeNotExistErr: Label 'Employee with %1 ID has not been setup. Kindly contact HR';
        UtilizeOpenDocumentsErr: Label 'Kindly utilize all your open documents before creating a new request';
    begin
        PayrollRequests.Reset();
        PayrollRequests.SetRange("Created By", UserId);
        PayrollRequests.SetFilter(Status, '%1', PayrollRequests.Status::Open);
        if PayrollRequests.Count >= 1 then
            Error(UtilizeOpenDocumentsErr);

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Payroll Req Nos");
            NoSeriesMgt.InitSeries(HRSetup."Payroll Req Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Payroll Period" := PayrollMgt.GetCurrentPayPeriodDate();

        "Created By" := UserId;

        Emp.Reset();
        Emp.SetRange("User ID", UserId);
        if Emp.FindFirst() then
            Validate("Employee No.", Emp."No.")
        else
            Error(EmployeeNotExistErr);
    end;

    var
        AssingMatrix: Record "Assignment Matrix";
        Deduction: Record Deductions;
        Earning: Record Earnings;
        Emp: Record Employee;
        EmpCopy: Record Employee;
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeavePeriod: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        PayrollMgt: Codeunit Payroll;

    procedure Calculate(EmpNo: Code[30]) Amt: Decimal
    var
        Formula1: Code[50];
    begin

        case "Calculation Method" of
            "Calculation Method"::"Flat amount":
                Amt := "Flat Amount";

            // % Of Basic Pay
            "Calculation Method"::"% of Basic pay":
                begin
                    if Employee.Get(EmpNo) then
                        Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Basic Pay", "Basic Arrears");
                    if Employee.FindFirst() then begin
                        Amt := Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");

                        Amt := AssingMatrix.PayrollRounding(Amt);
                    end;
                end;

            // % Of Basic after Tax
            "Calculation Method"::"% of Basic after tax":

                if HRSetup."Company overtime hours" <> 0 then
                    Amt := AssingMatrix.PayrollRounding(Amt);

            // Based on Hourly Rate
            "Calculation Method"::"Based on Hourly Rate":
                ;
            /*
Amount:="No. of Units"*Employee."Driving Licence"*"Overtime Factor";
if "Overtime Factor"<>0 then
Amount:="No. of Units"*Employee."Driving Licence"*"Overtime Factor";
Amount:=PayrollRounding(Amount);
*/

            // Based on Daily Rate
            "Calculation Method"::"Based on Daily Rate":
                ;
            /*
Amount:=Employee."Driving Licence"*Employee."days worked";
Amount:=PayrollRounding(Amount);
*/

            // % Of Insurance Amount
            "Calculation Method"::"% of Insurance Amount":
                begin
                    Employee.SetRange("No.", EmpNo);
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Insurance Premium");
                    Amt := Abs((Percentage / 100) * (Employee."Insurance Premium"));
                    Amt := AssingMatrix.PayrollRounding(Amt);
                end;

            // % F Gross Pay
            "Calculation Method"::"% of Gross pay":
                begin
                    Employee.SetRange("No.", "Employee No.");
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Basic Pay", "Total Allowances");
                    Amt := ((Percentage / 100) * (Employee."Total Allowances"));
                    Amt := AssingMatrix.PayrollRounding(Amt);
                end;

            // % of Taxable Income
            "Calculation Method"::"% of Taxable income":
                begin
                    Employee.SetRange("No.", EmpNo);
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Employee.CalcFields("Taxable Allowance");
                    Amt := ((Percentage / 100) * (Employee."Taxable Allowance"));
                    Amt := AssingMatrix.PayrollRounding(Amt);
                end;


            //Formula
            "Calculation Method"::Formula:
                begin
                    Employee.SetRange("No.", EmpNo);
                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                    Formula1 := PayrollMgt.GetPureFormula(EmpNo, "Payroll Period", Formula);
                    Amt := PayrollMgt.GetResult(Formula1);

                end;

        end;
        exit(Amt)

    end;

    procedure InsertLines()
    var
        PayRequestLines: Record "Payroll Request Lines";
    begin
        PayRequestLines.Reset();
        PayRequestLines.SetRange("No.", "No.");
        PayRequestLines.DeleteAll();
        case Applies of
            Applies::All:
                begin
                    Employee.Reset();
                    Employee.SetRange(Status, Employee.Status::Active);
                    if Employee.FindFirst() then
                        repeat
                            PayRequestLines.Init();
                            PayRequestLines."No." := "No.";
                            PayRequestLines."Employee No." := Employee."No.";
                            PayRequestLines."Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            PayRequestLines."Previous Value" := 0;
                            PayRequestLines.Insert();
                        until Employee.Next() = 0;
                end;
            Applies::Group:
                begin
                    Employee.Reset();
                    Employee.SetRange(Status, Employee.Status::Active);
                    Employee.SetRange("Nature of Employment", Group);
                    if Employee.FindFirst() then
                        repeat
                            PayRequestLines.Init();
                            PayRequestLines."No." := "No.";
                            PayRequestLines."Employee No." := Employee."No.";
                            PayRequestLines."Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            PayRequestLines."Previous Value" := 0;
                            PayRequestLines.Insert();
                        until Employee.Next() = 0;
                end
        end;
    end;

    procedure UpdateChange()
    var
        PayRequestLines: Record "Payroll Request Lines";
    begin
        if Applies = Applies::Specific then
            Amount := Calculate("Employee No.")
        else begin
            InsertLines();
            PayRequestLines.Reset();
            PayRequestLines.SetRange("No.", "No.");
            if PayRequestLines.FindFirst() then
                repeat
                    PayRequestLines."New Value" := Calculate(PayRequestLines."Employee No.");
                    PayRequestLines."Previous Value" := PayrollMgt.GetCurrentPay(PayRequestLines."Employee No.", "Payroll Period", Code);
                    PayRequestLines.Modify();
                until PayRequestLines.Next() = 0;
        end;
    end;
}





