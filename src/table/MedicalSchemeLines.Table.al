table 52060 "Medical Scheme Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Medical Scheme Lines';
    fields
    {
        field(1; "Medical Scheme No"; Code[10])
        {
            Caption = 'Medical Scheme No';
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                Emp.Get("Employee Code");
                SurName := Emp."Last Name";
                "Other Names" := Emp."First Name" + ' ' + Emp."Middle Name";
                "ID No/Passport No" := Emp."ID No.";
                "Date Of Birth" := Emp."Birth Date";
                Gender := Emp.Gender;
            end;
        }
        field(3; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative;
            Caption = 'Relationship';
        }
        field(4; SurName; Text[50])
        {
            NotBlank = true;
            Caption = 'SurName';
        }
        field(5; "Other Names"; Text[100])
        {
            NotBlank = true;
            Caption = 'Other Names';
        }
        field(6; "ID No/Passport No"; Text[50])
        {
            Caption = 'ID No/Passport No';
        }
        field(7; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
        }
        field(8; Occupation; Text[100])
        {
            Caption = 'Occupation';
        }
        field(9; Address; Text[250])
        {
            Caption = 'Address';
        }
        field(10; "Office Tel No"; Text[100])
        {
            Caption = 'Office Tel No';
        }
        field(11; "Home Tel No"; Text[50])
        {
            Caption = 'Home Tel No';
        }
        field(12; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(13; "Service Provider"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Service Provider';
        }
        field(14; "Fiscal Year"; Code[10])
        {
            Caption = 'Fiscal Year';
        }
        field(15; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(16; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(17; "In-Patient Entitlement"; Decimal)
        {
            Caption = 'In-Patient Entitlement';
        }
        field(18; "Out-Patient Entitlment"; Decimal)
        {
            Caption = 'Out-Patient Entitlment';
        }
        field(19; "Amount Spend (In-Patient)"; Decimal)
        {
            Caption = 'Amount Spend (In-Patient)';
        }
        field(20; "Amout Spend (Out-Patient)"; Decimal)
        {
            Caption = 'Amout Spend (Out-Patient)';
        }
        field(21; "Policy Start Date"; Date)
        {
            Caption = 'Policy Start Date';
        }
        field(22; "Medical Cover Type"; Option)
        {
            OptionMembers = " ","In House",Outsourced;
            Caption = 'Medical Cover Type';
        }
    }

    keys
    {
        key(Key1; "Medical Scheme No", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





