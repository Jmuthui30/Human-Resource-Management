table 52024 "Employment History"
{
    DataClassification = CustomerContent;
    Caption = 'Employment History';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
            Caption = 'Employee No.';
        }
        field(2; From; Date)
        {
            NotBlank = true;
            Caption = 'From';
        }
        field(3; "To"; Date)
        {
            NotBlank = true;
            Caption = 'To';
        }
        field(4; "Company Name"; Text[150])
        {
            NotBlank = true;
            Caption = 'Company Name';
        }
        field(5; "Postal Address"; Text[40])
        {
            Caption = 'Postal Address';
        }
        field(6; "Address 2"; Text[40])
        {
            Caption = 'Address 2';
        }
        field(7; "Job Title"; Text[150])
        {
            Caption = 'Job Title';
        }
        field(8; "Key Experience"; Text[150])
        {
            Caption = 'Key Experience';
        }
        field(9; "Salary On Leaving"; Decimal)
        {
            Caption = 'Salary On Leaving';
        }
        field(10; "Reason For Leaving"; Text[150])
        {
            Caption = 'Reason For Leaving';
        }
        field(11; Current; Boolean)
        {
            Caption = 'Current';

            trigger OnValidate()
            begin

                EmpHistory.Reset();
                EmpHistory.SetRange("Employee No.", "Employee No.");
                if EmpHistory.Find('-') then
                    repeat
                        if (EmpHistory.From <> From) or (EmpHistory."To" <> "To") or
                           (EmpHistory."Company Name" <> "Company Name") then
                            if EmpHistory.Current then
                                Error(Text000, EmpHistory."Company Name", EmpHistory.From, EmpHistory."To");
                    until EmpHistory.Next() = 0;
            end;
        }
        field(12; Industry; Code[50])
        {
            Caption = 'Industry';
            TableRelation = "Company Job Industry";
        }
        field(13; "Hierarchy Level"; Enum "Hierarchy Level")
        {
            Caption = 'Hierarchy Level';
        }
        field(14; "No. of Years"; Decimal)
        {
            Caption = 'No. of Years';
        }
    }

    keys
    {
        key(Key1; "Employee No.", From, "To")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpHistory: Record "Employment History";
        Text000: Label 'You can''t have more than one current job \ %1  from %2 to %3 is current';
}





