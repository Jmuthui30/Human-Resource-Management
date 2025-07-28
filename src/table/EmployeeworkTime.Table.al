table 52921 "Employee Work Time"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "No."; Code[100])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(HrSetUp."Payroll TimeSheet No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(1; "Employee No."; Code[200])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if AppEmployee.Get("Employee No.") then begin
                    "Employee Name" := AppEmployee.FullName();
                    "Job Position" := AppEmployee.Position;
                end;
            end;

        }
        field(114; Position; Text[2000])
        { }
        field(21; "Employee Name"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(52014; "Job Position"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Job Position';

            trigger OnValidate()
            begin
                if Jobs.Get("Job Position") then
                    "Job Position Title" := Jobs."Job Description";
            end;
        }
        field(52015; "Job Position Title"; Text[250])
        {
            Caption = 'Job Position Title';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = field("Job Position")));
        }
        field(29; "Total Working Days"; Integer) { }
        field(50009; "Payroll Period"; Date)
        {
            // FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(31; "Employee Total Personal Cost"; Decimal)
        {

        }
        field(39; "Employee Total Personal Cost1"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Employee Working  Line"."Amount Allocated ch" where("No." = field("No.")));
        }
        field(3; "Billable Time"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "GRAND TOTAL"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "SSHF SA1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; CARE; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "CA- Mayendit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Tear Fund"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "CA- Aweil"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; IMC; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "CARE Rubkona"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "SSHF RVA 4"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "DRA- SSJR"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "ECHO- Plan"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; EU; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "CARE-ADH"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; WHO; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; UNHCR; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "SSHF RVA 3"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "ERRM- Pochalla"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "SSHR RVA 2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "PLAN- Malakal"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Other; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; PSC; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(112; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }

    }

    keys
    {
        key(Key1; "Employee No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }





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

    var
        Dimensions: Record "Dimension Value";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Dates: Codeunit "Dates Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        myInt: Integer;
        Jobs: Record "Company Job";
        AppEmployee: Record Employee;

    procedure GetAge(var StartDate: Date) AgeText: Text[200]
    var
        HRDate: Codeunit "Dates Management";
    begin
        AgeText := '';
        if StartDate = 0D then
            StartDate := Today;
        AgeText := HRDate.DetermineAge(StartDate, Today);
    end;

}