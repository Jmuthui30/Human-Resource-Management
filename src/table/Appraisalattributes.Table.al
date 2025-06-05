table 52111 "Appraisal - attributes"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal - attributes';
    fields
    {
        field(1; AttributeCode; Code[20])
        {
            TableRelation = "Work related attributes";
            Caption = 'AttributeCode';

            trigger OnValidate()
            var
                Attributes: Record "Work related attributes";
            begin
                if Attributes.Get(AttributeCode) then
                    Attribute := Attributes.Description;
            end;
        }
        field(2; Attribute; Text[2048])
        {
            Caption = 'Attribute';
        }
        field(3; "Indicator code"; Code[50])
        {
            TableRelation = "Work related indicators".Code where(AttributeCode = field(AttributeCode));
            Caption = 'Indicator code';

            trigger OnValidate()
            var
                Indicators: Record "Work related indicators";
            begin
                Indicators.SetRange(Code, "Indicator code");
                if Indicators.FindFirst() then
                    Indicator := Indicators.Description;
            end;
        }
        field(4; Indicator; Text[2048])
        {
            Caption = 'Indicator';
        }
        field(5; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(6; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
        }
        field(7; Rating; Decimal)
        {
            Caption = 'Rating';
        }
        field(8; Remarks; Text[500])
        {
            Caption = 'Remarks';
        }
        field(9; "Expected rating attributes"; Decimal)
        {
            Caption = 'Expected rating';
        }
    }

    keys
    {
        key(PK; "Appraisal No.", AttributeCode, "Indicator code", "Line No")
        {
            Clustered = true;
        }
    }
}





