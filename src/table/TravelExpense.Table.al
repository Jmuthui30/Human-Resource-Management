table 52042 "Travel Expense"
{
    DataClassification = CustomerContent;
    Caption = 'Travel Expense';
    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';

            trigger OnValidate()
            begin
                /*
                RequestHeader.Reset();
                if RequestHeader.Get("Document No") then
                  "Customer A/C":=RequestHeader."Customer A/C";
                */

            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(5; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure';
        }
        field(6; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
                "Requested Amount" := Quantity * "Unit Price";
            end;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                /*
                //Check Whether amount exceeds the budget
                //Budget Amount
                GLSetup.Get();
                BudgetEntry.SetRange(BudgetEntry."Budget Name",GLSetup."Current Budget");
                BudgetEntry.SetRange(BudgetEntry."G/L Account No.","Account No");
                BudgetEntry.CalcFields(BudgetEntry.Amount);
                BudgetAmount:=BudgetEntry.Amount;
                
                //Get The Net Change
                GLEntry.SetRange(GLEntry."G/L Account No.","Account No");
                */

            end;
        }
        field(8; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            Caption = 'Account Type';
        }
        field(9; "Account No"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";
            Caption = 'Account No';

            trigger OnValidate()
            begin
                /*
                
                if "Account No" <> '' then begin
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.","Account No");
                GLEntry.SetRange(GLEntry."Global Dimension 1 Code","Global Dimension 1 Code");
                GLEntry.SetRange(GLEntry."Global Dimension 2 Code","Global Dimension 2 Code");
                GLEntry.SetRange("Global Dimension 3 Code","Cost Centre" );
                GLEntry.CalcSums(Amount);
                if GLEntry.Find('-') then begin
                "Actual Spent":=GLEntry.Amount;
                end;
                GLSetup.Get();
                BudgetEntry.Reset();
                BudgetEntry.SetRange(BudgetEntry."Budget Name",GLSetup."Current Budget");
                BudgetEntry.SetRange(BudgetEntry."G/L Account No.","Account No");
                BudgetEntry.SetRange(BudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
                BudgetEntry.SetRange(BudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
                BudgetEntry.SetRange(BudgetEntry."Budget Dimension 1 Code","Cost Centre");
                BudgetEntry.CalcSums(Amount);
                if BudgetEntry.Find('-') then
                "Available Budget":=BudgetEntry.Amount-"Actual Spent";
                //BudgetEntry.SETRANGE(BudgetEntry."Budget Dimension 4 Code");
                
                end;
                
                */

            end;
        }
        field(10; "Transaction Type"; Code[50])
        {
            Caption = 'Transaction Type';

            trigger OnValidate()
            begin
                /*
                
                if
                  TransactionTypeRec.Get("Transaction Type") then begin
                  "Account Type":=TransactionTypeRec."Account Type";
                  "Account No":=TransactionTypeRec."Account No.";
                  Description:=TransactionTypeRec."Transaction Name";
                end;
                
                */

            end;
        }
        field(11; "Reference No"; Code[20])
        {
            Caption = 'Reference No';
        }
        field(12; "Requested Amount"; Decimal)
        {
            Caption = 'Requested Amount';
        }
        field(13; Type; Code[10])
        {
            Caption = 'Type';

            trigger OnValidate()
            begin
                /*
                
                if RequestHeader.Get("Document No") then
                begin
                if TravelRates.Get(RequestHeader."Job Group",RequestHeader.Country,RequestHeader.City,Type) then
                begin
                "Unit Price":=TravelRates.Amount;
                end
                
                end;
                
                */

            end;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(16; "Asset No"; Code[20])
        {
            TableRelation = "Fixed Asset";
            Caption = 'Asset No';
        }
        field(23; "Actual Spent"; Decimal)
        {
            Caption = 'Actual Spent';

            trigger OnValidate()
            begin
                "Remaining Amount" := Amount - "Actual Spent";
            end;
        }
        field(24; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
        }
        field(25; "Entry No"; Integer)
        {
            TableRelation = "Cust. Ledger Entry" where("Customer No." = field("Customer A/C"),
                                                        Open = const(true));
            Caption = 'Entry No';

            trigger OnValidate()
            begin
                /*

                CustLedger.Reset();
                CustLedger.SetRange(CustLedger."Entry No.","Entry No");
                CustLedger.SetRange(CustLedger.Open,true);
                if CustLedger.Find('-') then
                begin
                 Description:=CustLedger.Description;
                 Quantity:=1;
                 CustLedger.CalcFields(CustLedger."Remaining Amount",CustLedger.Amount);
                 "Unit Price":=CustLedger."Remaining Amount";
                 Amount:=CustLedger."Remaining Amount";
                 //MESSAGE('RemainingAmt=%1\RequestedAmt=%2',CustLedger.Amount,"Requested Amount");
                 "Reference No":=CustLedger."Document No.";
                // MESSAGE('Reference=%1',CustLedger."Document No.");
                end;

               */

            end;
        }
        field(26; "Customer A/C"; Code[30])
        {
            Caption = 'Customer A/C';
        }
        field(27; "Expense Type"; Option)
        {
            OptionCaption = 'Accountable Expenses,Non-Accountable Expenses';
            OptionMembers = "Accountable Expenses","Non-Accountable Expenses";
            Caption = 'Expense Type';
        }
        field(28; Surrender; Boolean)
        {
            Caption = 'Surrender';

            trigger OnValidate()
            begin
                /*
                
                if "Expense Type"="Expense Type"::"Non-Accountable Expenses" then
                    Error(Text000);
                if Amount=0 then
                  Error(Text001);
                
                
                */

            end;
        }
        field(29; "Available Budget"; Decimal)
        {
            Caption = 'Available Budget';
        }
        field(30; "Cost Centre"; Code[10])
        {
            Caption = 'Cost Centre';

            trigger OnValidate()
            begin

                /*
                
                Dimen:="Cost Centre";
                Dimen:=CopyStr(Dimen, 1, 3);
                "Global Dimension 2 Code":=Dimen;
                Dimens:="Cost Centre";
                Dimens:=CopyStr(Dimens, 1 , 1);
                "Global Dimension 1 Code":=Dimens;
                
                
                */

            end;
        }
        field(31; "FSC Code"; Code[10])
        {
            Caption = 'FSC Code';
        }
        field(32; "Fn Code"; Code[10])
        {
            Caption = 'Fn Code';
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





