table 52144 "Payroll Change Header"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Change Header';
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get();
                    PaySeries
                    .TestManual(HRSetup."Payroll Change Nos");
                    "No Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
        }
        field(4; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(5; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(6; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 3 Code';
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            Caption = 'Status';
        }
        field(8; "No Series"; Code[50])
        {
            Caption = 'No Series';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        HRSetup.Get();
        if No = '' then begin
            HRSetup.TestField("Payroll Change Nos");
            PaySeries.InitSeries(HRSetup."Payroll Change Nos", xRec."No Series", 0D, No, "No Series")
        end;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        PaySeries: Codeunit NoSeriesManagement;
}





