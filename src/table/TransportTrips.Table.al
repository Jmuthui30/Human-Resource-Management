table 52066 "Transport Trips"
{
    DataClassification = CustomerContent;
    Caption = 'Transport Trips';
    fields
    {
        field(1; "Request No"; Code[30])
        {
            Caption = 'Request No';
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; "Vehicle No"; Code[20])
        {
            TableRelation = "Fixed Asset"."No." where("Fixed Asset Type" = filter(Fleet),
                                                       "On Trip" = const(false),
                                                       "Under Maintenance" = const(false),
                                                       "Vehicle Type" = field("Vehicle Type"));
            Caption = 'Vehicle No';

            trigger OnValidate()
            begin

                FA.Reset();
                FA.SetRange("No.", "Vehicle No");
                if FA.Find('-') then begin
                    FA.TestField("Seating/carrying capacity");
                    FA.TestField("Current Odometer Reading");
                    "Vehicle Description" := FA.Description;
                    "Vehicle Capacity" := FA."Seating/carrying capacity";
                    "Previous KM" := FA."Current Odometer Reading";
                end;

                /*Trip.Reset();[ers]
                Trip.SetRange("Vehicle No",Trip."Vehicle No");
                if Trip.FindLast() then
                  begin
                    "Previous KM":=Trip."End of Journey KM";
                  end;*/

            end;
        }
        field(4; "Vehicle Description"; Text[100])
        {
            Caption = 'Vehicle Description';
        }
        field(5; "Vehicle Capacity"; Integer)
        {
            Caption = 'Vehicle Capacity';
        }
        field(6; Driver; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Driver';

            trigger OnValidate()
            begin

                Employee.Reset();
                Employee.SetRange("No.", Driver);
                if Employee.Find('-') then begin
                    Employee.TestField("E-Mail");
                    "Drivers Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(7; "Drivers Name"; Text[60])
        {
            Caption = 'Drivers Name';
        }
        field(8; "Previous KM"; Decimal)
        {
            Caption = 'Previous KM';

            trigger OnValidate()
            begin
                "KM Driven" := "End of Journey KM" - "Previous KM";
            end;
        }
        field(9; "Time Out"; Time)
        {
            Caption = 'Time Out';
        }
        field(10; "Time In"; Time)
        {
            Caption = 'Time In';

            trigger OnValidate()
            begin

                if "Time Out" > "Time In" then
                    Error('Time-In cannot be before the Time-Out');
            end;
        }
        field(11; "End of Journey KM"; Decimal)
        {
            Caption = 'End of Journey KM';

            trigger OnValidate()
            begin
                "KM Driven" := "End of Journey KM" - "Previous KM";
                if FA.Get("Vehicle No") then;
                //"Litres of Fuel":=("KM Driven"/FA."Average Km/L");
            end;
        }
        field(12; "KM Driven"; Decimal)
        {
            Caption = 'KM Driven';
        }
        field(13; "Litres of Oil"; Decimal)
        {
            Caption = 'Litres of Oil';
        }
        field(14; "Litres of Fuel"; Decimal)
        {
            Caption = 'Litres of Fuel';
        }
        field(15; "Order/Invoice/Cash/Voucher No."; Code[20])
        {
            Caption = 'Order/Invoice/Cash/Voucher No.';
        }
        field(16; "Vehicle Type"; Option)
        {
            OptionMembers = "Company Vehicle","Personal Vehicle","Taxi";
            OptionCaption = 'Company Vehicle, Personal Vehicle,Taxi';
            Caption = 'Vehicle Type';
        }
    }

    keys
    {
        key(Key1; "Request No", "Vehicle No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        FA: Record "Fixed Asset";
}





