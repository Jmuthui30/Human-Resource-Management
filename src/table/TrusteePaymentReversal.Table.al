table 52154 "Trustee Payment Reversal"
{
    DataClassification = CustomerContent;
    Caption = 'Trustee Payment Reversal';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get();
                    HRSetup.TestField("Trustee Reversal Nos");
                    NoSeries.TestManual(HRSetup."Trustee Reversal Nos");
                end;
            end;
        }
        field(2; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
        }
        field(3; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
            Caption = 'Status';
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(7; Type; Option)
        {
            OptionCaption = ' ,By Entry No.,By Document No.';
            OptionMembers = " ","By Entry No","By Document No";
            Caption = 'Type';
        }
        field(8; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
            Caption = 'Bank Account';
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(10; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
        }
        field(11; "Posted Date-Time"; DateTime)
        {
            Caption = 'Posted Date-Time';
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
    begin
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Trustee Reversal Nos");
            NoSeries.InitSeries(HRSetup."Trustee Reversal Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Created Date" := CurrentDateTime;
        "User ID" := UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeries: Codeunit NoSeriesManagement;
}





