table 52137 "Employee Payroll Cue"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Payroll Cue';
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "All Employees"; Integer)
        {
            CalcFormula = count(Employee);
            FieldClass = FlowField;
            Caption = 'All Employees';
        }
        field(3; "Board Employees"; Integer)
        {
            Caption = 'Board Members';
            CalcFormula = count(Employee where(Status = const(Active),
                                                "Employee Type" = const("Board Member")));
            FieldClass = FlowField;
        }
        field(4; "Active Employees"; Integer)
        {
            Caption = 'Active Employees';
            CalcFormula = count(Employee where(Status = const(Active),
                                                "Employee Type" = filter(<> "Board Member")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





