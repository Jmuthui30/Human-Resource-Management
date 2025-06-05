table 52160 "Payroll Approval"
{
    Caption = 'Payroll Approval';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
        }
        field(2; "Employee Type"; Option)
        {
            Caption = 'Employee Type';
            OptionCaption = 'Staff,Board Member';
            OptionMembers = Staff,"Board Member";
        }
        field(3; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            TableRelation = if ("Employee Type" = filter("Board Member")) "Payroll Period Trustees"
            else
            "Payroll Period";

            trigger OnValidate()
            begin
                case "Employee Type" of
                    "Employee Type"::Staff:
                        begin
                            PayPeriod.Get("Payroll Period");
                            "Period Description" := PayPeriod.Name;
                        end;
                    "Employee Type"::"Board Member":
                        begin
                            PayPeriodBoard.Get("Payroll Period");
                            "Period Description" := PayPeriodBoard.Name;
                        end;
                end;
            end;
        }
        field(4; "Prepared By"; Code[50])
        {
            Caption = 'Prepared By';
        }
        field(5; "Date-Time Prepared"; DateTime)
        {
            Caption = 'Date-Time Prepared';
        }
        field(6; Status; Enum "Approval Status")
        {
            Caption = 'Status';
        }
        field(7; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
        }
        field(8; "Period Description"; Text[100])
        {
            Caption = 'Period Description';
        }
        field(9; "Total Earnings"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Payroll Period" = field("Payroll Period"),
                                                                Type = const(Earning),
                                                                  "Employee Type" = filter(<> Trustee)));
            FieldClass = FlowField;
            Caption = 'Total Earnings';
            Editable = false;
        }
        field(10; "Total Deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Payroll Period" = field("Payroll Period"),
                                                                Type = const(Deduction),
                                                                  "Employee Type" = filter(<> Trustee)));
            FieldClass = FlowField;
            Caption = 'Total Deductions';
            Editable = false;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Payroll Approval Nos");
            NoSeriesMgt.InitSeries(HRSetup."Payroll Approval Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
        "Prepared By" := UserId;
        "Date-Time Prepared" := CurrentDateTime;
    end;

    trigger OnDelete()
    var
        CanOnlyDeleteOpenErr: Label 'You can only delete Open documents';
    begin
        if not (Status in [Status::Open, Status::" ", Status::Created]) then
            Error(CanOnlyDeleteOpenErr);
    end;

    var
        HRSetup: Record "Human Resources Setup";
        PayPeriod: Record "Payroll Period";
        PayPeriodBoard: Record "Payroll Period Trustees";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





