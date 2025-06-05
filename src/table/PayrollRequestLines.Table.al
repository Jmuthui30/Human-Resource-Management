table 52142 "Payroll Request Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Request Lines';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(3; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
        }
        field(4; "Previous Value"; Decimal)
        {
            Caption = 'Previous Value';
        }
        field(5; "New Value"; Decimal)
        {
            Caption = 'New Value';
        }
        field(6; Change; Decimal)
        {
            Caption = 'Change';
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





