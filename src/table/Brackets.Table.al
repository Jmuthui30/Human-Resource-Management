table 52122 "Brackets"
{
    DataClassification = CustomerContent;
    Caption = 'Brackets';
    fields
    {
        field(1; "Tax Band"; Code[10])
        {
            NotBlank = true;
            Caption = 'Tax Band';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Table Code"; Code[10])
        {
            TableRelation = "Bracket Tables";
            Caption = 'Table Code';
        }
        field(4; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
        }
        field(5; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(9; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(10; "Pay period"; Date)
        {
            Caption = 'Pay period';
        }
        field(11; "Taxable Amount"; Decimal)
        {
            Caption = 'Taxable Amount';
        }
        field(12; "Total taxable"; Decimal)
        {
            Caption = 'Total taxable';
        }
        field(13; "Factor Without Housing"; Decimal)
        {
            DecimalPlaces = 2 :;
            Caption = 'Factor Without Housing';
        }
        field(14; "Factor With Housing"; Decimal)
        {
            DecimalPlaces = 2 :;
            Caption = 'Factor With Housing';
        }
        field(15; Institution; Code[20])
        {
            Caption = 'Institution';
        }
        field(16; "Contribution Rates Inclusive"; Boolean)
        {
            Caption = 'Contribution Rates Inclusive';
        }
    }

    keys
    {
        key(Key1; "Tax Band", "Table Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





