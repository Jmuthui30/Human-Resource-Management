table 52088 "Communication Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Communication Lines';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Category; Option)
        {
            OptionCaption = ' ,Vendor,Customer,Student,Staff,Contact,Department';
            OptionMembers = " ",Vendor,Customer,Student,Staff,Contact,Department;
            Caption = 'Category';
        }
        field(3; "Recipient No."; Code[20])
        {
            Caption = 'Recipient No.';
        }
        field(4; "Recipient Name"; Text[250])
        {
            Caption = 'Recipient Name';
        }
        field(5; "Recipient E-Mail"; Text[250])
        {
            Caption = 'Recipient E-Mail';
        }
        field(6; "Recipient Phone No."; Text[30])
        {
            Caption = 'Recipient Phone No.';
        }
        field(7; "E-Mail Sent"; Boolean)
        {
            Caption = 'E-Mail Sent';
        }
        field(8; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");

                DimValue.Reset();
                DimValue.SetRange(Code, "Shortcut Dimension 2 Code");
                if DimValue.Find('-') then
                    "Department Name" := DimValue.Name;
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(481; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
        }
    }

    keys
    {
        key(Key1; "No.", Category, "Recipient No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimValue: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





