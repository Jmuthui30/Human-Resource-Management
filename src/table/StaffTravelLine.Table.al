table 52002 "Staff Travel Line"
{
    DataClassification = CustomerContent;
    Caption = 'Staff Travel Line';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Mode of Transport"; Option)
        {
            OptionCaption = ' ,Air,Taxi,Company Car,Private Car,Bus';
            OptionMembers = " ",Air,Taxi,"Company Car","Private Car",Bus;
            Caption = 'Mode of Transport';
        }
        field(4; "Travel Date"; Date)
        {
            Caption = 'Travel Date';

            trigger OnValidate()
            begin
                "Return Date" := "Travel Date";
            end;
        }
        field(5; "Pick up Point"; Text[30])
        {
            Caption = 'Pick up Point';
        }
        field(6; "Pick up Time"; Time)
        {
            Caption = 'Pick up Time';
        }
        field(7; "Drop off Point"; Text[30])
        {
            Caption = 'Drop off Point';
        }
        field(8; "Drop off Time"; Time)
        {
            Caption = 'Drop off Time';
        }
        field(9; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                /*CreateDim(
                  Database::Employee,"Employee No.");
                  ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                  ValidateShortcutDimCode(2,"Global Dimension 2 Code");  */

            end;
        }
        field(10; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(11; Departure; Code[60])
        {
            Caption = 'Departure';
        }
        field(12; Destination; Code[60])
        {
            Caption = 'Destination';
        }
        field(13; "Pick Up Date"; Date)
        {
            Caption = 'Pick Up Date';

            trigger OnValidate()
            begin
                if "Return Date" <> 0D then
                    Validate("Return Date");
            end;
        }
        field(14; "Drop Off Date"; Date)
        {
            Caption = 'Drop Off Date';
        }
        field(15; "Full/Half Days"; Option)
        {
            OptionCaption = ' ,Full Day,Half Day';
            OptionMembers = " ","Full Day","Half Day";
            Caption = 'Full/Half Days';
        }
        field(16; "No. of Days"; Integer)
        {
            Caption = 'No. of Days';

            trigger OnValidate()
            begin
                "Return Date" := "Travel Date" + "No. of Days";
            end;
        }
        field(24; "Hotel Meal Plan"; Option)
        {
            OptionCaption = ' ,Full Boad,Half Boad,Bed and Breakfast';
            OptionMembers = " ","Full Boad","Half Boad","Bed and Breakfast";
            Caption = 'Hotel Meal Plan';
        }
        field(25; "Return Date"; Date)
        {
            Caption = 'Return Date';

            trigger OnValidate()
            begin
                if "Pick Up Date" > "Return Date" then
                    Error(Text000, FieldCaption("Return Date"), FieldCaption("Pick Up Date"));
            end;
        }
        field(26; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(28; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            Caption = 'Account Type';
        }
        field(29; "Account No"; Code[20])
        {
            Editable = true;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const(Vendor)) Vendor;
            Caption = 'Account No';

            trigger OnValidate()
            begin

                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            GLAccount.Get("Account No");
                            GLAccount.TestField("Direct Posting", true);
                            "Account Name" := GLAccount.Name;
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No") then;
                            "Account Name" := Vendor.Name;
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No");
                            "Account Name" := Customer.Name;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            Bank.Get("Account No");
                            "Account Name" := Bank.Name;
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Account No");
                            "Account Name" := FixedAsset.Description;
                        end;
                end;
                Validate(Amount);
            end;
        }
        field(30; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
        }
        field(31; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost';
        }
        field(32; Committed; Boolean)
        {
            Caption = 'Committed';
        }
        field(33; "Return Pick Up time"; Time)
        {
            Caption = 'Return Pick Up time';
        }
        field(34; "Return Drop Off time"; Time)
        {
            Caption = 'Return Drop Off time';
        }
        field(35; "Return Pickup Point"; Text[30])
        {
            Caption = 'Return Pickup Point';
        }
        field(36; "Return Drop  off Point"; Text[30])
        {
            Caption = 'Return Drop  off Point';
        }
        field(37; "Supplier Code"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Supplier Code';

            trigger OnValidate()
            begin

                if Vendor.Get("Supplier Code") then
                    "Supplier Name" := Vendor.Name;
            end;
        }
        field(38; "Supplier Name"; Text[150])
        {
            Caption = 'Supplier Name';
        }
        field(39; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(40; "Rate per km"; Decimal)
        {
            Caption = 'Rate per km';

            trigger OnValidate()
            begin
                Validate("KM Covered");
            end;
        }
        field(41; "KM Covered"; Decimal)
        {
            Caption = 'KM Covered';

            trigger OnValidate()
            begin
                Amount := "Rate per km" * "KM Covered";
                Validate(Amount);
            end;
        }
        field(42; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                "Total price" := Amount + PUWT + STPWT;
                Tax := 0.16 * "Total price";
                "Amount Inc VAT" := "Total price" + Tax;
            end;
        }
        field(43; PUWT; Decimal)
        {
            Caption = 'PUWT';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(44; STPWT; Decimal)
        {
            Caption = 'STPWT';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(45; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(46; "Total price"; Decimal)
        {
            Caption = 'Total price';
        }
        field(47; "Amount Inc VAT"; Decimal)
        {
            Caption = 'Amount Inc VAT';
        }
        field(48; Select; Boolean)
        {
            Caption = 'Select';

            trigger OnValidate()
            begin
                TestField(Actioned);
            end;
        }
        field(49; "Payment Status"; Option)
        {
            OptionCaption = 'Admin,Finance,Procurement,Invoiced';
            OptionMembers = Admin,Finance,Procurement,Invoiced;
            Caption = 'Payment Status';
        }
        field(50; Actioned; Boolean)
        {
            Caption = 'Actioned';

            trigger OnValidate()
            begin
                /* if Header.Get("No.") then
                    StaffMgt.SendActionEmail(Header); */
            end;
        }
        field(51; Status; Option)
        {
            CalcFormula = lookup("Staff Travel Request".Status where("No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
            Caption = 'Status';
        }
        field(52; "Cost/Budget Owner"; Option)
        {
            CalcFormula = lookup("Staff Travel Request"."Cost/Budget Owner" where("No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Official,Personal';
            OptionMembers = " ",Official,Personal;
            Caption = 'Cost/Budget Owner';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(481; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            Caption = 'Shortcut Dimension 3 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(482; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            Caption = 'Shortcut Dimension 4 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        /*if Header.Get("No.") then
         if Header.Status<>Header.Status::Open then
              Error('The Status must be open for you to make changes in this document');
        */

    end;

    var
        Bank: Record "Bank Account";
        Customer: Record Customer;
        Emp: Record Employee;
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        Vendor: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'The %1 cannot be earlier than the %2';

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*if StaffReq.Get("No.") then;
        if FieldNumber = 5 then
            if StaffReq."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, StaffReq."Dimension Set ID");
        if FieldNumber = 6 then
            if StaffReq."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, StaffReq."Dimension Set ID");
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);*/
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "No.", "Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        GLBudget: Record "G/L Budget Entry";
        StaffReq: Record "Staff Travel Request";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if ("No." <> '') and ("Line No." <> 0) then
            Modify();
        if (OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0)) then
            Modify();
        //IF SalesLinesExist THEN
        //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        //Fetch Output and Ourcome from Budget
        if StaffReq.Get("No.") then;
        if FieldNumber = 5 then begin
            GLSetup.Get();
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 3 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-') then begin
                //Global Dimensions
                OldDimSetID := "Dimension Set ID";
                if StaffReq."Multi-Donor" then
                    DimMgt.ValidateShortcutDimValues(1, "Shortcut Dimension 1 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(1, StaffReq."Global Dimension 1 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0)) then begin
                    //IF FINDSET THEN
                    Modify();
                    DimMgt.UpdateGlobalDimFromDimSetID(
                         "Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID := "Dimension Set ID";
                if StaffReq."Multi-Donor" then
                    DimMgt.ValidateShortcutDimValues(2, "Shortcut Dimension 2 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(2, StaffReq."Global Dimension 2 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0)) then begin
                    //IF FINDSET THEN
                    Modify();
                    DimMgt.UpdateGlobalDimFromDimSetID(
                         "Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID := "Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(3, GLBudget."Budget Dimension 1 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0)) then
                    //IF FINDSET THEN
                    Modify();
                //Dim Value 4
                OldDimSetID := "Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(4, GLBudget."Budget Dimension 2 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0)) then
                    //IF FINDSET THEN
                    Modify();
            end;
        end;
        //G/L Account
        if FieldNumber = 6 then begin
            GLSetup.Get();
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 4 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-') then begin
                if "Account Type" <> "Account Type"::"G/L Account" then
                    "Account Type" := "Account Type"::"G/L Account";
                //MODIFY;
                if "Account No" <> GLBudget."G/L Account No." then begin
                    "Account No" := GLBudget."G/L Account No.";
                    Validate("Account No");
                    //MODIFY;
                end;
            end;
        end;
    end;
}





