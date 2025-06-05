table 52114 "Applicant Job Experience"
{
    Caption = 'Applicant Job Experience';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Job ID';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; Employer; Text[250])
        {
            Caption = 'Employer';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                if "Start Date" > Today then
                    Error('You can not input a date in the future');

                if "End Date" <> 0D then
                    if "Start Date" > "End Date" then
                        Error('Start Date can not be greater that End Date');

                if ("Start Date" <> 0D) and ("End Date" <> 0D) then
                    "No. of Years" := Round((("End Date" - "Start Date") / 365), 0.01, '=');
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                if "End Date" > Today then
                    Error('You can not input a date in the future');

                if "Start Date" <> 0D then
                    if "End Date" < "Start Date" then
                        Error('End Date can not be earlier than Start Date');

                if ("Start Date" <> 0D) and ("End Date" <> 0D) then
                    "No. of Years" := Round((("End Date" - "Start Date") / 365), 0.01, '=');
            end;
        }
        field(6; "Present Employment"; Boolean)
        {
            Caption = 'Present Employment';
        }
        field(7; Industry; Code[50])
        {
            Caption = 'Industry';
            TableRelation = "Company Job Industry";
        }
        field(8; "Hierarchy Level"; Enum "Hierarchy Level")
        {
            Caption = 'Hierarchy Level';
        }
        field(9; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(10; "Not Under Notice"; Boolean)
        {
            Caption = 'Not Under Notice';
        }
        field(11; "Job Title"; Text[250])
        {
            Caption = 'Job Title';
        }
        field(12; "Employer Email Address"; Text[100])
        {
            Caption = 'Employer Email Address';

            trigger OnValidate()
            begin
                Mail.CheckValidEmailAddress("Employer Email Address");
            end;
        }
        field(13; "Employer Postal Address"; Text[100])
        {
            Caption = 'Employer Postal Address';
        }
        field(14; "Functional Area"; Code[100])
        {
            Caption = 'Functional Area';
        }
        field(15; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(16; Country; Code[100])
        {
            TableRelation = "Country/Region";
            Caption = 'Country';
        }
        field(17; Location; Text[100])
        {
            Caption = 'Location';
        }
        field(18; "No. of Years"; Decimal)
        {
            Caption = 'No. of Years';
        }
        field(19; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
        }
        field(20; "Total no of years in industry"; Decimal)
        {
            Caption = 'Total no of years in industry';
        }
        field(21; "Most relevant industry"; Boolean)
        {
            Caption = 'Most relevant industry';
        }
    }

    keys
    {
        key(PK; "Applicant No.", "Line No")
        {
            Clustered = true;
        }
    }

    var
        Mail: Codeunit "Mail Management";
}





