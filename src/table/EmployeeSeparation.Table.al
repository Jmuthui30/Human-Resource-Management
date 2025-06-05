table 52171 "Employee Separation"
{
    Caption = 'Employee Separation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get();
                    HRSetup.TestField("Employee Separation Nos");
                    NoSeriesMgt.TestManual(HRSetup."Employee Separation Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; "Separation Type"; Enum "Employee Separation Type")
        {
            Caption = 'Separation Type';
        }
        field(4; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            TableRelation = if ("Separation Type" = filter("Re-Engagement" | "Re-Instatement")) Employee."No." where(Status = filter(Inactive | Terminated))
            else
            Employee."No." where(Status = const(Active));

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
                "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                PayPeriod.Reset();
                PayPeriod.SetRange(PayPeriod."Close Pay", false);
                if PayPeriod.FindFirst() then begin
                    EmpCopy.Copy(Employee);
                    EmpCopy.SetRange("Pay Period Filter", PayPeriod."Starting Date");
                    EmpCopy.CalcFields("Basic Pay");
                    "Current Basic Pay" := EmpCopy."Basic Pay";
                end;

                //Leave Balance
                LeavePeriod.SetRange(Closed, false);
                if LeavePeriod.FindLast() then;

                LeaveTypes.SetRange("Annual Leave", true);
                if LeaveTypes.FindLast() then;

                EmpCopy.Reset();
                EmpCopy.Copy(Employee);
                EmpCopy.SetRange("Leave Period Filter", LeavePeriod."Leave Period Code");
                EmpCopy.SetRange("Leave Type Filter", LeaveTypes.Code);
                EmpCopy.CalcFields("Leave Balance");
                "Annual Leave Balance" := EmpCopy."Leave Balance";

                "Leave Liability" := HRMgt.GetLeaveLiability(Employee, "Leave Earned To Date");

                Deductions.Reset();
                Deductions.SetRange("Pension Scheme", true);
                if Deductions.FindFirst() then begin
                    Deductions.SetRange("Employee Filter", Employee."No.");
                    Deductions.CalcFields("Total Amount", "Total Amount Employer");

                    "Provident Fund - Employee" := Deductions."Total Amount";
                    "Provident Fund - Employer" := Deductions."Total Amount Employer";
                end;
            end;
        }
        field(5; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(8; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(9; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(10; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Termination Code';
            TableRelation = "Grounds for Termination";
        }
        field(11; Comments; Text[100])
        {
            Caption = 'Comments';
        }
        field(12; "Current Basic Pay"; Decimal)
        {
            Caption = 'Current Basic Pay';
            Editable = false;
        }
        field(13; "Annual Leave Balance"; Decimal)
        {
            Caption = 'Annual Leave Balance';
            Editable = false;
        }
        field(14; "Leave Liability"; Decimal)
        {
            Caption = 'Leave Liability';
            Editable = false;
        }
        field(15; "Leave Earned To Date"; Decimal)
        {
            Caption = 'Leave Earned To Date';
            Editable = false;
        }
        field(16; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
        }
        field(17; "Provident Fund - Employee"; Decimal)
        {
            Editable = false;
            Caption = 'Provident Fund - Employee';
        }
        field(18; "Provident Fund - Employer"; Decimal)
        {
            Editable = false;
            Caption = 'Provident Fund - Employer';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        Deductions: Record Deductions;
        EmpCopy, Employee : Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeavePeriod: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        PayPeriod: Record "Payroll Period";
        HRMgt: Codeunit "HR Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Employee Separation Nos");
            NoSeriesMgt.InitSeries(HRSetup."Employee Separation Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Document Date" := Today;
        "Created By" := UserId;
    end;
}






