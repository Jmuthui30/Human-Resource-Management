xmlport 52004 "Import Deduction Balances"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    Caption = 'Import Deduction Balances';
    schema
    {
        textelement(Root)
        {
            tableelement("Deduction Balances"; "Deduction Balances")
            {
                XmlName = 'Earn_Ded';

                fieldelement(Employee_No; "Deduction Balances"."Employee No")
                {
                }
                fieldelement(Deduction_Code; "Deduction Balances"."Deduction Code")
                {
                    FieldValidate = no;
                }
                fieldelement(Date; "Deduction Balances".Date)
                {
                }
                fieldelement(Amount; "Deduction Balances".Amount)
                {
                }
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
}





