table 52117 "Applicant Hobbies"
{
    Caption = 'Applicant Hobbies';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Hobbies; Text[200])
        {
            Caption = 'Hobbies';
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
    }

    keys
    {
        key(PK; "No.", "Line No")
        {
            Clustered = true;
        }
    }
}





