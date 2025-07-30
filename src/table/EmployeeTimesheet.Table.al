table 52185 "Employee Timesheet"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Employee Name"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Billable Time"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "GRAND TOTAL"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "SSHF SA1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; CARE; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "CA- Mayendit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Tear Fund"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "CA- Aweil"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; IMC; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "CARE Rubkona"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "SSHF RVA 4"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "DRA- SSJR"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "ECHO- Plan"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; EU; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "CARE-ADH"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; WHO; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; UNHCR; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "SSHF RVA 3"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "ERRM- Pochalla"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Tear Fund- Fangak"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "SSHR RVA 2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "PLAN- Malakal"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Other; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; PSC; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}