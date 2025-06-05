table 52056 "Referees"
{
    DataClassification = CustomerContent;
    Caption = 'Referees';
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            //TableRelation = Applicants."No.";
        }
        field(2; Names; Text[200])
        {
            Caption = 'Names';
        }
        field(3; Designation; Text[100])
        {
            Caption = 'Designation';
        }
        field(4; Company; Text[100])
        {
            Caption = 'Company';
        }
        field(5; Address; Text[200])
        {
            Caption = 'Address';
        }
        field(6; "Telephone No"; Text[100])
        {
            Caption = 'Telephone No';
        }
        field(7; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
        }
        //field(8; "Application No."; Code[20])
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}













