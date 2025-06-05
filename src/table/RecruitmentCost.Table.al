table 52004 "Recruitment Cost"
{
    Caption = 'Recruitment Cost';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Expense Code"; Code[50])
        {
            Caption = 'Expense Code';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account".Name where("No." = field("Expense Code")));
            Editable = false;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Need Code", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount";
        }
        key(Key1; "Need Code")
        {
            SumIndexFields = "Amount";
        }
    }
}






