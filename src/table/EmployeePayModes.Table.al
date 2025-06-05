table 52131 "Employee Pay Modes"
{
    DrillDownPageID = "Employee Pay Modes";
    LookupPageID = "Employee Pay Modes";
    DataClassification = CustomerContent;
    Caption = 'Employee Pay Modes';
    fields
    {
        field(1; "Pay Mode"; Code[20])
        {
            Caption = 'Pay Mode';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'G/L Account';
        }
        field(4; "Total Earnings"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Pay Mode" = field("Pay Mode")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Earnings';
        }
        field(5; "Total Deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Pay Mode" = field("Pay Mode")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Deductions';
        }
        field(6; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Pay Period Filter';
        }
        field(7; "Pay Mode Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Pay Mode Filter';
        }
        field(8; "Net Pay A/C"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Net Pay A/C';
        }
    }

    keys
    {
        key(Key1; "Pay Mode")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





