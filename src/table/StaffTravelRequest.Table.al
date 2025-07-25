table 52001 "Staff Travel Request"
{
    DataClassification = CustomerContent;
    Caption = 'Staff Travel Request';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Global Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Global Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(6; Branch; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
            Caption = 'Branch';
        }
        field(7; "Cost/Budget Owner"; Option)
        {
            OptionCaption = ' ,Official,Personal';
            OptionMembers = " ",Official,Personal;
            Caption = 'Cost/Budget Owner';
        }
        field(8; "Reason for Travel"; Text[250])
        {
            Caption = 'Reason for Travel';
        }
        field(9; "Mode of Transport"; Option)
        {
            OptionCaption = ' ,Taxi,Company Car';
            OptionMembers = " ",Taxi,"Company Car";
            Caption = 'Mode of Transport';
        }
        field(10; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
            Caption = 'Status';
        }
        field(11; "Departure City"; Code[10])
        {
            Caption = 'Departure City';
        }
        field(12; "Arrival City"; Code[10])
        {
            Caption = 'Arrival City';
        }
        field(13; "Departure Date"; Date)
        {
            Caption = 'Departure Date';
        }
        field(14; "Arrival Date"; Date)
        {
            Caption = 'Arrival Date';
        }
        field(15; "Full/Half Days"; Option)
        {
            OptionCaption = ' ,Full Day,Half Day';
            OptionMembers = " ","Full Day","Half Day";
            Caption = 'Full/Half Days';
        }
        field(16; "No. of Days"; Decimal)
        {
            Caption = 'No. of Days';
        }
        field(17; "Pick up Point"; Text[30])
        {
            FieldClass = Normal;
            Caption = 'Pick up Point';
        }
        field(18; "Drop off Point"; Text[30])
        {
            Caption = 'Drop off Point';
        }
        field(19; "Pick up Time"; Time)
        {
            Caption = 'Pick up Time';
        }
        field(20; "Drop off Time"; Time)
        {
            Caption = 'Drop off Time';
        }
        field(21; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
        }
        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(23; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(24; "Hotel Meal Plan"; Option)
        {
            OptionCaption = ' ,Full Boad,Half Boad,Bed and Breakfast';
            OptionMembers = " ","Full Boad","Half Boad","Bed and Breakfast";
            Caption = 'Hotel Meal Plan';
        }
        field(25; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            Caption = 'Department';
        }
        field(26; Purpose; Option)
        {
            OptionCaption = 'Administration,Commercial';
            OptionMembers = Administration,Commercial;
            Caption = 'Purpose';
        }
        field(27; "Customer Code"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer Code';

            trigger OnValidate()
            begin
                if Cust.Get("Customer Code") then
                    "Customer Name" := Cust.Name;
            end;
        }
        field(28; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(29; "Supplier Code"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Supplier Code';

            trigger OnValidate()
            begin
                if Vend.Get("Supplier Code") then
                    "Supplier Name" := Vend.Name;
            end;
        }
        field(30; "Supplier Name"; Text[30])
        {
            Caption = 'Supplier Name';
        }
        field(31; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(32; Pax; Integer)
        {
            CalcFormula = count("Staff Travel Line" where("No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Pax';
        }
        field(33; "Multi-Donor"; Boolean)
        {
            Caption = 'Multi-Donor';
        }
        field(34; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Staff Travel Line"."Estimated Cost" where("No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Total Amount';
        }
        field(35; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
            Caption = 'Currency Code';
        }
        field(36; "Rate per km"; Decimal)
        {
            Caption = 'Rate per km';
        }
        field(37; "KM Covered"; Decimal)
        {
            Caption = 'KM Covered';

            trigger OnValidate()
            begin
                Amount := "Rate per km" * "KM Covered";
                Validate(Amount);
            end;
        }
        field(38; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                "Total price" := Amount + PUWT + STPWT;
                Tax := 0.16 * "Total price";
                "Amount Inc VAT" := "Total price" + 1.16;
            end;
        }
        field(39; PUWT; Decimal)
        {
            Caption = 'PUWT';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(40; STPWT; Decimal)
        {
            Caption = 'STPWT';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(41; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(42; "Total price"; Decimal)
        {
            Caption = 'Total price';
        }
        field(43; "Amount Inc VAT"; Decimal)
        {
            Caption = 'Amount Inc VAT';
        }
        field(44; Select; Boolean)
        {
            Caption = 'Select';

            trigger OnValidate()
            begin
                TestField(Actioned);
            end;
        }
        field(45; "Payment Status"; Option)
        {
            OptionCaption = 'Admin,Finance,Procurement,Invoiced';
            OptionMembers = Admin,Finance,Procurement,Invoiced;
            Caption = 'Payment Status';
        }
        field(46; Actioned; Boolean)
        {
            Caption = 'Actioned';
        }
        field(47; Comments; Text[60])
        {
            Description = '<Comments>';
            Caption = 'Comments';
        }
        field(48; "Created By"; Code[50])
        {
            Editable = false;
            Caption = 'Created By';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "Payment Status", "Supplier Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error('The Status must be open for you to make changes in this document');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Staff Req Nos.");
            NoSeriesmgt.InitSeries(HRSetup."Staff Req Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if UserSetup.Get(UserId) then begin
            "Employee No." := UserSetup."Employee No.";
            Validate("Employee No.");
        end;
        /*
        CreateDim(
          Database::Employee,"Employee No.");
        */
        "Created By" := UserId;

    end;

    trigger OnModify()
    begin
        /*Message('%1',Status);
         if Status<>Status::Open then
         Error('The Status must be open for you to make changes in this document');
       */

    end;

    var
        Cust: Record Customer;
        Emp: Record Employee;
        HRSetup: Record "Human Resources Setup";
        StaffReqLine: Record "Staff Travel Line";
        UserSetup: Record "User Setup";
        Vend: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesmgt: Codeunit NoSeriesManagement;
        Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';

    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        No: array[10] of Code[20];
        TableID: array[10] of Integer;
    begin
        TableID[1] := Type1;
        No[1] := No1;
        /*
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        */
        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        /* "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID, No, '', "Global Dimension 1 Code", "Global Dimension 2 Code", "Dimension Set ID", 5200); */

    end;

    procedure FormatStatus(CurrStatus: Integer): Integer
    var
        ApprovalEntry: Record "Approval Entry";
        NoOfApprovals: Integer;
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordId);
        ApprovalEntry.SetRange("Related to Change", false);
        if ApprovalEntry.Find('-') then begin
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
            ApprovalEntry.SetRange("Record ID to Approve", RecordId);
            ApprovalEntry.SetRange("Related to Change", false);
            ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Approved);
            NoOfApprovals := ApprovalEntry.Count;
            case true of
                NoOfApprovals = 0:
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
                        ApprovalEntry.SetRange("Record ID to Approve", RecordId);
                        ApprovalEntry.SetRange("Related to Change", false);
                        ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Rejected);
                        NoOfApprovals := ApprovalEntry.Count;
                        if NoOfApprovals <> 0 then
                            exit(DocStatus::Rejected)
                        else begin
                            ApprovalEntry.Reset();
                            ApprovalEntry.SetRange("Table ID", RecordId.TableNo);
                            ApprovalEntry.SetRange("Record ID to Approve", RecordId);
                            ApprovalEntry.SetRange("Related to Change", false);
                            ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Open);
                            NoOfApprovals := ApprovalEntry.Count;
                            if NoOfApprovals <> 0 then
                                exit(DocStatus::"Approval Pending")
                            else
                                exit(DocStatus::New);
                        end;
                    end;
                NoOfApprovals = 1:
                    exit(DocStatus::"HOD Approved");
                NoOfApprovals = 2:
                    exit(DocStatus::"Finance Approved");
                NoOfApprovals = 3:
                    exit(DocStatus::"DED/DFA Approved");
                NoOfApprovals = 4:
                    exit(DocStatus::"DED/DFA Approved");
            end;
        end else
            exit(CurrStatus);
    end;

    procedure GetAccountNo(): Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then;
        UserSetup.TestField("Employee No.");
        exit(UserSetup."Employee No.");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //TESTFIELD("Check Printed",FALSE);
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions()
    begin
        /*"Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID",StrSubstNo('%1 %2 %3',"Journal Template Name","Journal Batch Name","Line No."),
            "Global Dimension 1 Code","Global Dimension 2 Code");
         */

    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure StaffReqLinesExist(): Boolean
    begin
        StaffReqLine.Reset();
        StaffReqLine.SetRange(StaffReqLine."No.", "No.");
        exit(StaffReqLine.FindFirst());
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        /*
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"Staff Travel Request","No.",FieldNumber,ShortcutDimCode);
        //MODIFY;
        */
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify();
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if StaffReqLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;

    end;

    local procedure SendEmail()
    begin
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(Text051) then
            exit;
        StaffReqLine.Reset();
        StaffReqLine.SetRange("No.", "No.");
        StaffReqLine.LockTable();
        if StaffReqLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(StaffReqLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if StaffReqLine."Dimension Set ID" <> NewDimSetID then begin
                    StaffReqLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      StaffReqLine."Dimension Set ID", StaffReqLine."Shortcut Dimension 1 Code", StaffReqLine."Shortcut Dimension 2 Code");
                    StaffReqLine.Modify();
                end;
            until StaffReqLine.Next() = 0;
    end;
}





