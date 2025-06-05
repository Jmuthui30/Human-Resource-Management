table 52115 "Applicant Prof Membership"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Prof Membership';
    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
        }
        field(2; "Professional Body"; Code[500])
        {
            TableRelation = "Professional Memberships";
            Caption = 'Professional Body';

            trigger OnValidate()
            var
                profmemb: Record "Professional Memberships";
            begin
                if profmemb.Get("Professional Body") then
                    Description := profmemb.Description;
            end;
        }
        field(3; MembershipNo; Code[50])
        {
            Caption = 'MembershipNo';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
        }
        field(6; Description; Code[200])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Applicant No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





