table 52164 "Applicants Employment History"
{
    DataClassification = CustomerContent;
    Caption = 'Applicants Employment History';
    fields
    {
        field(1; "Application No"; Code[30])
        {
            Caption = 'Application No';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; "Institution/Company"; Text[60])
        {
            Caption = 'Institution/Company';
        }
        field(4; From; Date)
        {
            Caption = 'From';
        }
        field(5; "To"; Date)
        {
            Caption = 'To';
        }
        field(6; Position; Code[60])
        {
            Caption = 'Position';
        }
    }

    keys
    {
        key(Key1; "Application No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





