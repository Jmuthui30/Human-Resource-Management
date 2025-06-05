table 52034 "Board of Director"
{
    DataClassification = CustomerContent;
    Caption = 'Board of Director';
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; SurName; Text[100])
        {
            Caption = 'SurName';
        }
        field(3; "Other Names"; Text[150])
        {
            Caption = 'Other Names';
        }
        field(4; Remarks; Text[100])
        {
            Caption = 'Remarks';
        }
        field(5; Address; Code[40])
        {
            Caption = 'Address';
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
        }
        field(8; County; Text[40])
        {
            Caption = 'County';
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(10; "Phone No"; Code[20])
        {
            Caption = 'Phone No';
        }
        field(11; Email; Text[60])
        {
            Caption = 'Email';
        }
        field(12; "ID Number"; Code[20])
        {
            Caption = 'ID Number';
        }
        field(13; "PIN Number"; Code[20])
        {
            Caption = 'PIN Number';
        }
        field(14; Nationality; Text[40])
        {
            Caption = 'Nationality';
        }
        field(15; Occupation; Text[40])
        {
            Caption = 'Occupation';
        }
        field(16; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(17; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(18; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(19; "Appointment Date"; Date)
        {
            Caption = 'Appointment Date';
        }
        field(20; Picture; MediaSet)
        {
            Caption = 'Picture';
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





