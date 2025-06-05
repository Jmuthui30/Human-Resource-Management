table 52162 "Training Evaluation Header"
{
    DataClassification = CustomerContent;
    Caption = 'Training Evaluation Header';
    fields
    {
        field(1; "Training Evaluation No."; Code[20])
        {
            Caption = 'Training Evaluation No.';

            trigger OnValidate()
            begin
                if "Training Evaluation No." <> xRec."Training Evaluation No." then begin
                    HRSetup.Get();
                    HRSetup.TestField("Training Evaluation Nos");
                    NoSeriesManagement.TestManual(HRSetup."Training Evaluation Nos");
                end;
            end;
        }
        field(2; "Training Name"; Code[20])
        {
            TableRelation = "Training Need";
            Caption = 'Training Name';

            trigger OnValidate()
            var
                TrainingNeed: Record "Training Need";
            begin

                if TrainingNeed.Get("Training Name") then begin
                    Description := TrainingNeed.Description;
                    Location := TrainingNeed.Location;
                    "Commencement Date" := TrainingNeed."Start Date";
                    "Completion Date" := TrainingNeed."End Date";
                end;
            end;
        }
        field(3; "Location"; Text[250])
        {
            Caption = 'Location';
        }
        field(4; "Commencement Date"; Date)
        {
            Caption = 'Commencement Date';
        }
        field(5; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
        }
        field(6; Duration; Text[100])
        {
            Caption = 'Duration';
        }
        field(7; "Scheduled Start Date"; Date)
        {
            Caption = 'Scheduled Start Date';
        }
        field(8; UserID; Code[20])
        {
            Caption = 'UserID';
        }
        field(9; "Personal No."; Code[20])
        {
            Caption = 'Personal No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Get("Personal No.");
                "Name of participant" := Employee.FullName();
            end;
        }
        field(11; Country; Text[50])
        {
            Caption = 'Country';
        }
        field(12; Description; Text[500])
        {
            Caption = 'Description';
        }
        field(13; "Name of participant"; Text[100])
        {
            Caption = 'Name of participant';
        }
        field(14; Submitted; Boolean)
        {
            Caption = 'Submitted';
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(Key1; "Training Evaluation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        UserId := UserId;
        if "Training Evaluation No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Training Evaluation Nos");
            NoSeriesManagement.InitSeries(HRSetup."Training Evaluation Nos", xRec."No. Series", 0D, "Training Evaluation No.", "No. Series");
        end;

        if "User Setup".Get(UserId) then begin
            "User Setup".TestField("Employee No.");
            if Employee.Get("User Setup"."Employee No.") then begin
                "Personal No." := Employee."No.";
                "Name of participant" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;

    end;

    var
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        "User Setup": Record "User Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    local procedure GetEmpDetails(EmpNo: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpNo) then
            "Name of participant" := (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
}





