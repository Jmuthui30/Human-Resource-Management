table 52087 "Communication Header"
{
    DataClassification = CustomerContent;
    Caption = 'Communication Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                case Type of
                    Type::Communication:

                        if "No." <> xRec."No." then
                            NoSeriesMgt.TestManual(ICTSetup."Communication Nos");
                /* Type::"Audit Notification":
                    begin
                        if "No." <> xRec."No." then
                            NoSeriesMgt.TestManual(AuditSetup."Audit Notification Nos.");
                    end;
                Type::Audit:
                    begin
                        if "No." <> xRec."No." then
                            NoSeriesMgt.TestManual(AuditSetup."Risk Reporting Nos.");
                    end; */
                end;
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(4; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Pending,Sent,Complete';
            OptionMembers = Pending,Sent,Complete;
            Caption = 'Status';
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(7; "Communication Type"; Option)
        {
            OptionCaption = 'E-Mail,SMS,E-Mail & SMS';
            OptionMembers = "E-Mail",SMS,"E-Mail & SMS";
            Caption = 'Communication Type';
        }
        field(8; "E-Mail Body"; BLOB)
        {
            Caption = 'E-Mail Body';
        }
        field(9; "SMS Text"; BLOB)
        {
            Caption = 'SMS Text';
        }
        field(10; "E-Mail Subject"; Text[250])
        {
            Caption = 'E-Mail Subject';
        }
        field(11; Attachment; Text[250])
        {
            Caption = 'Attachment';
        }
        field(12; Type; Option)
        {
            OptionCaption = ' ,Communication,Audit,Audit Notification';
            OptionMembers = " ",Communication,Audit,"Audit Notification";
            Caption = 'Type';
        }
        field(13; "Sender Email"; Text[100])
        {
            Caption = 'Sender Email';
        }
        field(14; Sent; Boolean)
        {
            Caption = 'Sent';
        }
        field(15; Receipient; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Receipient';

            trigger OnValidate()
            begin

                if Employee.Get(Receipient) then begin
                    "Receipient Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Receipient E-Mail" := Employee."E-Mail";
                end;
            end;
        }
        field(16; "Receipient Name"; Text[100])
        {
            Caption = 'Receipient Name';
        }
        field(17; "Receipient E-Mail"; Text[100])
        {
            Caption = 'Receipient E-Mail';
        }
        field(18; Sender; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Sender';

            trigger OnValidate()
            begin
                if Employee.Get(Sender) then begin
                    "Sender Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Sender Email" := Employee."E-Mail";
                end;
            end;
        }
        field(19; "Sender Name"; Text[100])
        {
            Caption = 'Sender Name';
        }
        field(20; "Auditer Name"; Text[100])
        {
            Caption = 'Auditer Name';
        }
        field(21; "Audit Firm"; Text[100])
        {
            Caption = 'Audit Firm';
        }
        field(22; "Shortcut Dimension 1 Code"; Code[20])
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
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");

                /*
                DimValue.Reset();
                DimValue.SetRange(Code,"Shortcut Dimension 2 Code");
                if DimValue.Find('-') then
                  "Department Name" := DimValue.Name;
                */

            end;
        }
        field(24; "Dimension Set ID"; Integer)
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
        field(25; "Notify Department"; Boolean)
        {
            Caption = 'Notify Department';
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

        ICTSetup.Get();
        //AuditSetup.Get();

        if "No." = '' then
            case Type of
                Type::Communication:
                    begin
                        ICTSetup.TestField("Communication Nos");
                        if "No." = '' then
                            NoSeriesMgt.InitSeries(ICTSetup."Communication Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
            /* Type::"Audit Notification":
                begin
                    AuditSetup.TestField("Audit Notification Nos.");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(AuditSetup."Audit Notification Nos.", xRec."No. Series", Today, "No.", "No. Series");
                end;
            Type::Audit:
                begin
                    AuditSetup.TestField("Risk Reporting Nos.");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(AuditSetup."Risk Reporting Nos.", xRec."No. Series", Today, "No.", "No. Series");
                end; */
            end;


        "Created By" := UserId;

        if UserSetup.Get(UserId) then
            if Employee.Get(UserSetup."Employee No.") then begin
                Sender := Employee."No.";
                "Sender Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Sender Email" := Employee."E-Mail";
                "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                Validate("Shortcut Dimension 1 Code");
                "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
            end;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
    end;

    var
        //AuditSetup: Record "Audit Setup";
        Employee: Record Employee;
        ICTSetup: Record "ICT Setup";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





