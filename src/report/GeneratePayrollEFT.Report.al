report 52114 "Generate Payroll EFT"
{
    ApplicationArea = All;
    Caption = 'Generate Payroll EFT';
    ProcessingOnly = true;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(PayPeriod; PayPeriod)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        TableRelation = "Payroll Period";
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        if PayPeriod = 0D then
            Error('Please select an appropriate Payroll Period');

        Payroll.GeneratePayrollEFT(PayPeriod);
    end;

    var
        Payroll: Codeunit Payroll;
        PayPeriod: Date;
}






