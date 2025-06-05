table 52148 "Deduction Balances"
{
    DataClassification = CustomerContent;
    Caption = 'Deduction Balances';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';
        }
        field(2; "Deduction Code"; Code[20])
        {
            TableRelation = Deductions;
            Caption = 'Deduction Code';
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; Description; Text[70])
        {
            CalcFormula = lookup(Deductions.Description where(Code = field("Deduction Code")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Description';
        }
        field(6; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            OptionCaption = 'Staff,Sacco';
            OptionMembers = "Staff","Sacco";
        }
        field(7; "Loan No."; Code[50])
        {
            Caption = 'Reference No.';
        }
    }

    keys
    {
        key(Key1; "Employee No", "Deduction Code", Date, "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





