table 52103 "Training Needs Request"
{
    DataClassification = CustomerContent;
    Caption = 'Training Needs Request';
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get();
                    HRSetup.TestField("Training Needs Request Nos.");
                    NoSeriesManagement.TestManual(HRSetup."Training Needs Request Nos.");
                end;
            end;
        }
        field(2; "Need Source"; Option)
        {
            OptionCaption = 'Calendar,Appraisal,CPD, Adhoc,Disciplinary';
            OptionMembers = Calendar,Appraisal,CPD,Adhoc,Disciplinary;
            Caption = 'Need Source';
        }
        field(3; Provider; Code[20])
        {
            Caption = 'Provider';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                GenLedSetup.Get();
                GenLedSetup.TestField("Current Budget Start Date");
                GenLedSetup.TestField("Current Budget End Date");

                if "Start Date" <> 0D then begin
                    if "Start Date" < GenLedSetup."Current Budget Start Date" then
                        Error(Text001, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget Start Date"), Format(GenLedSetup."Current Budget Start Date"));
                    if "Start Date" > GenLedSetup."Current Budget End Date" then
                        Error(Text002, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget End Date"), Format(GenLedSetup."Current Budget End Date"));

                    if "End Date" <> 0D then begin
                        if "Start Date" > "End Date" then
                            Error(Text002, FieldCaption("Start Date"), Format("Start Date"), FieldCaption("End Date"), Format("End Date"));
                        if "End Date" < "Start Date" then
                            Error(Text001, FieldCaption("End Date"), Format("End Date"), FieldCaption("Start Date"), Format("Start Date"));
                        Duration := ("End Date" - "Start Date") + 1
                    end;
                end;
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                Validate("Start Date");
            end;
        }
        field(6; "Duration Units"; Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
            Caption = 'Duration Units';
        }
        field(7; Duration; Decimal)
        {
            Caption = 'Duration';
        }
        field(8; "Employee No"; Code[10])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation := Employee."Job Title";
                end;
            end;
        }
        field(9; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(10; Designation; Text[100])
        {
            Caption = 'Designation';
        }
        field(11; "Training Name"; Code[500])
        {
            Caption = 'Training Name';
        }
        field(12; "Training area"; Code[70])
        {
            TableRelation = "Training Area";
            Caption = 'Training area';
        }
        field(13; Venue; Code[100])
        {
            Caption = 'Venue';
        }
        field(14; "Source Document No"; Code[20])
        {
            Caption = 'Source Document No';
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(16; "Registration fee"; Decimal)
        {
            Caption = 'Registration fee';
        }
        field(17; "Need created"; Boolean)
        {
            Caption = 'Need created';
        }
        field(18; "Training Objectives"; Text[250])
        {
            Caption = 'Training Objectives';
        }
        field(19; Status; Option)
        {
            OptionMembers = New,Created,Rejected;
            OptionCaption = 'New, Created, Rejected';
            Caption = 'Status';
        }
        field(20; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; No, "Source Document No", "Need Source", "Employee No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Training Needs Request Nos.");
            NoSeriesManagement.InitSeries(HRSetup."Training Needs Request Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;

    var
        GenLedSetup: Record "General Ledger Setup";
        HRSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Text001: Label 'The %1 %2 cannot be earlier than the %3 %4.';
        Text002: Label 'The %1 %2 cannot be after the %3 %4.';
}





