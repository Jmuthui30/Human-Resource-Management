table 52025 "Training Request"
{
    DrillDownPageId = "Training Request List";
    LookupPageId = "Training Request List";
    DataClassification = CustomerContent;
    Caption = 'Training Request';
    fields
    {
        field(1; "Request No."; Code[20])
        {
            Editable = true;
            Caption = 'Request No.';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(2; "Request Date"; Date)
        {
            Caption = 'Request Date';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(3; "Employee No"; Code[10])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation := Employee."Job Title";
                    "Salary Scale" := Employee."Salary Scale";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(5; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(6; "Department Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Department Code';
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            Caption = 'Status';
        }
        field(8; Designation; Text[100])
        {
            Caption = 'Designation';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(9; Period; DateFormula)
        {
            Caption = 'Period';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(10; "No. Of Days"; Decimal)
        {
            Caption = 'No. Of Days';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(11; "Training Insitution"; Text[50])
        {
            Caption = 'Training Insitution';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(12; Venue; Text[30])
        {
            Caption = 'Venue';

            trigger OnValidate()
            begin
                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual - Commitment;
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(13; "Tuition Fee"; Decimal)
        {
            CalcFormula = sum("Employees Travelling"."Tuition Fee" where("Request No." = field("Request No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Tuition Fee';

            trigger OnValidate()
            begin
                "Total Cost" := TravelEmp."Tuition Fee" + TravelEmp."Per Diem" + TravelEmp."Air Ticket";
                /*
                "Total Cost":="Tuition Fee"+"Per Diem"+"Air Ticket";
                if Status<>Status::Open then
                Error('Once document has been released it cannot be edited!');
                */

            end;
        }
        field(14; "Per Diem"; Decimal)
        {
            CalcFormula = sum("Employees Travelling"."Per Diem" where("Request No." = field("Request No.")));
            FieldClass = FlowField;
            Caption = 'Per Diem';

            trigger OnValidate()
            begin
                "Total Cost" := TravelEmp."Tuition Fee" + TravelEmp."Per Diem" + TravelEmp."Air Ticket";
                /*
                "Total Cost":="Tuition Fee"+"Per Diem"+"Air Ticket";
                if Status<>Status::Open then
                Error('Once document has been released it cannot be edited!');
                */

            end;
        }
        field(15; "Air Ticket"; Decimal)
        {
            CalcFormula = sum("Employees Travelling"."Air Ticket" where("Request No." = field("Request No.")));
            FieldClass = FlowField;
            Caption = 'Air Ticket';

            trigger OnValidate()
            begin
                "Total Cost" := TravelEmp."Tuition Fee" + TravelEmp."Per Diem" + TravelEmp."Air Ticket";
                /*
                "Total Cost":="Tuition Fee"+"Per Diem"+"Air Ticket";
                if Status<>Status::Open then
                Error('Once document has been released it cannot be edited!');
                */

            end;
        }
        field(16; "Total Cost"; Decimal)
        {
            CalcFormula = sum("Employees Travelling"."Total Cost" where("Request No." = field("Request No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Cost';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(17; "Course Title"; Code[20])
        {
            NotBlank = true;
            Caption = 'Course Title';

            trigger OnValidate()
            begin
                if TrainingNeeds.Get("Course Title") then
                    Description := TrainingNeeds.Description;
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(18; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(19; "Planned Start Date"; Date)
        {
            Caption = 'Planned Start Date';

            trigger OnValidate()
            begin

                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual;
            end;
        }
        field(20; "Planned End Date"; Date)
        {
            Caption = 'Planned End Date';

            trigger OnValidate()
            begin

                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual;

                "No. Of Days" := ("Planned End Date" - "Planned Start Date") + 1;
            end;
        }
        field(21; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Country Code';

            trigger OnValidate()
            begin
                if CountryRec.Get("Country Code") then
                    Currency := CountryRec.Name;
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(22; "CBK Website Address"; Text[250])
        {
            Caption = 'CBK Website Address';
        }
        field(23; "Exchange Rate"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Caption = 'Exchange Rate';

            trigger OnValidate()
            begin
                "Total Cost (LCY)" := "Exchange Rate" * "Total Cost";
                CalcFields(Budget, Actual);
                "Available Funds" := Budget - Actual;
            end;
        }
        field(24; "Total Cost (LCY)"; Decimal)
        {
            Caption = 'Total Cost (LCY)';
        }
        field(25; Currency; Code[10])
        {
            TableRelation = Currency;
            Caption = 'Currency';
        }
        field(26; Budget; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("Budget Name" = field("Budget Name"),
                                                               "G/L Account No." = field("GL Account"),
                                                               "Global Dimension 1 Code" = field("Department Code")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Budget';
        }
        field(27; Actual; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("GL Account"),
                                                        "Global Dimension 1 Code" = field("Department Code")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Actual';
        }
        field(28; Commitment; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
            Caption = 'Commitment';
        }
        field(29; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'GL Account';
        }
        field(30; "Budget Name"; Code[10])
        {
            Caption = 'Fiscal Year';
            TableRelation = "G/L Budget Name";
        }
        field(31; "Available Funds"; Decimal)
        {
            Caption = 'Available Funds';
        }
        field(32; "Need Source"; Option)
        {
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal,Succesion,Training,Employee,"Employee Skill Plan";
            Caption = 'Need Source';
        }
        field(33; "Training Objective"; Text[250])
        {
            Caption = 'Training Objective';
        }
        field(34; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(44; "Commisioner No"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Commisioner No';

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal.Code, "Commisioner No");
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                if DimVal.Find('-') then
                    "Commissioner Name" := DimVal.Name;
            end;
        }
        field(45; "Commissioner Name"; Text[30])
        {
            Caption = 'Commissioner Name';
        }
        field(46; Commissioner; Boolean)
        {
            Caption = 'Commissioner';
        }
        field(47; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Global Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(48; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Global Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(49; "Training Need"; Code[20])
        {
            TableRelation = "Training Need" where(Status = const(Application), "Applicant Type" = const(Individual));
            Caption = 'Training Need';

            trigger OnValidate()
            var
                Participants: Record "Training Participants";
            begin

                TrainingRequest.SetRange("Employee No", "Employee No");
                TrainingRequest.SetRange("Training Need", "Training Need");
                if TrainingRequest.FindFirst() then
                    Error('You have already applied for Training %1 . Kindly choose a new one', "Training Need");

                if TrainingNeeds.Get("Training Need") then
                    if TrainingNeeds."Open/Closed" = TrainingNeeds."Open/Closed"::Open then begin
                        TrainingNeeds.CalcFields("Cost Of Training", "Cost Of Training (LCY)");
                        "Planned Start Date" := TrainingNeeds."Start Date";
                        "Planned End Date" := TrainingNeeds."End Date";
                        "No. Of Days" := ("Planned End Date" - "Planned Start Date") + 1;
                        Destination := TrainingNeeds.Location;
                        Description := TrainingNeeds.Description;
                        "Global Dimension 1 Code" := TrainingNeeds."Shortcut Dimension 1 Code";
                        "Global Dimension 2 Code" := TrainingNeeds."Shortcut Dimension 2 Code";
                        "Dimension Set ID" := TrainingNeeds."Dimension Set ID";
                        Venue := TrainingNeeds.Venue;
                        "Country Code" := TrainingNeeds."Country Code";
                        "Cost of Training" := TrainingNeeds."Cost Of Training";
                        "Cost of Training (LCY)" := TrainingNeeds."Cost Of Training (LCY)";
                    end else begin
                        Participants.SetRange("Employee No", "Employee No");
                        if not Participants.FindFirst() then Error('This training can only be applied by shortlisted participants');
                    end;

                //InsertPerDiemCost();
            end;
        }
        field(50; Destination; Code[20])
        {
            TableRelation = Destination."Destination Code";
            Caption = 'Destination';
        }
        field(51; "Cost of Training"; Decimal)
        {
            CalcFormula = sum("Training Request Lines".Amount where("Document No." = field("Request No.")));
            FieldClass = FlowField;
            Caption = 'Cost of Training';
        }
        field(52; "Cost of Training (LCY)"; Decimal)
        {
            CalcFormula = sum("Training Request Lines"."Amount (LCY)" where("Document No." = field("Request No.")));
            FieldClass = FlowField;
            Caption = 'Cost of Training (LCY)';
        }
        field(53; "Salary Scale"; Code[30])
        {
            TableRelation = "Salary Scale".Scale;
            Caption = 'Salary Scale';
        }
        field(54; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(55; Adhoc; Boolean)
        {
            Caption = 'Adhoc';
        }
        field(56; "Training Objectives"; Text[250])
        {
            Caption = 'Training Objectives';
        }
    }

    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Request No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Training Request Nos");
            NoSeriesMgt.InitSeries(HRSetup."Training Request Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            "GL Account" := HRSetup."Account No (Training)";
        end;

        "User ID" := UserId;
        if UserSetup.Get(UserId) then begin
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.Find('-') then
                "Employee No" := Employee."No.";
            "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            Designation := Employee."Job Title";
            "Salary Scale" := Employee."Salary Scale";
        end;

        "Request Date" := Today;
    end;

    var
        CountryRec: Record "Country/Region";
        DimVal: Record "Dimension Value";
        Employee: Record Employee;
        TravelEmp: Record "Employees Travelling";
        HRSetup: Record "Human Resources Setup";
        TrainingNeeds: Record "Training Need";
        TrainingRequest: Record "Training Request";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure CheckStatus(): Boolean
    begin
        if Status = Status::Released then
            exit(true)
        else
            exit(false);
    end;

    local procedure GetEmployeePerDiem(JobGroup: Code[20]; Destination: Code[20]): Decimal
    var
        DestinationRate: Record "Destination Rate Entry";
    begin
        DestinationRate.Reset();
        DestinationRate.SetRange("Employee Job Group", JobGroup);
        DestinationRate.SetRange("Destination Code", Destination);
        //DestinationRate.SetRange("Rate Type", DestinationRate."Rate Type"::Training);
        if DestinationRate.FindFirst() then
            exit(DestinationRate."Daily Rate (Amount)");
        exit(0);
    end;

    /* local procedure InsertPerDiemCost()
    var
        ExpenseCode: Record "Expense Code";
        TrainingNeedsLines: Record "Training Needs Lines";
        TrainingRequestLines: Record "Training Request Lines";
    begin
        ExpenseCode.Reset();
        ExpenseCode.SetRange("Per Diem", true);
        if ExpenseCode.FindFirst() then begin
            TrainingNeedsLines.Reset();
            TrainingNeedsLines.SetRange("Document No.", "Training Need");
            TrainingNeedsLines.SetRange("Expense Code", ExpenseCode.Code);
            if TrainingNeedsLines.FindFirst() then begin
                TrainingRequestLines.Reset();
                TrainingRequestLines.SetRange("Document No.", "Request No.");
                if TrainingRequestLines.FindFirst() then
                    TrainingRequestLines.DeleteAll();
                TrainingRequestLines.Init();
                TrainingRequestLines."Document No." := "Request No.";
                TrainingRequestLines."Employee No" := "Employee No";
                TrainingRequestLines."Expense Code" := ExpenseCode.Code;
                TrainingRequestLines."Training Need No" := "Training Need";
                TrainingRequestLines."G/L Account" := TrainingNeedsLines."G/L Account";
                TrainingRequestLines."Currency Code" := TrainingNeedsLines."Currency Code";
                TrainingRequestLines.Validate(Amount, (GetEmployeePerDiem("Salary Scale", Destination) * "No. Of Days"));
                TrainingRequestLines."Per Diem" := true;
                if TrainingRequestLines.Amount <> 0 then
                    TrainingRequestLines.Insert();
            end;
        end;
    end; */

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin

        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Employee,"No.",FieldNumber,ShortcutDimCode);
        Modify();
    end;
}





