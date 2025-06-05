table 52151 "Other Earnings"
{
    DrillDownPageID = "Other Earnings";
    LookupPageID = "Other Earnings";
    DataClassification = CustomerContent;
    Caption = 'Other Earnings';
    fields
    {
        field(1; "Main Earning"; Code[10])
        {
            TableRelation = Earnings.Code;
            Caption = 'Main Earning';
        }
        field(2; "Earning Code"; Code[10])
        {
            TableRelation = Earnings.Code;
            Caption = 'Earning Code';

            trigger OnValidate()
            begin
                if "Earning Code" = "Main Earning" then
                    Error('Can not be same');

                if Earnings.Get("Main Earning") then
                    if Earnings."Calculation Method" <> Earnings."Calculation Method"::"% of Other Earnings" then
                        Error('Calculation method must be "% of Other Earnings" for %1 - %2', Earnings.Code, Earnings.Description);

                if "Earning Code" <> '' then begin
                    Earnings.Reset();
                    if Earnings.Get("Earning Code") then
                        Description := Earnings.Description;
                end else
                    Description := '';
            end;
        }
        field(3; Description; Text[70])
        {
            Caption = 'Description';
        }
        field(4; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
    }

    keys
    {
        key(Key1; "Main Earning", "Earning Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Earnings: Record Earnings;
}





