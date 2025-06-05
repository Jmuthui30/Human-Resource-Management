table 52028 "Training Source & Facilitators"
{
    DataClassification = CustomerContent;
    Caption = 'Training Source & Facilitators';
    fields
    {
        field(1; Source; Code[50])
        {
            NotBlank = true;
            Caption = 'Source';
        }
        field(2; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(3; "Training Need"; Code[20])
        {
            NotBlank = true;
            Caption = 'Training Need';
        }
        field(4; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
            Caption = 'Code';

            trigger OnValidate()
            begin
                Employees.Reset();
                if Employees.Get(Code) then
                    Names := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
            end;
        }
        field(5; Names; Text[200])
        {
            Caption = 'Names';
        }
        field(6; "Facilitator Remarks"; Text[200])
        {
            Caption = 'Facilitator Remarks';
        }
    }

    keys
    {
        key(Key1; Source)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employees: Record Employee;
}





