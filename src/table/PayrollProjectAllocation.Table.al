Table 52908 "Payroll Project Allocation"
{

    fields
    {
        field(1; Period; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Period"."Pay Date";
            //TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(2; "Employee No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            //TableRelation = "Payroll Employee_AU";

            trigger OnValidate()
            begin
                if HREmployees.Get("Employee No") then
                    "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECT'));
        }
        field(5; Allocation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Line Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DONOR'));
        }
    }

    keys
    {
        key(Key1; Period, "Project Code", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmployees: Record Employee;
}

