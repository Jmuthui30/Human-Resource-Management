table 52150 "Loan Interest Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Interest Lines';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Loan No."; Code[20])
        {
            TableRelation = "Payroll Loan Application"."Loan No" where("Loan Status" = filter(Issued));
            Caption = 'Loan No.';
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    Employee.TestField(Employee."Debtor Code");
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Debtor Code" := Employee."Debtor Code";
                end;
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(6; "Period Reference"; Date)
        {
            TableRelation = "Payroll Period"."Starting Date";
            Caption = 'Period Reference';

            trigger OnValidate()
            begin
            end;
        }
        field(7; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
        }
        field(8; "Loan Balance"; Decimal)
        {
            Caption = 'Loan Balance';
        }
        field(9; "Interest Due"; Decimal)
        {
            Caption = 'Interest Due';
        }
        field(10; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(11; "Debtor Code"; Code[50])
        {
            Caption = 'Debtor Code';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}





