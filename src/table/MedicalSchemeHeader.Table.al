table 52057 "Medical Scheme Header"
{
    DataClassification = CustomerContent;
    Caption = 'Medical Scheme Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Selection Date"; Date)
        {
            Caption = 'Selection Date';
        }
        field(3; "Cover Type"; Option)
        {
            OptionMembers = " ","In House",Outsourced;
            Caption = 'Cover Type';
        }
        field(4; "Service Provider"; Code[20])
        {
            TableRelation = if ("Cover Type" = const(Outsourced)) Vendor;
            Caption = 'Service Provider';
        }
        field(5; "Name of Broker"; Text[30])
        {
            Caption = 'Name of Broker';
        }
        field(6; "Policy No"; Code[20])
        {
            Caption = 'Policy No';
        }
        field(7; "Policy Start Date"; Date)
        {
            Caption = 'Policy Start Date';

            trigger OnValidate()
            begin
                "Policy Expiry Date" := CalcDate('1Y', "Policy Start Date") - 1;
            end;
        }
        field(8; "Policy Expiry Date"; Date)
        {
            Caption = 'Policy Expiry Date';
        }
        field(9; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin

                if EmpRec.Get("Employee No") then begin
                    "Employee Name" := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    "Blood Type" := EmpRec."Blood Type";
                    if SalaryScales.Get(EmpRec."Salary Scale") then
                        "Entitlement -Inpatient" := SalaryScales."In Patient Limit";
                    "Entitlement -OutPatient" := SalaryScales."Out Patient Limit";
                    Dependants.Init();
                    Dependants.SetRange("Employee No.", "Employee No");
                    if Dependants.Find('-') then
                        repeat
                            MedLines."Employee Code" := "Employee No";
                            MedLines."Medical Scheme No" := "No.";
                            MedLines."Line No." := MedLines."Line No." + 10000;
                            MedLines.Relationship := Dependants."Relative Code";
                            MedLines.SurName := Dependants."Last Name";
                            MedLines."Other Names" := Dependants."First Name";
                            MedLines."Date Of Birth" := Dependants."Birth Date";
                            MedLines.Gender := Dependants.Gender;
                            MedLines.Insert();
                        until Dependants.Next() = 0;
                end;


                /*
                MedLines.Init();
                MedLines."Medical Scheme No":="No.";
                MedLines."Line No.":=MedLines."Line No."+10000;
                MedLines."Employee Code":="Employee No";
                MedLines.Relationship:='EMPLOYEE';
                
                if EmpRec.Get("Employee No") then
                MedLines."Date Of Birth":=EmpRec."Date of Birth";
                MedLines.SurName:=EmpRec."Last Name";
                MedLines."Other Names":=EmpRec."First Name";
                MedLines."Service Provider":="Service Provider";
                //HANDLE THE ERROR INCURED FROM EXISITIN RECORDS BY ISAAC
                if MedLines.Insert() then  begin
                ;
                end else
                MedLines.Modify();
                 //END
                if not MedLines.Get(MedLines."Medical Scheme No",MedLines."Line No.") then
                begin
                
                Dependants.Reset();
                Dependants.SetRange(Dependants."Employee Code","Employee No");
                if Dependants.Find('-') then
                repeat
                  MedLines.Init();
                  MedLines."Medical Scheme No":="No.";
                  MedLines."Line No.":=MedLines."Line No."+10000;
                  MedLines."Employee Code":="Employee No";
                  //MedLines.Relationship:=Dependants.Relationship;
                  //MedLines.SurName:=Dependants.SurName;
                  //MedLines."Other Names":=Dependants."Other Names";
                
                  if EmpRec.Get("Employee No") then
                 // MedLines."Date Of Birth":=EmpRec."Date Of Birth";
                
                  MedLines."Date Of Birth":=Dependants."Date of Birth";
                  MedLines."Service Provider":="Service Provider";
                
                  if not MedLines.Get(MedLines."Medical Scheme No",MedLines."Line No.") then
                //HANDLE THE ERROR INCURED FROM EXISITIN RECORDS BY ISAAC
                
                if MedLines.Insert() then  begin
                ;
                end else
                MedLines.Modify();
                //END
                until Dependants.Next()=0;
                end;
                */

            end;
        }
        field(10; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(11; "Entitlement -Inpatient"; Decimal)
        {
            Caption = 'Entitlement -Inpatient';
        }
        field(12; "Entitlement -OutPatient"; Decimal)
        {
            Caption = 'Entitlement -OutPatient';
        }
        field(13; "Fiscal Year"; Code[10])
        {
            TableRelation = "G/L Budget Name";
            Caption = 'Fiscal Year';
        }
        field(14; "No. Of Lives"; Integer)
        {
            CalcFormula = count("Medical Scheme Lines" where("Medical Scheme No" = field("No.")));
            FieldClass = FlowField;
            Caption = 'No. Of Lives';
        }
        field(15; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(16; "Cover Selected"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Cover Selected';

            trigger OnValidate()
            begin
                Validate("Employee No");
            end;
        }
        field(17; "In-Patient Claims"; Decimal)
        {
            CalcFormula = sum("Claim Line"."Approved Amount" where("Employee No" = field("Employee No"),
                                                                    "Claim Type" = const("In Patient")));
            FieldClass = FlowField;
            Caption = 'In-Patient Claims';
        }
        field(18; "Out-Patient Claims"; Decimal)
        {
            CalcFormula = sum("Claim Line"."Approved Amount" where("Employee No" = field("Employee No"),
                                                                    "Claim Type" = const("Out Patient"),
                                                                    "Policy Start Date" = field("Policy Start Date")));
            FieldClass = FlowField;
            Caption = 'Out-Patient Claims';
        }
        field(19; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(20; "Blood Type"; Code[10])
        {
            Caption = 'Blood Type';
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No")
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
            HRSetup.TestField("Cover Selection Nos");
            NoSeriesMgt.InitSeries(HRSetup."Cover Selection Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        EmpRec: Record Employee;
        Dependants: Record "Employee Relative";
        HRSetup: Record "Human Resources Setup";
        MedLines: Record "Medical Scheme Lines";
        SalaryScales: Record "Salary Scale";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





