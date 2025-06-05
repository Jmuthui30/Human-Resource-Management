table 52149 "Loan Interest Header"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Interest Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get();
                    HRSetup.TestField("Loan Interest Nos");
                    NoSeriesManagement.TestManual(HRSetup."Loan Interest Nos");
                end;
            end;
        }
        field(2; "Date Entered"; Date)
        {
            Caption = 'Date Entered';
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Period Reference"; Date)
        {
            TableRelation = "Payroll Period"."Starting Date" where(Closed = const(false));
            Caption = 'Period Reference';

            trigger OnValidate()
            var
                PeriodRec: Record "Payroll Period";
            begin
                if PeriodRec.Get("Period Reference") then begin
                    "Period Narration" := PeriodRec.Name + ' ' + Format(Date2DMY("Period Reference", 3));
                    Description := StrSubstNo('%1 Interest Charged', "Period Narration");
                end;
            end;
        }
        field(7; "Period Narration"; Text[30])
        {
            Caption = 'Period Narration';
        }
        field(8; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(9; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(12; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(13; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(14; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
        }
        field(15; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
        }
        field(16; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(17; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
        }
        field(18; "Date Reversed"; Date)
        {
            Caption = 'Date Reversed';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Loan Interest Nos");
            NoSeriesManagement.InitSeries(HRSetup."Loan Interest Nos", xRec."No Series", 0D, "No.", "No Series");
        end;

        "Created By" := UserId;
        "Date Entered" := Today;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesManagement: Codeunit NoSeriesManagement;

    procedure ShowDocDim()
    begin
        /*         OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet2(
                    "Dimension Set ID", StrSubstNo('%1 %2', 'Interest Doc', "No."),
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
        if "No." <> '' then
            Modify();
    end;
}





