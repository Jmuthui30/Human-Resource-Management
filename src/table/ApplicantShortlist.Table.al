table 52064 "Applicant Shortlist"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Shortlist';
    DrillDownPageId = "Applicant ShortList Lines";
    fields
    {
        field(50000; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
        }
        field(1; "Applicant No."; Code[20])
        {
            Caption = 'Applicant No.';
        }
        field(2; "First Name"; Text[80])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(14; "Cellular Phone Number"; Text[30])
        {
            Caption = 'Cellular Phone Number';
        }
        field(17; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            trigger OnValidate()
            begin
                Mail.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(21; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(34; Age; Text[80])
        {
            Caption = 'Age';
        }
        field(80; "Interview Date"; Date)
        {
            Caption = 'Interview Date';

            trigger OnValidate()
            begin
                if "Interview Date" < Today then
                    Error('Cannot backdate');
            end;
        }
        field(81; "Interview Time"; Time)
        {
            Caption = 'Interview Time';
        }
        field(94; "Applicant Name"; Text[100])
        {
            Editable = false;
            Caption = 'Applicant Name';
        }
        field(50002; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
        field(50003; Notified; Boolean)
        {
            Caption = 'Notified';
        }
        field(50004; "Job Application No."; Code[50])
        {
            Caption = 'Job Application No.';
            TableRelation = "Job Application";
        }
    }
    keys
    {
        key(PK; "Need Code", "Applicant No.")
        {
            Clustered = true;
        }
    }

    var
        Mail: Codeunit "Mail Management";
}






