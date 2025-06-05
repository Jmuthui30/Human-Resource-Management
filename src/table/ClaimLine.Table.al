table 52058 "Claim Line"
{
    DataClassification = CustomerContent;
    Caption = 'Claim Line';
    fields
    {
        field(1; "Claim No"; Code[20])
        {
            Caption = 'Claim No';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; "Patient No"; Code[20])
        {
            Caption = 'Patient No';

            trigger OnValidate()
            begin
                /* Cheruiyot
                Beneficiary.Reset();
                Beneficiary.SetRange(Beneficiary."Employee Code","Patient No");
                if Beneficiary.Find('-')then
                "Patient Name":=Beneficiary.SurName+' '+Beneficiary."Other Names";
                */





                /*
                  TestField("Visit Date");
                   MedSchemeLines.Reset();
                  MedSchemeLines.SetRange(MedSchemeLines."Employee Code","Employee No");
                  MedSchemeLines.SetRange(MedSchemeLines."Line No.","Patient No");
                  if MedSchemeLines.Find('+') then
                  "Patient Name":=MedSchemeLines."Other Names"+' '+MedSchemeLines.SurName;
                  Relationship:=MedSchemeLines.Relationship;
                */

            end;
        }
        field(4; "Patient Name"; Text[80])
        {
            Caption = 'Patient Name';
        }
        field(5; "Hospital/Specialist"; Text[250])
        {
            Caption = 'Hospital/Specialist';
        }
        field(6; "Invoice Number"; Code[20])
        {
            Caption = 'Invoice Number';

            trigger OnValidate()
            begin
                /*
                 claims.Reset();
                 claims.SetRange(claims."Claim No","Claim No");
                 claims.SetRange(claims."Employee No","Employee No");
                 if claims.Find('-') then begin
                  if claims."Invoice Number"="Invoice Number" then
                   Error('That Invoice number has already been captured!');
                 end;
                 */

            end;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                /*
                "Approved Amount":=Amount;
                MedicalSheme.Reset();
                MedicalSheme.SetRange(MedicalSheme."Employee No","Employee No");
                if MedicalSheme.Find('+') then
                begin
                 MedicalSheme.CalcFields(MedicalSheme."In-Patient Claims",MedicalSheme."Out-Patient Claims");
                 if Amount+MedicalSheme."In-Patient Claims">MedicalSheme."Entitlement -Inpatient"  then
                 Message('By Accepting this claim you will be exceed the in-patient limit');

                 if Amount+MedicalSheme."Out-Patient Claims">MedicalSheme."Entitlement -OutPatient"  then
                 Message('By Accepting this claim you will be exceed the out-patient limit');


                end;
                */

            end;
        }
        field(8; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
        }
        field(9; "Employee No"; Code[20])
        {
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if emp.Get("Employee No") then
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(10; "Medical Scheme"; Code[20])
        {
            Caption = 'Medical Scheme';
        }
        field(11; Status; Option)
        {
            OptionMembers = " ",Approved,Rejected,"Part Payment";
            Caption = 'Status';
        }
        field(12; "Amount Spend (In-Patient)"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Amount Spend (In-Patient)';
        }
        field(13; "Amout Spend (Out-Patient)"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Amout Spend (Out-Patient)';
        }
        field(14; "Claim Type"; Option)
        {
            OptionCaption = ' ,In Patient,Out Patient,Dental,Optical';
            OptionMembers = " ","In Patient","Out Patient",Dental,Optical;
            Caption = 'Claim Type';
        }
        field(15; "Balance (In-Patient)"; Decimal)
        {
            Caption = 'Balance (In-Patient)';
        }
        field(16; "Balance (Out-Patient)"; Decimal)
        {
            Caption = 'Balance (Out-Patient)';
        }
        field(17; "Visit Date"; Date)
        {
            Caption = 'Visit Date';

            trigger OnValidate()
            begin
                AccountingP.Reset();
                AccountingP.SetRange(AccountingP."Starting Date", 0D, "Visit Date");
                AccountingP.SetRange(AccountingP."New Fiscal Year", true);
                if AccountingP.Find('+') then
                    "Policy Start Date" := AccountingP."Starting Date";
            end;
        }
        field(18; "Employee Name"; Text[80])
        {
            Caption = 'Employee Name';
        }
        field(19; Relationship; Code[20])
        {
            TableRelation = Relative;
            Caption = 'Relationship';
        }
        field(21; "Policy Start Date"; Date)
        {
            Caption = 'Policy Start Date';
        }
        field(22; "Commissioner Code"; Code[30])
        {
            Caption = 'Commissioner Code';

            trigger OnValidate()
            begin
                dimvalue.Reset();
                if dimvalue.Get('COMMISSIONERS', "Commissioner Code") then
                    "Commissioner Name" := dimvalue.Name;
            end;
        }
        field(23; "Commissioner Name"; Text[50])
        {
            Caption = 'Commissioner Name';
        }
        field(24; Settled; Boolean)
        {
            Caption = 'Settled';
        }
        field(25; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
        }
        field(26; Directorate; Code[10])
        {
            Caption = 'Directorate';
        }
        field(27; Department; Code[10])
        {
            Caption = 'Department';
        }
        field(28; LineNo; Integer)
        {
            Caption = 'LineNo';
        }
        field(29; Patient; Option)
        {
            OptionCaption = ',Self,Dependant';
            OptionMembers = ,Self,Dependant;
            Caption = 'Patient';

            trigger OnValidate()
            begin
                if Patient = Patient::Self then
                    "Patient Name" := "Employee Name";
            end;
        }
    }

    keys
    {
        key(Key1; "Claim No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AccountingP: Record "Accounting Period";
        dimvalue: Record "Dimension Value";
        emp: Record Employee;
}





