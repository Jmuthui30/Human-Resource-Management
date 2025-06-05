table 52022 "Appointment Checklist"
{
    DataClassification = CustomerContent;
    Caption = 'Appointment Checklist';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = true;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                /*
                  OK:= Employee.Get(Date);
                  if OK then begin
                   "Maturity Date":= Employee."First Name";
                   "No. of Days":= Employee."Last Name";
                  end;
                */

            end;
        }
        field(3; Item; Text[100])
        {
            Caption = 'Item';
            TableRelation = "Appointment Checklist Setup"."Item Code";
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; Signed; Boolean)
        {
            Caption = 'Signed';
        }
        field(6; "Employee First Name"; Text[30])
        {
            Caption = 'Employee First Name';
        }
        field(7; "Employee Last Name"; Text[30])
        {
            Caption = 'Employee Last Name';
        }
        field(8; Description; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Appointment Checklist Setup".Description where("Item Code" = field(Item)));
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Employee No.", Item)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





