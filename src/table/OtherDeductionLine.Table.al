table 52175 "Other Deduction Line"
{
    Caption = 'Other Deduction';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Main Code"; Code[10])
        {
            Caption = 'Main Code';
        }
        field(2; "Deduction Code"; Code[10])
        {
            Caption = 'Deduction Code';
            TableRelation = Deductions.Code;

            trigger OnValidate()
            begin
                if "Deduction Code" = "Main Code" then
                    Error('Can not be same');

                if DeductionsX.Get("Main Code") then
                    if DeductionsX."Calculation Method" <> DeductionsX."Calculation Method"::"% of Other Deductions" then
                        Error('Calculation method must be "% of Other Deductions" for %1 - %2', DeductionsX.Code, DeductionsX.Description);

                if "Deduction Code" <> '' then begin
                    DeductionsX.Reset();
                    if DeductionsX.Get("Deduction Code") then
                        Description := DeductionsX.Description;
                end else
                    Description := '';
            end;
        }
        field(3; Description; Text[50])
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
        key(Key1; "Main Code", "Deduction Code", "Line No")
        {
            Clustered = true;
        }
    }

    var
        DeductionsX: Record Deductions;
}