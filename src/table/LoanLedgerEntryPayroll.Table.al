table 52158 "Loan Ledger Entry-Payroll"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Ledger Entry-Payroll';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Loan No."; Code[30])
        {
            Caption = 'Loan No.';
        }
        field(3; "Employee No."; Code[30])
        {
            TableRelation = if ("Loan Customer Type" = const(Staff)) Employee
            else
            if ("Loan Customer Type" = const("External Customer")) Customer;
            Caption = 'Employee No.';
        }
        field(4; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Principal,Interest,Principal Repayment,Interest Repayment,Settlement';
            OptionMembers = " ",Principal,Interest,"Principal Repayment","Interest Repayment",Settlement;
            Caption = 'Transaction Type';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(7; "Payment Mode"; Option)
        {
            OptionCaption = 'G/L Account,Bank Account,Cash,Cheque,EFT,RTGS,MPESA,PDQ';
            OptionMembers = "G/L Account","Bank Account",Cash,Cheque,EFT,RTGS,MPESA,PDQ;
            Caption = 'Payment Mode';
        }
        field(8; "Payment Reference No."; Text[100])
        {
            Caption = 'Payment Reference No.';
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(11; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(12; "Debtor's Code"; Code[30])
        {
            TableRelation = Customer;
            Caption = 'Debtor''s Code';
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
            Caption = 'Dimension Set ID';
        }
        field(16; "Transaction Date"; DateTime)
        {
            Caption = 'Transaction Date';
        }
        field(17; "Loan Customer Type"; Option)
        {
            OptionCaption = 'Staff,External Customer';
            OptionMembers = Staff,"External Customer";
            Caption = 'Loan Customer Type';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





