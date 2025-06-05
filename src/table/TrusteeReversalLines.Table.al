table 52155 "Trustee Reversal Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Trustee Reversal Lines';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; "Trustee No"; Code[20])
        {
            TableRelation = Employee."No." where("Employee Type" = filter("Board Member"));
            Caption = 'Trustee No';

            trigger OnValidate()
            begin
                if Employee.Get("Trustee No") then
                    "Trustee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(4; "Trustee Name"; Text[100])
        {
            Editable = false;
            FieldClass = Normal;
            Caption = 'Trustee Name';
        }
        field(5; "Pay Period"; Date)
        {
            TableRelation = "Payroll Period Trustees";
            Caption = 'Pay Period';
        }
        field(6; "Total Allowances"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("Trustee No"),
                                                                  "Payroll Period" = field("Pay Period"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  "Normal Earnings" = const(true),
                                                                  "Insurance Code" = filter(false)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Allowances';
        }
        field(7; "Taxable Allowance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Taxable = const(true),
                                                                  "Employee No" = field("Trustee No"),
                                                                  "Payroll Period" = field("Pay Period")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Taxable Allowance';
        }
        field(8; "Total Deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = filter(Deduction | Loan),
                                                                  "Employee No" = field("Trustee No"),
                                                                  "Payroll Period" = field("Pay Period")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Deductions';
        }
        field(9; "Net Pay"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("Trustee No"),
                                                                  "Payroll Period" = field("Pay Period"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  "Tax Relief" = const(false)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Net Pay';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}





