table 52182 "Employee Working sch Line New"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[100])
        { }
        field(14; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if AppEmployee.Get("Employee No") then begin
                    "Employee Name" := AppEmployee.FullName();
                    Position := AppEmployee.Position;
                end;
            end;
        }

        field(2; "Payroll Period"; Date)
        {
            NotBlank = false;
            TableRelation = "Payroll Period"."Starting Date";

            ValidateTableRelation = true;
            Caption = 'Payroll Period';

            trigger OnValidate()
            begin

                if PayPeriod.Get("Payroll Period") then
                    "Pay Period" := PayPeriod.Name;
            end;
        }
        field(3; "Employee Name"; Text[2000])
        {

        }
        field(4; Position; Text[2000])
        { }
        field(5; "Donor Code"; Code[1000])
        {
            Caption = 'Donor Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(6; "Project Code"; Code[1000])
        {
            Caption = 'Project Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(7; "Billable Time"; Integer)
        { }
        field(8; "Work Date"; Date)
        {

            trigger OnValidate()
            begin
                ValidateWorkDate();
            end;
        }
        field(13; "Pay Period"; Text[30])
        {
            Caption = 'Pay Period';
        }
        field(10; "Line No."; Integer)
        {

        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
        key(key2; "Employee No", "Work Date", "Line No.") { }
        key(key3; "Payroll Period", "Employee No") { }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        AppEmployee: Record Employee;
        PayPeriod: Record "Payroll Period";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HrSetUp: Record "Human Resources Setup";
        EmployeeWorkingSchedule: Record "Employee Working Schedule";
        EmployeeWorkingSchLine: Record "Employee Working sch Line New";

    trigger OnInsert()
    begin


        // Initialize numbering for header if blank
        IF "No." = '' THEN BEGIN
            HrSetUp.GET;
            HrSetUp.TESTFIELD(HrSetUp."Payroll TimeSheet No.");
            NoSeriesMgt.InitSeries(HrSetUp."Payroll TimeSheet No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        // Auto-increment Line No.
        if "Line No." = 0 then begin
            EmployeeWorkingSchLine.Reset();
            EmployeeWorkingSchLine.SetRange("No.", "No.");
            if EmployeeWorkingSchLine.FindLast() then
                "Line No." := EmployeeWorkingSchLine."Line No." + 1
            else
                "Line No." := 1;

            // GetNextLineNo("No.");
        end;

        // Copy header information
        EmployeeWorkingSchedule.Reset();
        EmployeeWorkingSchedule.SetRange(EmployeeWorkingSchedule."No.", "No.");
        if EmployeeWorkingSchedule.FindFirst() then begin
            "Employee No" := EmployeeWorkingSchedule."Employee No";
            "Employee Name" := EmployeeWorkingSchedule."Employee Name";
            "Payroll Period" := EmployeeWorkingSchedule."Payroll Period";
            "Pay Period" := EmployeeWorkingSchedule."Pay Period";
        end;

        ValidateWorkDate()
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetNextLineNo(DocumentNo: Code[100]): Integer
    var
        Line: Record "Employee Working sch Line New";
    begin
        Line.SetRange("No.", DocumentNo);
        if Line.FindLast() then
            exit(Line."Line No." + 10000);
        exit(10000);
    end;

    procedure ValidateWorkDate()
    var
        Line: Record "Employee Working sch Line New";
    begin
        if "Work Date" = 0D then exit;

        Line.SetRange("No.", "No.");
        Line.SetRange("Employee No", "Employee No");
        Line.SetRange("Work Date", "Work Date");
        if Line.FindFirst() then
            if Line."Line No." <> "Line No." then
                Error('Work date %1 already exists for this employee', "Work Date");
    end;

}