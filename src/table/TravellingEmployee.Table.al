table 52044 "Travelling Employee"
{
    DataClassification = CustomerContent;
    Caption = 'Travelling Employee';
    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
        }
        field(2; "Employee No."; Code[10])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin

                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Shortcut Dimension 1" := Employee."Global Dimension 1 Code";
                    Validate("Shortcut Dimension 1");
                    "Department Code" := Employee."Global Dimension 1 Code";
                    Validate("Department Code");
                    //DimVal.Reset;
                    //DimVal.SetRange(Code, "Department Code");
                    //if DimVal.Find('-') then begin
                    //"Department Name" := DimVal.Name;
                    //end;
                    GetJobGroup();
                end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(4; Source; Text[50])
        {
            Caption = 'Source';
        }
        field(5; Destination; Text[50])
        {
            Caption = 'Destination';
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "Return Date"; Date)
        {
            Caption = 'Return Date';
        }
        field(8; "Travel Insurance"; Boolean)
        {
            Caption = 'Travel Insurance';
        }
        field(9; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(Code, "Shortcut Dimension 1");
                if DimVal.Find('-') then
                    "Department Name" := DimVal.Name;
            end;
        }
        field(10; "Department Name"; Text[50])
        {
            FieldClass = Normal;
            Caption = 'Department Name';
        }
        field(11; "Directorate Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
            Caption = 'Directorate Code';
        }
        field(12; "Directorate name"; Text[50])
        {
            Caption = 'Directorate name';
        }
        field(13; "Per Diem"; Decimal)
        {
            Caption = 'Per Diem';
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(15; Itinerary; Text[30])
        {
            Caption = 'Itinerary';
        }
        field(16; "Ticket Type"; Option)
        {
            OptionCaption = ',Economy,Business';
            OptionMembers = ,Economy,Business;
            Caption = 'Ticket Type';
        }
        field(17; "Cost Centre"; Code[10])
        {
            Caption = 'Cost Centre';
        }
        field(18; "FSC Code"; Code[20])
        {
            Caption = 'FSC Code';
        }
        field(19; "Shortcut Dimension 1"; Code[30])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1';
        }
        field(20; "Shortcut Dimension 2"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2';
        }
    }

    keys
    {
        key(Key1; "Request No.", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimVal: Record "Dimension Value";
        Employee: Record Employee;

    procedure GetJobGroup()
    var
        DestinationRate: Record "Destination Rate Entry";
        Employee: Record Employee;
        TransReq: Record "Travel Requests";
        JobGrade: Code[30];
    begin
        Employee.Reset();
        Employee.SetRange("No.", "Employee No.");
        if Employee.FindFirst() then begin
            Employee.TestField("Salary Scale");
            //EXIT(Employee."Salary Scale");
            JobGrade := Employee."Salary Scale";

            TransReq.Reset();
            TransReq.SetRange("Request No.", "Request No.");
            if TransReq.Find('-') then begin
                DestinationRate.Reset();
                DestinationRate.SetRange("Employee Job Group", JobGrade);
                DestinationRate.SetRange("Destination Code", TransReq.Destinations);
                if DestinationRate.Find('-') then
                    "Per Diem" := DestinationRate."Daily Rate (Amount)";
            end;
        end;
    end;
}





