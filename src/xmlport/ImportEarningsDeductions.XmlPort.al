xmlport 52003 "Import Earnings & Deductions"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    Caption = 'Import Earnings & Deductions';
    schema
    {
        textelement(Root)
        {
            tableelement("Import Earn & Ded Lines"; "Import Earn & Ded Lines")
            {
                XmlName = 'Earn_Ded';
                fieldelement(Employee_No; "Import Earn & Ded Lines"."Employee No")
                {
                }
                fieldelement(Amount; "Import Earn & Ded Lines".Amount)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    "Import Earn & Ded Lines".No := No;
                    /*
                    IF NOT Employee.GET("Import Earn & Ded Lines"."Employee No") THEN
                      currXMLport.SKIP
                      ELSE
                        BEGIN
                    */
                    if Employee.Get("Import Earn & Ded Lines"."Employee No") then
                        "Import Earn & Ded Lines"."Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    NegateDed("Earn&DedHead");

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
        Employee: Record Employee;
        "Earn&DedHead": Record "Import Earn & Ded Header";
        No: Code[20];


    procedure GetNoSeries(Header: Record "Import Earn & Ded Header")
    begin
        No := Header.No;
    end;


    procedure NegateDed(Head: Record "Import Earn & Ded Header")
    begin
        if Head.Type = Head.Type::Deduction then
            "Import Earn & Ded Lines".Amount := -("Import Earn & Ded Lines".Amount);
    end;
}













