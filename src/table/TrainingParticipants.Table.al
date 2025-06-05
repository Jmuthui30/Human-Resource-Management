table 52104 "Training Participants"
{
    DataClassification = CustomerContent;
    Caption = 'Training Participants';
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Training Need"; Code[20])
        {
            TableRelation = "Training Need" where(Status = filter(Open | Application));
            Caption = 'Training Need';
        }
        field(3; "Employee No"; Code[10])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation := Employee."Job Position Title";
                    "Salary Scale" := Employee."Salary Scale";
                    "Salary Pointer" := Employee."Present Pointer";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(5; Designation; Text[100])
        {
            Caption = 'Designation';
            Editable = false;
        }
        field(6; "Salary Scale"; Code[30])
        {
            TableRelation = "Salary Scale".Scale;
            Caption = 'Salary Scale';
            Editable = false;
        }
        field(7; "Salary Pointer"; Code[50])
        {
            TableRelation = "Salary Pointer";
            Editable = false;
            Caption = 'Salary Pointer';
        }
    }

    keys
    {
        key(Key1; "Training Need", Code, "Employee No")
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





