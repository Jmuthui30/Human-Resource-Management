xmlport 52001 "Employee Change"
{
    DefaultFieldsValidation = true;
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    Caption = 'Employee Change';
    schema
    {
        textelement(Root)
        {
            tableelement("Employee Change Request"; "Employee Change Request")
            {
                AutoReplace = false;
                AutoUpdate = false;
                MinOccurs = Zero;
                XmlName = 'EmployeeChange';

                fieldelement(No; "Employee Change Request"."No.")
                {
                }
                fieldelement(Name; "Employee Change Request"."First Name")
                {
                }
                fieldelement(DOE; "Employee Change Request"."Date Of Join")
                {
                }
                fieldelement(Tenure; "Employee Change Request"."Contract Length")
                {
                }
                fieldelement(EmpType; "Employee Change Request"."Employment Type")
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    /*
                    EmpRec.Reset();
                    EmpRec.SetRange("No.",Employee."No.");
                    if EmpRec.Find('-') then
                      begin
                        repeat
                          if EmpRec.Get(Employee."No.") then
                            begin
                              EmpRec.Modify();
                            end else
                            EmpRec.Insert();
                        until EmpRec.Next()=0;
                      end;
                    currXMLport.Skip();
                    */
                    /*
                    EmpRec.Reset();
                    EmpRec.SetRange("No.",Employee."No.");
                    if EmpRec.Find('-') then
                      begin
                        repeat
                          if Employee.Get(EmpRec."No.") then
                            begin
                              Employee.TransferFields(EmpRec);
                              Employee.Modify();
                            end else
                              Employee.Copy(EmpRec);
                              Employee.Insert();
                        until Employee.Next()=0;
                      end;
                    currXMLport.Skip();
                    */

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

    trigger OnPostXmlPort()
    begin
        /*
        begin
          EmpRec.SetRange("No.",Employee."No.");
            if EmpRec.Find('-') then
            repeat
              if Employee.Get(EmpRec."No.") then
                begin
                  Employee.TransferFields(EmpRec);
                  Employee.Modify();
                end else
                  begin
                    Employee.Copy(EmpRec);
                    EmpRec.Modify();
                  end;
            until EmpRec.Next()=0;
        end;
        */

    end;
}





