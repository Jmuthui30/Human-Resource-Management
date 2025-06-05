table 52010 "Employee Discplinary"
{
    DrillDownPageId = "Employee Disciplinary List";
    LookupPageId = "Employee Disciplinary List";
    DataClassification = CustomerContent;
    Caption = 'Employee Discplinary';
    fields
    {
        field(1; "Disciplinary Nos"; Code[30])
        {
            Caption = 'Disciplinary Nos';

            trigger OnValidate()
            begin

                if "Disciplinary Nos" <> xRec."Disciplinary Nos" then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Disciplinary Cases Nos.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "Employee No"; Code[30])
        {
            TableRelation = Employee."No.";
            Caption = 'Employee No';

            trigger OnValidate()
            begin

                Employee.Reset();
                Employee.SetRange("No.", "Employee No");
                if Employee.Find('-') then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Gender := Employee.Gender;
                    "Job Title" := Employee."Job Position Title";
                    "Date of Join" := Employee."Date Of Join";
                    "Recipient Email" := Employee."E-Mail";
                end;
            end;
        }
        field(3; "Employee Name"; Text[60])
        {
            Caption = 'Employee Name';
        }
        field(4; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(5; "Job Title"; Code[60])
        {
            Caption = 'Job Title';
        }
        field(6; "Date of Join"; Date)
        {
            Caption = 'Date of Join';
        }
        field(7; "No.Series"; Code[50])
        {
            Caption = 'No.Series';
        }
        field(8; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(9; "E-Mail Body Text"; BLOB)
        {
            Caption = 'E-Mail Body Text';
        }
        field(10; "E-Mail Subject"; Text[250])
        {
            Caption = 'E-Mail Subject';
        }
        field(11; Attachment; Text[250])
        {
            Caption = 'Attachment';
        }
        field(12; "Recipient Email"; Text[100])
        {
            Caption = 'Recipient Email';
        }
        field(13; "Recipient CC"; Text[100])
        {
            Caption = 'Recipient CC';
        }
        field(14; "Recipient BCC"; Text[100])
        {
            Caption = 'Recipient BCC';
        }
        field(15; "Date Closed"; Date)
        {
            Caption = 'Date Closed';
        }
        field(16; "Reason for Appeal"; Text[250])
        {
            Caption = 'Reason for Appeal';
        }
        field(17; "Appeal Status"; Option)
        {
            OptionMembers = Open,Released,"Pending Approval",Rejected;
            Caption = 'Appeal Status';
        }
    }

    keys
    {
        key(Key1; "Disciplinary Nos")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Disciplinary Nos" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Disciplinary Cases Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.", xRec."No.Series", 0D, "Disciplinary Nos", "No.Series");
        end;
    end;

    var
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





