table 52026 "Training Need"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Training Needs";
    Caption = 'Training Need';
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get();
                    HRSetup.TestField("Training Needs Nos");
                    NoSeriesManagement.TestManual(HRSetup."Training Needs Nos");
                end;
            end;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                GenLedSetup.Get();
                GenLedSetup.TestField("Current Budget Start Date");
                GenLedSetup.TestField("Current Budget End Date");

                if "Start Date" <> 0D then begin
                    if "Start Date" < GenLedSetup."Current Budget Start Date" then
                        Error(Text001, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget Start Date"), Format(GenLedSetup."Current Budget Start Date"));
                    if "Start Date" > GenLedSetup."Current Budget End Date" then
                        Error(Text002, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget End Date"), Format(GenLedSetup."Current Budget End Date"));

                    if "End Date" <> 0D then begin
                        if "Start Date" > "End Date" then
                            Error(Text002, FieldCaption("Start Date"), Format("Start Date"), FieldCaption("End Date"), Format("End Date"));
                        if "End Date" < "Start Date" then
                            Error(Text001, FieldCaption("End Date"), Format("End Date"), FieldCaption("Start Date"), Format("Start Date"));
                        Duration := ("End Date" - "Start Date") + 1
                    end;
                end;
            end;
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                Validate("Start Date");
            end;
        }
        field(5; "Duration Units"; Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
            Caption = 'Duration Units';
        }
        field(6; Duration; Decimal)
        {
            Caption = 'Duration';
        }
        field(7; "Cost Of Training"; Decimal)
        {
            CalcFormula = sum("Training Needs Lines".Amount where("Document No." = field(Code)));
            FieldClass = FlowField;
            Caption = 'Cost Of Training';

            trigger OnValidate()
            begin
                if Posted then
                    if Duration <> xRec.Duration then begin
                        Message('%1', 'You cannot change the costs after posting');
                        Duration := xRec.Duration;
                    end;

                CurrencyRec.InitRoundingPrecision();

                if "Currency Code" = '' then
                    "Cost Of Training (LCY)" := Round("Cost Of Training", CurrencyRec."Amount Rounding Precision")
                else
                    "Cost Of Training (LCY)" := Round(
                        CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code",
                          "Cost Of Training", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                          CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(8; Location; Text[100])
        {
            TableRelation = if ("Country Code" = const('')) Destination."Destination Code"
            else
            if ("Country Code" = filter(<> '')) Destination."Destination Code" where("Country/Region Code" = field("Country Code"));
            Caption = 'Location';
        }
        field(9; Qualification; Code[30])
        {
            NotBlank = true;
            TableRelation = Qualification.Code;
            Caption = 'Qualification';
        }
        field(10; "Re-Assessment Date"; Date)
        {
            Caption = 'Re-Assessment Date';
        }
        field(11; Source; Code[50])
        {
            NotBlank = true;
            TableRelation = "Training Source & Facilitators".Source;
            Caption = 'Source';
        }
        field(12; "Need Source"; Option)
        {
            OptionCaption = 'Calendar,Appraisal,CPD, Adhoc,Disciplinary';
            OptionMembers = Calendar,Appraisal,CPD,Adhoc,Disciplinary;
            Caption = 'Need Source';
        }
        field(13; Provider; Code[20])
        {
            TableRelation = Vendor."No.";
            Caption = 'Training Provider';

            trigger OnValidate()
            begin
                if Vendor.Get(Provider) then
                    "Provider Name" := Vendor.Name;
            end;
        }
        field(14; Post; Boolean)
        {
            Caption = 'Post';
        }
        field(15; Posted; Boolean)
        {
            Editable = true;
            Caption = 'Posted';
        }
        field(16; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Department Code';
        }
        field(17; "Training Objectives"; Text[250])
        {
            Caption = 'Training Objectives';
        }
        field(18; Venue; Text[70])
        {
            Caption = 'Venue';
        }
        field(19; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Currency Code';

            trigger OnValidate()
            begin
                Validate("Cost Of Training");
            end;
        }
        field(20; Status; Option)
        {
            OptionCaption = 'New,Closed,Application,Cancelled';
            OptionMembers = Open,Closed,Application,Cancelled;
            Caption = 'Status';
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(22; "Cost Of Training (LCY)"; Decimal)
        {
            CalcFormula = sum("Training Needs Lines"."Amount (LCY)" where("Document No." = field(Code)));
            FieldClass = FlowField;
            Caption = 'Cost Of Training (LCY)';
        }
        field(23; "Provider Name"; Text[50])
        {
            Caption = 'Provider Name';
        }
        field(24; "No. of Participants"; Integer)
        {
            CalcFormula = count("Training Request" where("Training Need" = field(Code),
                                                          Status = filter(Released)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No. of Participants';
        }
        field(25; "Total Cost"; Decimal)
        {
            Editable = false;
            Caption = 'Total Cost';
        }
        field(26; "Total PerDiem"; Decimal)
        {
            Editable = false;
            Caption = 'Total PerDiem';
        }
        field(27; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(28; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(29; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(30; DimVal1; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 1 Code"),
                                                               "Global Dimension No." = const(1)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'DimVal1';
        }
        field(31; DimVal2; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 2 Code"),
                                                               "Global Dimension No." = const(2)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'DimVal2';
        }
        field(32; "Country Code"; Code[20])
        {
            TableRelation = "Country/Region".Code;
            Caption = 'Country Code';
        }
        field(33; Remarks; Text[150])
        {
            Caption = 'Remarks';
        }
        field(34; "Open/Closed"; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
            Caption = 'Open/Closed';
        }
        field(35; "Skill code"; Code[50])
        {
            TableRelation = "Skill Code";
            Caption = 'Skill code';
        }
        field(36; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            OptionMembers = " ","Individual","Organization","Board Members";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    // DrillDownPageId = "Training Needs Open";
    // LookupPageId = "Training Needs Open";
    trigger OnInsert()
    begin
        if Code = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Training Needs Nos");
            NoSeriesManagement.InitSeries(HRSetup."Training Needs Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        TrainingNeedsLines.Reset();
        TrainingNeedsLines.SetRange("Document No.", Code);
        if TrainingNeedsLines.FindFirst() then
            repeat
                TrainingNeedsLines."Start Date" := "Start Date";
                TrainingNeedsLines."End Date" := "End Date";
                TrainingNeedsLines."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                TrainingNeedsLines."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                TrainingNeedsLines."Dimension Set ID" := "Dimension Set ID";
                TrainingNeedsLines."Currency Code" := "Currency Code";
                TrainingNeedsLines.Modify();
            until TrainingNeedsLines.Next() = 0;
    end;

    var
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GenLedSetup: Record "General Ledger Setup";
        HRSetup: Record "Human Resources Setup";
        TrainingNeedsLines: Record "Training Needs Lines";
        Vendor: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Text001: Label 'The %1 %2 cannot be earlier than the %3 %4.';
        Text002: Label 'The %1 %2 cannot be after the %3 %4.';

    procedure ShowDocDim()
    begin
        /*         OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet2(
                    "Dimension Set ID", StrSubstNo('%1 %2', 'Training', Code),
                    "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                if OldDimSetID <> "Dimension Set ID" then begin
                    Modify();
                end; */
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





