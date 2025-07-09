table 52926 "Cash Payment"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then
                    "Employee Name" := Employee.Name;
            end;
        }
        field(7; "Payroll Period"; Date)
        {
            NotBlank = false;
            TableRelation = "Payroll Period"."Starting Date";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            Caption = 'Payroll Period';
        }
        field(3; "Employee Name"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Cash Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Close; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Open,Close;
        }
        field(11; "Location"; Code[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = Region.Code;

        }

    }

    keys
    {
        key(Key1; "Employee No", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        Employee: Record Employee;

    trigger OnInsert()
    begin

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