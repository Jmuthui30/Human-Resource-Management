table 52156 "Allowance Register"
{
    DataClassification = CustomerContent;
    Caption = 'Allowance Register';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Imprest Deduction Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Payroll Period"; Date)
        {
            TableRelation = "Payroll Period";
            Caption = 'Payroll Period';

            trigger OnValidate()
            begin
                //GenerateOverdueImprest;
            end;
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(5; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(6; "Created By"; Code[30])
        {
            TableRelation = User;
            Caption = 'Created By';
        }
        field(7; "Posted By"; Code[30])
        {
            Caption = 'Posted By';
        }
        field(8; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(9; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Posted,Rejected;
            Caption = 'Status';
        }
        field(10; "Date of Activity"; Date)
        {
            Caption = 'Date of Activity';
        }
        field(11; "Earning Code"; Code[20])
        {
            TableRelation = Earnings.Code;
            Caption = 'Earning Code';

            trigger OnValidate()
            begin
                Earnings.Get("Earning Code");
                Description := Earnings.Description;
            end;
        }
        field(12; "Employee Type"; Option)
        {
            Caption = 'Employee Type';
            OptionCaption = ' ,Staff,Board Member';
            OptionMembers = "","Staff","Board Member";
        }
        field(13; "Total Amount"; Decimal)
        {
            Caption = 'Total Gross Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Allowance Register Line".Amount where("Document No." = field("No.")));
            Editable = false;
        }
        field(14; "Total Net Amount"; Decimal)
        {
            Caption = 'Total Net Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Allowance Register Line"."Net Amount" where("Document No." = field("No.")));
            Editable = false;
        }
        field(15; "Total PAYE"; Decimal)
        {
            Caption = 'Total PAYE';
            FieldClass = FlowField;
            CalcFormula = sum("Allowance Register Line"."PAYE Amount" where("Document No." = field("No.")));
            Editable = false;
        }
        field(16; "Applies To All"; Boolean)
        {
            Caption = 'Applies To All';
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
    var
        AllowanceRegister: Record "Allowance Register";
        UtilizeOpenDocumentsErr: Label 'Kindly utilize all your open documents before creating a new document';
    begin
        AllowanceRegister.Reset();
        AllowanceRegister.SetRange("Created By", UserId);
        AllowanceRegister.SetFilter(Status, '%1', AllowanceRegister.Status::Open);
        if AllowanceRegister.Count >= 1 then
            Error(UtilizeOpenDocumentsErr);

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Imprest Deduction Nos");
            NoSeriesMgt.InitSeries(HRSetup."Imprest Deduction Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        PayrollPeriodX.SetRange("Close Pay", false);
        if PayrollPeriodX.FindFirst() then
            Validate("Payroll Period", PayrollPeriodX."Starting Date");

        "Date Created" := Today;
        "Created By" := UserId;
    end;

    trigger OnDelete()
    begin
        AllowanceRegisterLines.SetRange("Document No.", "No.");
        if AllowanceRegisterLines.FindSet() then
            AllowanceRegisterLines.DeleteAll();
    end;

    var
        AllowanceRegisterLines: Record "Allowance Register Line";
        Earnings: Record Earnings;
        HRSetup: Record "Human Resources Setup";
        PayrollPeriodX: Record "Payroll Period";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





