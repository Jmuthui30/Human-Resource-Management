table 52071 "Employee Contracts"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Contracts';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Contract Type"; Code[10])
        {
            TableRelation = "Employment Contract";
            Caption = 'Contract Type';

            trigger OnValidate()
            begin

                if Contract.Get("Contract Type") then
                    Tenure := Contract.Tenure;
            end;
        }
        field(3; Tenure; DateFormula)
        {
            Caption = 'Tenure';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin

                if "Start Date" > Today then
                    Error('You cannot enter a date Later than today');

                "End Date" := CalcDate(Tenure, "Start Date");
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; "Employee No"; Code[20])
        {
            TableRelation = Employee where("Employment Type" = filter(Contract));
            Caption = 'Employee No';

            trigger OnValidate()
            begin

                if Employee.Get("Employee No") then
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(7; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(8; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(9; Date; Date)
        {
            Caption = 'Date';
        }
        field(10; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Released';
            OptionMembers = Open,"Pending Approval",Released;
            Caption = 'Status';
        }
        field(11; "User ID"; Code[20])
        {
            Caption = 'User ID';
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
    begin

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Contract Nos");
            NoSeriesMgt.InitSeries(HRSetup."Contract Nos", xRec."Employee Name", 0D, "No.", "No Series");
        end;

        Date := Today;
        "User ID" := CopyStr(UserId, 1, 20);
    end;

    var
        Employee: Record Employee;
        Contract: Record "Employment Contract";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





