table 52168 "Education Institution"
{
    Caption = 'Education Institution';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Education Intitutions";
    LookupPageId = "Education Intitutions";

    fields
    {
        field(1; "Institution Code"; Code[20])
        {
            Caption = 'Institution Code';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Institution Code" <> xRec."Institution Code" then begin
                    HRSetup.Get();
                    HRSetup.TestField("Education Institution Nos");
                    NoSeriesMgt.TestManual(HRSetup."Education Institution Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Institution Name"; Text[250])
        {
            Caption = 'Institution Name';
            DataClassification = SystemMetadata;
        }
        field(3; "Type"; Enum "Education Institution Type")
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(4; "No. Series"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'No. Series';
        }
    }
    keys
    {
        key(PK; "Institution Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Institution Code", "Institution Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Institution Code" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Education Institution Nos");
            NoSeriesMgt.InitSeries(HRSetup."Education Institution Nos", xRec."No. Series", 0D, "Institution Code", "No. Series");
        end;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}






