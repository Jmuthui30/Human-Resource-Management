table 52023 "Professional Membership"
{
    DataClassification = CustomerContent;
    Caption = 'Professional Membership';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee."No." where("No." = field("Employee No."));
            Caption = 'Employee No.';
        }
        field(2; "Date Admitted"; Date)
        {
            Caption = 'Date Admitted';
        }
        field(3; Organisation; Text[150])
        {
            Caption = 'Organisation';
        }
        field(4; "Membership Type"; Code[20])
        {
            Caption = 'Membership Type';
        }
        field(5; Designation; Text[30])
        {
            Caption = 'Designation';
        }
        field(6; "Annual Fee"; Decimal)
        {
            Caption = 'Annual Fee';
        }
        field(7; "Renewal Date"; Date)
        {
            Caption = 'Renewal Date';
        }
        field(8; "Company Pays Fees"; Boolean)
        {
            Caption = 'Company Pays Fees';
        }
        field(9; "Employee First Name"; Text[30])
        {
            Caption = 'Employee First Name';
        }
        field(10; "Employee Last Name"; Text[30])
        {
            Caption = 'Employee Last Name';
        }
        field(11; Comment; Boolean)
        {
            Editable = false;
            Caption = 'Comment';
        }
        field(12; "Language Code (Default)"; Code[10])
        {
            Caption = 'Language Code (Default)';
        }
        field(13; Attachement; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
            Caption = 'Attachement';
        }
        field(14; "Membership No"; Code[20])
        {
            Caption = 'Membership No';
        }
        field(15; "Member No"; Code[10])
        {
            Caption = 'Member No';
        }
        field(16; "Membership Description"; Text[100])
        {
            Caption = 'Membership Description';
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
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
    }
}





