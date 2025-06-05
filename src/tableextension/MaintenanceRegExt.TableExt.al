tableextension 52003 "MaintenanceRegExt" extends "Maintenance Registration"
{
    fields
    {
        field(52000; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset";
            Caption = 'Item No.';

            trigger OnValidate()
            begin
                if FixedAsset.Get("Item No.") then begin
                    "Item Description" := FixedAsset.Description;
                    "Item Class Code" := FixedAsset."FA Class Code";
                end;

                if "Maintenance No" = '' then begin
                    HRSetup.Get();
                    HRSetup.TestField("Vehicle Maintenance Nos");
                    NoSeriesMgt.InitSeries(HRSetup."Vehicle Maintenance Nos", xRec."No. Series", 0D, "Maintenance No", "No. Series");
                end;
            end;
        }
        field(52001; "Item Description"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description';
        }
        field(52002; "Service Provider"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Caption = 'Service Provider';

            trigger OnValidate()
            begin
                if VendorRec.Get("Service Provider") then
                    "Service Provider Name" := VendorRec.Name;
            end;
        }
        field(52003; "Service Provider Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Provider Name';
        }
        field(52004; "Service Intervals"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Intervals';

            trigger OnValidate()
            begin
                /*
                ServiceIntervals.Reset();
                ServiceIntervals.SetRange(ServiceIntervals."Service Interval Code","Service Intervals");
                if ServiceIntervals.Find('-') then begin
                  "Service Period":=ServiceIntervals."Service Period";
                  "Service Mileage":=ServiceIntervals."Service Mileage";
                end;
                */

            end;
        }
        field(52005; "Date of Service"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Service';
        }
        field(52006; "Next Service"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Next Service';
        }
        field(52007; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(52008; "Service/Repair Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Service/Repair Description';
        }
        field(52009; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No.';
        }
        field(52010; "Service LSO/LPO No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header";
            Caption = 'Service LSO/LPO No.';
        }
        field(52011; "Item Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            DataClassification = CustomerContent;
            TableRelation = "FA Class";
        }
        field(52012; "Current Odometer Reading"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Odometer Reading';
        }
        field(52013; "Service Interval Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Mileage,Periodical';
            OptionMembers = " ",Mileage,Periodical;
            Caption = 'Service Interval Type';
        }
        field(52014; "Service Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Period';
        }
        field(52015; "Service Mileage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Mileage';
        }
        field(52016; "Employee No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No';
        }
        field(52017; "Driver Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Name';
        }
        field(52018; "Driver's Signature"; BLOB)
        {
            DataClassification = CustomerContent;
            SubType = Bitmap;
            Caption = 'Driver''s Signature';
        }
        field(52019; "Transport Manager Remarks"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Transport Manager Remarks';
        }
        field(52020; "Maintenance No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Maintenance No';
        }
        field(52021; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(52022; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
            Caption = 'Status';
        }
        field(52023; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(52024; Employee; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            Caption = 'Employee';

            trigger OnValidate()
            begin

                EmployeeRec.Reset();
                EmployeeRec.SetRange("No.", Employee);
                if EmployeeRec.Find('-') then begin
                    "Driver Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                    Signature := EmployeeRec.Signature;
                end;
            end;
        }
        field(52025; "Next Service Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Service Date';
        }
        field(52026; Signature; MediaSet)
        {
            DataClassification = CustomerContent;
            Caption = 'Signature';
        }
    }

    var
        EmployeeRec: Record Employee;
        FixedAsset: Record "Fixed Asset";
        HRSetup: Record "Human Resources Setup";
        VendorRec: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





