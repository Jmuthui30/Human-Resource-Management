table 52090 "Training Needs Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Training Needs Lines';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "Training Need";
            Caption = 'Document No.';
        }
        field(3; "Expense Code"; Code[20])
        {
            TableRelation = "Training Budget"."Budget Item No";
            Caption = 'Expense Code';

            trigger OnValidate()
            var
                TrainingBudget: Record "Training Budget";
            begin
                if TrainingBudget.Get("Expense Code") then begin
                    "G/L Account" := TrainingBudget."No.";
                    "Expense name" := TrainingBudget.Description;
                    "Budget Line" := TrainingBudget."Source of Funds";
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
            TableRelation = Currency;
            Caption = 'Currency Code';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(8; Committed; Boolean)
        {
            Caption = 'Committed';
        }
        field(9; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(10; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(14; Status; Option)
        {
            CalcFormula = lookup("Training Need".Status where(Code = field("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'New,Closed,Application';
            OptionMembers = Open,Closed,Application;
            Caption = 'Status';
        }
        field(15; "Expense name"; Text[30])
        {
            Caption = 'Expense name';
        }
        field(16; "Budget Line"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Budget Line';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TrainingNeed.Get("Document No.");
        TrainingNeed.TestField("Start Date");
        TrainingNeed.TestField("End Date");
        "Start Date" := TrainingNeed."Start Date";
        "End Date" := TrainingNeed."End Date";
        "Shortcut Dimension 1 Code" := TrainingNeed."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := TrainingNeed."Shortcut Dimension 2 Code";
        "Dimension Set ID" := TrainingNeed."Dimension Set ID";
        "Currency Code" := TrainingNeed."Currency Code";
    end;

    var
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        TrainingNeed: Record "Training Need";
        DimMgt: Codeunit DimensionManagement;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2', 'Training', "Document No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





