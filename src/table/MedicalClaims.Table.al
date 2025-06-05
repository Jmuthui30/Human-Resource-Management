table 52059 "Medical Claims"
{
    DataClassification = CustomerContent;
    Caption = 'Medical Claims';
    fields
    {
        field(1; "Claim No"; Code[20])
        {
            Caption = 'Claim No';
        }
        field(2; "Claim Date"; Date)
        {
            Caption = 'Claim Date';
        }
        field(3; "Service Provider"; Code[20])
        {
            Caption = 'Service Provider';

            trigger OnValidate()
            begin
                if VendorRec.Get("Service Provider") then
                    "Service Provider Name" := VendorRec.Name;
            end;
        }
        field(4; "Service Provider Name"; Text[100])
        {
            Caption = 'Service Provider Name';
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(6; Claimant; Option)
        {
            OptionMembers = " ","Service Provider",Employee;
            Caption = 'Claimant';
        }
        field(7; Amount; Decimal)
        {
            CalcFormula = sum("Claim Line".Amount where("Claim No" = field("Claim No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Amount';
        }
        field(8; Settled; Boolean)
        {
            Caption = 'Settled';
        }
        field(9; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
            Caption = 'Status';
        }
        field(11; "Transferred to Journal"; Boolean)
        {
            Caption = 'Transferred to Journal';
        }
        field(12; "No. of Approvals"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Document No." = field("Claim No")));
            FieldClass = FlowField;
            Caption = 'No. of Approvals';
        }
        field(13; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(14; Balance; Decimal)
        {
            Caption = 'Balance';
        }
        field(15; OutEntitlement; Decimal)
        {
            CalcFormula = sum("Medical Scheme Header"."Entitlement -OutPatient" where("Employee No" = field("Employee No")));
            FieldClass = FlowField;
            Caption = 'OutEntitlement';

            trigger OnValidate()
            begin
                CalcFields(OutEntitlement, "Total Claims");
                Balance := OutEntitlement - "Total Claims";
            end;
        }
        field(16; InEntitlement; Decimal)
        {
            CalcFormula = sum("Medical Scheme Header"."Entitlement -Inpatient" where("Employee No" = field("Employee No")));
            FieldClass = FlowField;
            Caption = 'InEntitlement';
        }
        field(17; "Total Claims"; Decimal)
        {
            CalcFormula = sum("Claim Line".Amount where("Employee No" = field("Employee No")));
            FieldClass = FlowField;
            Caption = 'Total Claims';
        }
        field(18; "Employee No"; Code[10])
        {
            Caption = 'Employee No';
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
        VendorRec: Record Vendor;
}





