table 52062 "Employees Travelling"
{
    DataClassification = CustomerContent;
    Caption = 'Employees Travelling';
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
        field(2; "Employee No"; Code[10])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //Transp.GetJobGroup;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(4; "Tuition Fee"; Decimal)
        {
            Caption = 'Tuition Fee';

            trigger OnValidate()
            begin
                "Total Cost" := "Tuition Fee" + "Per Diem" + "Air Ticket";
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(5; "Per Diem"; Decimal)
        {
            Caption = 'Per Diem';

            trigger OnValidate()
            begin

                "Total Cost" := "Tuition Fee" + "Per Diem" + "Air Ticket";
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(6; "Air Ticket"; Decimal)
        {
            Caption = 'Air Ticket';

            trigger OnValidate()
            begin

                "Total Cost" := "Tuition Fee" + "Per Diem" + "Air Ticket";
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(7; "Total Cost"; Decimal)
        {
            Editable = false;
            Caption = 'Total Cost';

            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    Error('Once document has been released it cannot be edited!');
            end;
        }
        field(8; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
            Caption = 'Status';
        }
    }

    keys
    {
        key(Key1; "Request No.", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Destination: Record Destination;
        DestinationRate: Record "Destination Rate Entry";
        Employee: Record Employee;
        TravelEmp: Record "Employees Travelling";
        Training: Record "Training Request";

    local procedure GetDestinationRate(): Decimal
    begin

        Destination.Reset();
        Destination.SetRange("Destination Code", Training.Venue);
        if Destination.FindFirst() then begin
            DestinationRate.Reset();
            DestinationRate.SetRange("Destination Code", Destination."Destination Code");
            DestinationRate.SetRange("Employee Job Group", GetJobGroup());
            //DestinationRate.SETFILTER()
            if DestinationRate.FindFirst() then
                "Per Diem" := DestinationRate."Daily Rate (Amount)";
        end;
    end;

    local procedure GetJobGroup(): Code[20]
    var
        Employee: Record Employee;
    begin
        if TravelEmp.Get("Request No.") then begin
            TravelEmp.TestField("Employee No");

            Employee.Reset();
            Employee.SetRange("No.", TravelEmp."Employee No");
            if Employee.FindFirst() then
                exit(Employee."Salary Scale");
        end;
    end;
}





