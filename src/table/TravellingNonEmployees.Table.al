table 52043 "Travelling Non Employees"
{
    DataClassification = CustomerContent;
    Caption = 'Travelling Non Employees';
    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
        }
        field(2; "Line No"; Integer)
        {
            NotBlank = true;
            Caption = 'Line No';
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; Source; Text[50])
        {
            Caption = 'Source';
        }
        field(5; Destination; Text[50])
        {
            Caption = 'Destination';
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "Return Date"; Date)
        {
            Caption = 'Return Date';
        }
        field(8; "Passport No"; Text[30])
        {
            Caption = 'Passport No';
        }
        field(9; Airline; Text[30])
        {
            Caption = 'Airline';
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(11; Itinerary; Text[60])
        {
            Caption = 'Itinerary';
        }
        field(12; "Travel Insurance"; Boolean)
        {
            Caption = 'Travel Insurance';
        }
        field(13; "Ticket Type"; Option)
        {
            OptionCaption = ',Economy,Business';
            OptionMembers = ,Economy,Business;
            Caption = 'Ticket Type';
        }
        field(14; "Cost Centre"; Code[10])
        {
            Caption = 'Cost Centre';
        }
        field(15; "FSC Code"; Code[20])
        {
            Caption = 'FSC Code';
        }
        field(16; "Fn Code"; Code[20])
        {
            Caption = 'Fn Code';
        }
    }

    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





