table 52000 "Destination Rate Entry"
{
    DataClassification = CustomerContent;
    Caption = 'Destination Rate Entry';
    fields
    {
        field(1; "Advance Code"; Code[20])
        {
            Caption = 'Expenditure Type';
            NotBlank = true;
            TableRelation = if ("Payment Type" = const(Earning)) Earnings.Code;
        }
        field(2; "Destination Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Destination;
            Caption = 'Destination Code';

            trigger OnValidate()
            var
                Destination: Record Destination;
            begin
                Destination.Reset();
                Destination.Get("Destination Code");
                "Destination Name" := Destination."Destination Name";
                "Other Area" := Destination."Other Area";
                "Destination Type" := Destination."Destination Type";
            end;
        }
        field(3; Currency; Code[10])
        {
            NotBlank = false;
            TableRelation = Currency;
            Caption = 'Currency';
        }
        field(4; "Destination Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Local,Foreign';
            OptionMembers = "local",Foreign;
            Caption = 'Destination Type';
        }
        field(5; "Daily Rate (Amount)"; Decimal)
        {
            Caption = 'Daily Rate (Amount)';
        }
        field(6; "Employee Job Group"; Code[10])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "Salary Scale".Scale;
            Caption = 'Employee Job Group';
        }
        field(7; "Destination Name"; Text[50])
        {
            Editable = false;
            Caption = 'Destination Name';
        }
        field(8; "Other Area"; Boolean)
        {
            Editable = false;
            Caption = 'Other Area';
        }
        field(9; "Rate Type"; Option)
        {
            OptionCaption = 'Payments,Training';
            OptionMembers = Payments,Training;
            Caption = 'Rate Type';
        }
        field(10; "Payment Type"; Option)
        {
            OptionCaption = 'Payment Voucher,Imprest,Staff Claim,Imprest Surrender,Petty Cash,Bank Transfer,Petty Cash Surrender,Receipt,Staff Advance,Receipt-Property,Earning';
            OptionMembers = "Payment Voucher",Imprest,"Staff Claim","Imprest Surrender","Petty Cash","Bank Transfer","Petty Cash Surrender",Receipt,"Staff Advance","Receipt-Property","Earning";
            Caption = 'Payment Type';
        }
    }

    keys
    {
        key(Key1; "Destination Code", "Employee Job Group", Currency, "Advance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





