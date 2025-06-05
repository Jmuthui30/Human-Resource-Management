table 52108 "Training Budget"
{
    DataClassification = CustomerContent;
    Caption = 'Training Budget';
    fields
    {
        field(1; "Training Year"; Code[10])
        {
            Caption = 'Training Year';
        }
        field(2; "Budget Item No"; Code[20])
        {
            NotBlank = true;
            Caption = 'Budget Item No';
        }
        field(3; "Source of Funds"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(4; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost';

            trigger OnValidate()
            begin
                GLSetup.Get();
                GLSetup.TestField("Current Budget");
                GLSetup.TestField("Current Budget Start Date");
                GLSetup.TestField("Current Budget End Date");

                GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
                GLBudget.SetRange(GLBudget."Budget Name", "Training Year");
                GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
                if GLSetup."Use Dimensions For Budget" then
                    GLBudget.SetRange(GLBudget."Dimension Set ID", "Dimension Set ID");
                GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
                GLBudget.CalcSums(Amount);
                BudgetAmount := GLBudget.Amount;
                "Approved Budget" := BudgetAmount;

                TrainingPlan.SetCurrentKey("Training Year", "Source of Funds");
                TrainingPlan.SetRange(TrainingPlan."Training Year", "Training Year");
                TrainingPlan.SetRange(TrainingPlan."Source of Funds", "Source of Funds");
                TrainingPlan.CalcSums("Estimated Cost");
                TrainingPlanAmount := TrainingPlan."Estimated Cost";


                if "Estimated Cost" > (BudgetAmount - TrainingPlanAmount) then
                    Error('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds",
                    ("Estimated Cost" - (BudgetAmount - TrainingPlanAmount)), BudgetAmount);
            end;
        }
        field(5; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "Approved Budget"; Decimal)
        {
            Caption = 'Approved Budget';
        }
        field(7; "Budget Status"; Option)
        {
            OptionMembers = " ",Open,Approved,Rejected;
            Caption = 'Budget Status';
        }
        field(8; "No."; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'No.';

            trigger OnValidate()
            begin
                if GLAcc.Get("No.") then begin
                    "Source of Funds" := "No.";
                    "Description" := GLAcc.Name;
                end;
            end;
        }
        field(9; Actual; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds"),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Commitment; Decimal)
        {
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(No = field("Source of Funds"),
                                                                             "Commitment Date" = field("Date Filter"),
                                                                             "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                HRSetup.Get();
                HRSetup.TestField("Training Budget Item Nos");
                if "Budget Item No" = '' then
                    NoSeriesMgt.InitSeries(HRSetup."Training Budget Item Nos", xRec."No. Series", 0D, "Budget Item No", "No. Series");
            end;
        }
        field(12; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(16; "No. Series"; code[10])
        {
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(Key1; "Training Year", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Budget Item No")
        {
            Clustered = true;
            SumIndexFields = "Estimated Cost";
        }
        key(Key2; "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key3; "No.")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key4; "Training Year", "Shortcut Dimension 2 Code", "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Budget Item No", Description)
        {
        }
    }

    trigger OnInsert()
    begin
        /* PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Procurement Plan Item Nos");
        if "Plan Item No" = '' then begin
            NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Procurement Plan Item Nos", xRec."No. Series", 0D, "Plan Item No", "No. Series");
        end; */
    end;

    var
        GLAcc: Record "G/L Account";
        GLBudget: Record "G/L Budget Entry";
        GLSetup: Record "General Ledger Setup";
        HRSetup: Record "Human Resources Setup";
        TrainingPlan: Record "Training budget";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BudgetAmount: Decimal;
        TrainingPlanAmount: Decimal;

    procedure GetQuarters()
    var
        AccPeriod: Record "Accounting Period";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then
            NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "1stQuarter" := "Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "2ndQuarter" := "Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "3rdQuarter" := "Estimated Cost";
        end;
        //Get 4th Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "4thQuarter" := "Estimated Cost";
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





