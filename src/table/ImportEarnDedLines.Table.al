table 52147 "Import Earn & Ded Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Import Earn & Ded Lines';
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin

                if Employee.Get("Employee No") then
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                Amount := Payroll.PayrollRounding(Amount);
            end;
        }
    }

    keys
    {
        key(Key1; No, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        Payroll: Codeunit Payroll;
}





