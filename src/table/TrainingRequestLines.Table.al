table 52091 "Training Request Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Training Request Lines';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "Training Request";
            Caption = 'Document No.';
        }
        field(2; "Training Need No"; Code[20])
        {
            TableRelation = "Training Need";
            Caption = 'Training Need No';
        }
        field(3; "Expense Code"; Code[20])
        {
            TableRelation = "Training Needs Lines"."Expense Code" where("Document No." = field("Training Need No"));
            Caption = 'Expense Code';

            trigger OnValidate()
            begin
                TrainingNeedsLines.Reset();
                TrainingNeedsLines.SetRange("Document No.", "Training Need No");
                TrainingNeedsLines.SetRange("Expense Code", "Expense Code");
                if TrainingNeedsLines.FindFirst() then begin
                    "G/L Account" := TrainingNeedsLines."G/L Account";
                    "Expense Name" := TrainingNeedsLines."Expense name";
                end;
            end;
        }
        field(4; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'G/L Account';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                if "Per Diem" then
                    Error(Text001);
                CurrencyRec.InitRoundingPrecision();

                if "Currency Code" = '' then
                    "Amount (LCY)" := Round(Amount, CurrencyRec."Amount Rounding Precision")
                else
                    "Amount (LCY)" := Round(
                        CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code",
                          Amount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                          CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(6; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
        field(7; "Currency Code"; Code[10])
        {
            Editable = false;
            TableRelation = Currency;
            Caption = 'Currency Code';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(8; Committed; Boolean)
        {
            Editable = false;
            Caption = 'Committed';
        }
        field(9; "Per Diem"; Boolean)
        {
            Caption = 'Per Diem';
        }
        field(10; Status; Option)
        {
            CalcFormula = lookup("Training Request".Status where("Request No." = field("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            Caption = 'Status';
        }
        field(11; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';
        }
        field(12; "Expense Name"; Text[30])
        {
            Caption = 'Expense Name';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Training Need No", "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TrainingRequest.Get("Document No.");
        TrainingRequest.TestField("Employee No");
        "Employee No" := "Employee No";
    end;

    var
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        TrainingNeedsLines: Record "Training Needs Lines";
        TrainingRequest: Record "Training Request";
        Text001: Label 'You cannot edit Per Diem Amount.';
}





