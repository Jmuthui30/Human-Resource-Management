table 52036 "Employee Transfers"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Transfers';
    fields
    {
        field(1; "Transfer No"; Code[30])
        {
            Caption = 'Transfer No';
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Employee No';

            trigger OnValidate()
            begin

                if Employee.Get("Employee No") then begin
                    "Employee No" := Employee."No.";
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Job Group" := Employee."Salary Scale";
                    "Mobile No" := Employee."Mobile Phone No.";
                    "Shortcut Dimension 2" := Employee."Global Dimension 2 Code";
                    "Length of Stay" := Dates.DetermineAge(Employee."Date Of Join", Today);
                    "Job Position" := Employee."Job Position";
                end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(4; "Mobile No"; Text[15])
        {
            Caption = 'Mobile No';
        }
        field(5; "Job Group"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'Job Group';
        }
        field(6; "Current Station"; Code[20])
        {
            TableRelation = Dimension.Name;
            Caption = 'Current Station';
        }
        field(7; "Sub County"; Code[20])
        {
            Caption = 'Sub County';
        }
        field(8; County; Code[20])
        {
            Caption = 'County';
        }
        field(9; "Length of Stay"; Text[100])
        {
            Caption = 'Length of Stay';
        }
        field(10; "Station To Transfer"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value" where("Global Dimension No." = const(2));
            Caption = 'Station To Transfer';

            trigger OnValidate()
            begin

                Dimensions.Reset();
                Dimensions.SetRange(Code, "Station To Transfer");
                if Dimensions.Find('-') then
                    "Transfer Department Name" := Dimensions.Name;
            end;
        }
        field(11; "Reason of Transfer"; Text[250])
        {
            Caption = 'Reason of Transfer';
        }
        field(12; "HOD Recommendations"; Text[250])
        {
            Caption = 'HOD Recommendations';
        }
        field(13; "HOD Name"; Text[30])
        {
            Caption = 'HOD Name';
        }
        field(14; "HOD Employee No"; Code[10])
        {
            TableRelation = Employee."No.";
            Caption = 'HOD Employee No';

            trigger OnValidate()
            begin

                Employee.Reset();
                Employee.SetRange("No.", "HOD Employee No");
                if Employee.Find('-') then
                    "HOD Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(15; Date; Date)
        {
            Caption = 'Date';
        }
        field(16; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
        }
        field(17; "Transfer Type"; Option)
        {
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            Caption = 'Transfer Type';
        }
        field(18; "No Series"; Code[30])
        {
            Caption = 'No Series';
        }
        field(19; "Shortcut Dimension 1"; Code[10])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value" where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1';
        }
        field(20; "Shortcut Dimension 2"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value" where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2';
        }
        field(21; "Department Name"; Text[60])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 2")));
            FieldClass = FlowField;
            Caption = 'Department Name';
        }
        field(22; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Released';
            OptionMembers = New,"Pending Approval",Released;
            Caption = 'Status';
        }
        field(23; "Transfer Department Name"; Text[60])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Station To Transfer")));
            FieldClass = FlowField;
            Caption = 'Transfer Department Name';
        }
        field(24; Company; Text[30])
        {
            TableRelation = Company;
            Caption = 'Company';
        }
        field(25; "Job Position"; Code[50])
        {
            Caption = 'Job Position';
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";
        }
        field(26; "New Job Position"; Code[50])
        {
            Caption = 'New Job Position';
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";
        }
        field(27; "Job Position Title"; Text[250])
        {
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = field("Job Position")));
            Caption = 'Job Position Title';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Company Job";
        }
        field(28; "New Job Position Title"; Text[250])
        {
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = field("New Job Position")));
            Caption = 'New Job Position Title';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Company Job";
        }
    }

    keys
    {
        key(Key1; "Transfer No", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Transfer No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Transfer Nos");
            NoSeriesMgt.InitSeries(HRSetup."Transfer Nos", xRec."No Series", 0D, "Transfer No", "No Series");
        end;

        Date := Today;
    end;

    var
        Dimensions: Record "Dimension Value";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Dates: Codeunit "Dates Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;

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





