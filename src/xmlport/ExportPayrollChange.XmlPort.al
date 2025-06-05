xmlport 52002 "Export Payroll Change"
{
    Direction = Both;
    Format = VariableText;
    Caption = 'Export Payroll Change';
    schema
    {
        textelement(Root)
        {
            tableelement("Employee Pay Requests"; "Employee Pay Requests")
            {
                XmlName = 'EmployeePayReq';

                fieldelement(Date; "Employee Pay Requests".Date)
                {
                }
                fieldelement(EmployeeNo; "Employee Pay Requests"."Employee No.")
                {
                }
                fieldelement(PayType; "Employee Pay Requests"."Payment Type")
                {
                }
                fieldelement(Units; "Employee Pay Requests"."No. of Units")
                {
                }
                fieldelement(PayPeriod; "Employee Pay Requests"."Payroll Period")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Employee Pay Requests"."Document No" := HeaderNo;
                    "Employee Pay Requests"."ED Code" := GetCode("Employee Pay Requests"."Payment Type");
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    var
        HeaderNo: Code[50];

    procedure GetHeaderNo(PayChange: Record "Payroll Change Header")
    begin
        HeaderNo := PayChange.No;
    end;

    local procedure GetCode(PayType: Code[50]): Code[20]
    var
        PayCodes: Record "Employee Pay Types";
    begin
        if PayCodes.Get(PayType) then
            exit(PayCodes."Earning Code");
    end;
}





