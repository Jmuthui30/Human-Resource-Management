table 52077 "Employee Beneficiaries"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Beneficiaries';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';
        }
        field(2; "Beneficiary No."; Code[20])
        {
            Caption = 'Beneficiary No.';
        }
        field(3; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }
        field(4; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
        }
        field(5; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(6; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(7; Gender; Option)
        {
            OptionMembers = " ",Female,Male;
            Caption = 'Gender';
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Beneficiary No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Beneficiary No Series

        BenPos := 0;

        Beneficiary.Reset();
        Beneficiary.SetRange("Employee No.", "Employee No.");
        if Beneficiary.Find('-') then begin
            BenPos := Beneficiary.Count;
            BenNo := 'BENF' + ' ' + ("Employee No.") + '/' + Format(BenPos + 1);
        end else
            BenNo := 'BENF' + ' ' + Format("Employee No.") + '/' + Format(1);
        ;
        "Beneficiary No." := BenNo;
    end;

    var
        Beneficiary: Record "Employee Beneficiaries";
        BenNo: Code[20];
        BenPos: Integer;
}





