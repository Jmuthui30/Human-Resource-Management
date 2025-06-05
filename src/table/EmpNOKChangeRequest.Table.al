table 52073 "Emp NOK Change Request"
{
    DataClassification = CustomerContent;
    Caption = 'Emp NOK Change Request';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Relative Code"; Code[10])
        {
            Caption = 'Relative Code';
            TableRelation = Relative;
        }
        field(4; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(5; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(6; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(7; "Birth Date"; Date)
        {
            Caption = 'Birth Date';

            trigger OnValidate()
            begin
                /*
                HRSetup.Get();
                HRSetup.TestField("Dependant Maximum Age");
                
                 if CalcDate(HRSetup."Dependant Maximum Age","Birth Date")<Today then
                  Error('The Minimum age for Dependants is '+Format(HRSetup."Dependant Maximum Age"));
                */

            end;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Relative's Employee No."; Code[20])
        {
            Caption = 'Relative''s Employee No.';
            TableRelation = Employee;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Relative"),
                                                                     "No." = field("Employee No."),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Dependant; Boolean)
        {
            Caption = 'Dependant';

            trigger OnValidate()
            begin
                /*
                HRSetup.Get();
                HRSetup.TestField("Dependant Maximum Age");
                
                 if CalcDate(HRSetup."Dependant Maximum Age","Birth Date")<Today then
                  Error('The Minimum age for Dependants is '+Format(HRSetup."Dependant Maximum Age"));
                */

            end;
        }
        field(12; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            Caption = 'Gender';
        }
        field(13; "Dependant No"; Code[10])
        {
            Caption = 'Dependant No';
        }
        field(14; "Date Registered"; Date)
        {
            Caption = 'Date Registered';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Dependant No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





