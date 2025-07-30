table 52183 "Employee Working Schedule N"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(14; "No."; Code[100])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(HrSetUp."Payroll TimeSheet No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(1; "Employee No"; Code[30])
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
        { }
        field(13; "Pay Period"; Text[30])
        {
            Caption = 'Pay Period';
        }
        field(10; "Line No."; Integer)
        {

        }
        field(11; "Total Billable Time"; Integer)
        {


            trigger OnValidate()
            begin

            end;

        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(17; "Total Billable Time new"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Working sch Line N" WHERE("No." = FIELD("No."), "Billable Time" = FILTER(> 1)));
            Caption = 'Total Billable Time ';
            trigger OnValidate()
            begin

            end;

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(key2; "Employee No")
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

    trigger OnInsert()
    begin
        HrSetUp.Get();
        HrSetUp.TestField("Payroll TimeSheet No.");
        if "No." = '' then
            NoSeriesMgt.InitSeries(HrSetUp."Payroll TimeSheet No.", xRec."No. Series", 0D, "No.", "No. Series");
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