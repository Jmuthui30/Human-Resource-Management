table 52152 "Other Deductions"
{
    DrillDownPageID = "Other Earnings";
    LookupPageID = "Other Earnings";
    DataClassification = CustomerContent;
    Caption = 'Other Deductions';
    fields
    {
        field(1; "Main Deduction"; Code[10])
        {
            TableRelation = Deductions.Code;
            Caption = 'Main Deduction';
        }
        field(2; "Earning Code"; Code[10])
        {
            TableRelation = Earnings.Code;
            Caption = 'Earning Code';

            trigger OnValidate()
            begin
                if Deductions.Get("Main Deduction") then
                    if Deductions."Calculation Method" <> Deductions."Calculation Method"::"% of Other Earnings" then
                        Error('Calculation method must be "% of Other Earnings" for %1 - %2', Deductions.Code, Deductions.Description);

                Earnings.Get("Earning Code");
                Description := Earnings.Description;
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
        key(Key1; "Main Deduction", "Earning Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Deductions: Record Deductions;
        Earnings: Record Earnings;
}





