table 52135 "Scale Benefits"
{
    DrillDownPageID = "Scale Benefits";
    LookupPageID = "Scale Benefits";
    DataClassification = CustomerContent;
    Caption = 'Scale Benefits';
    fields
    {
        field(1; "Salary Scale"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'Salary Scale';
        }
        field(2; "Salary Pointer"; Code[10])
        {
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Salary Scale"));
            Caption = 'Salary Pointer';
        }
        field(3; "ED Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Earnings;
            Caption = 'ED Code';

            trigger OnValidate()
            begin
                if EarningRec.Get("ED Code") then begin
                    "ED Description" := EarningRec.Description;
                    "Basic Salary Code" := EarningRec."Basic Salary Code";
                    case EarningRec."Calculation Method" of
                        EarningRec."Calculation Method"::"Flat amount":
                            Amount := EarningRec."Flat Amount";
                    end;
                end;
            end;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "ED Description"; Text[30])
        {
            Caption = 'ED Description';
        }
        field(6; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
        }
        field(7; "Payment Option"; Option)
        {
            OptionCaption = 'Amount,Hour Rate,Daily Rate,Percentage';
            OptionMembers = Amount,"Hour Rate","Daily Rate",Percentage;
            Caption = 'Payment Option';
        }
        field(8; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(9; "Basic Salary Code"; Boolean)
        {
            Caption = 'Basic Salary Code';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Salary Scale", "Salary Pointer", "ED Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EarningRec: Record Earnings;
}





