table 52121 "Employee Bank Account"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Bank Account';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No.';
        }
        field(2; "Code"; Code[10])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(5; "Branch Name"; Text[100])
        {
            Caption = 'Branch Name';
        }
        field(6; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(7; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
        }
        field(9; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            Caption = 'Post Code';

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code") then
                    City := PostCode.City;
            end;
        }
        field(10; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(12; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(13; "Bank Branch No."; Text[20])
        {
            NotBlank = false;
            Caption = 'Bank Branch No.';
        }
        field(14; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(15; "Transit No."; Text[20])
        {
            Caption = 'Transit No.';
        }
        field(16; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Currency Code';
        }
        field(17; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Country Code';
        }
        field(18; County; Text[30])
        {
            Caption = 'County';
        }
        field(19; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(20; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(21; "Language Code"; Code[10])
        {
            TableRelation = Language;
            Caption = 'Language Code';
        }
        field(22; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(23; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(24; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(25; "Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
            Caption = 'Rounding Type';
        }
        field(26; "Rounding Precision"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Caption = 'Rounding Precision';
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

    var
        PostCode: Record "Post Code";
}





