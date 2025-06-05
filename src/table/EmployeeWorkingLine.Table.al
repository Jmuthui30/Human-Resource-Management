table 52919 "Employee Working  Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "No."; Code[100])
        { }


        field(19; "Payroll Period"; Date)
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


        field(5; "Donor Code"; Code[1000])
        {
            Caption = 'Donor Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(1; "Project Code"; Code[1000])
        {
            Caption = 'Project Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(8; "Amount Allocated"; Date)

        { }
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
        field(118; "Amount Allocated ch"; Decimal)
        { }
        field(123; "Employee No."; Code[200])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                // if AppEmployee.Get("Employee No.") then begin

                // en;d
            end;

        }
    }

    keys
    {
        key(Key1; "Project Code", "No.")
        {
            Clustered = true;
        }
        key(key2; "Line No.")
        { }
        key(key3; "Employee No.")
        { }
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

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HrSetUp.GET;
            HrSetUp.TESTFIELD(HrSetUp."Payroll TimeSheet No.");
            NoSeriesMgt.InitSeries(HrSetUp."Payroll TimeSheet No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        // "Line No." := "Line No." + 1;
        // EmployeeWorkingSchedule.Reset();
        // EmployeeWorkingSchedule.SetRange(EmployeeWorkingSchedule."No.", "No.");
        // if EmployeeWorkingSchedule.Find('-') then begin
        //     "Employee No" := EmployeeWorkingSchedule."Employee No";
        //     "Employee Name" := EmployeeWorkingSchedule."Employee Name";
        //     "Payroll Period" := EmployeeWorkingSchedule."Payroll Period";
        //     "Pay Period" := EmployeeWorkingSchedule."Pay Period";

        // end;

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

}