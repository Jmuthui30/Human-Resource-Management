table 52033 "Base Calender Custom"
{
    DataClassification = CustomerContent;
    Caption = 'Base Calender Custom';
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Customized Changes Exist"; Boolean)
        {
            CalcFormula = exist("Customized Calendar Change" where("Base Calendar Code" = field(Code)));
            Caption = 'Customized Changes Exist';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





