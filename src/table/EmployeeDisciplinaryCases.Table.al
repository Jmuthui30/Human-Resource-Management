table 52013 "Employee Disciplinary Cases"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Disciplinary Cases';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
        }
        field(2; "Refference No"; Code[20])
        {
            Caption = 'Refference No';
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; "Disciplinary Case"; Code[20])
        {
            Caption = 'Type of Hearing';
            TableRelation = "Disciplinary Cases".Code;

            trigger OnValidate()
            begin

                Cases.Reset();
                Cases.SetRange(Code, "Disciplinary Case");
                if Cases.Find('-') then begin
                    "Case Description" := Cases.Description;
                    "Recommended Action" := Cases."Action Description";
                end;
            end;
        }
        field(5; "Recommended Action"; Code[20])
        {
            TableRelation = "Recommended Actions";
            Caption = 'Recommended Action';
        }
        field(6; "Case Description"; Text[250])
        {
            Caption = 'Case Description';
        }
        field(7; "Accused Defence"; Text[250])
        {
            Caption = 'Accused Defence';
        }
        field(8; "Witness #1"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Witness #1';

            trigger OnValidate()
            begin

                Employee.Reset();
                Employee.SetRange("No.", "Witness #1");
                if Employee.Find('-') then
                    "Witness Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(9; "Witness #2"; Code[20])
        {
            Caption = 'Witness #2';
        }
        field(10; "Action Taken"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
            Caption = 'Action Taken';

            trigger OnValidate()
            begin

                Actions.Reset();
                Actions.SetRange(Code, "Action Taken");
                if Actions.Find('-') then
                    "Action Description" := Actions.Description;
            end;
        }
        field(11; "Date Taken"; Date)
        {
            Caption = 'Date Taken';
        }
        field(12; Attachment; Boolean)
        {
            Caption = 'Attachment';
        }
        field(13; "Disciplinary Remarks"; Code[50])
        {
            Caption = 'Disciplinary Remarks';
        }
        field(14; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(15; "Cases Discusion"; Boolean)
        {
            Caption = 'Cases Discusion';
        }
        field(16; "Language Code (Default)"; Code[10])
        {
            Caption = 'Language Code (Default)';
        }
        field(17; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(18; "RecAction Description"; Text[100])
        {
            Caption = 'RecAction Description';
        }
        field(19; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(20; "Other Incident"; Code[20])
        {
            Caption = 'Other Incident';
        }
        field(21; "Incident Date"; Date)
        {
            Caption = 'Incident Date';
        }
        field(22; "Incident Comments"; Text[250])
        {
            Caption = 'Incident Comments';
        }
        field(23; "Incident ID"; Code[20])
        {
            Caption = 'Incident ID';
        }
        field(24; "Action Description"; Text[30])
        {
            Caption = 'Action Description';
        }
        field(25; "Witness Type"; Option)
        {
            OptionCaption = ' ,Staff,Others';
            OptionMembers = " ",Staff,Others;
            Caption = 'Witness Type';
        }
        field(26; "Witness Name"; Text[60])
        {
            Caption = 'Witness Name';
        }
        field(27; "Hearing"; Text[100])
        {
            Caption = 'Hearing';
        }
        field(28; "Capability"; Text[60])
        {
            Caption = 'Capability';
        }
    }

    keys
    {
        key(Key1; "Refference No", "Employee No", "Disciplinary Case")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "Actions": Record "Disciplinary Actions";
        Cases: Record "Disciplinary Cases";
        Employee: Record Employee;
}





