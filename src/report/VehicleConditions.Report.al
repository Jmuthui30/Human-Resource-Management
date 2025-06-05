report 52016 "Vehicle Conditions"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/VehicleConditions.rdlc';
    Caption = 'Vehicle Conditions';
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = where("FA Subclass Code" = filter('MOTOR'));

            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phine_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(County; CompanyInfo.County)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(No; "Fixed Asset"."No.")
            {
            }
            column(Description; "Fixed Asset".Description)
            {
            }
            column(FA_Subclass_Code; "Fixed Asset"."FA Subclass Code")
            {
            }
            column(Registration_No; "Fixed Asset"."Registration No")
            {
            }
            column(Maintainence_Status; "Fixed Asset"."Maintainence Status")
            {
            }
            column(Maintenance_Vendor; "Fixed Asset"."Maintenance Vendor No.")
            {
            }
            column(Make_FixedAsset; "Fixed Asset".Make)
            {
            }
            column(Status; "Fixed Asset"."Maintainence Status")
            {
            }
            column(Vendor_Name; MaintenanceVendor)
            {
            }
            column(MyFilters; MyFilters)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FA.Reset();
                FA.SetRange("FA Subclass Code", "Fixed Asset"."FA Subclass Code");
                FA.SetRange("Maintainence Status", "Fixed Asset"."Maintainence Status");
                if FA.Find('-') then begin
                    case FA."Maintainence Status" of
                        FA."Maintainence Status"::Available:

                            MaintainStatus := FA."Maintainence Status"::Available;
                        FA."Maintainence Status"::"Under Maintenence":

                            MaintainStatus := FA."Maintainence Status"::"Under Maintenence";
                        FA."Maintainence Status"::"Written Off":

                            MaintainStatus := FA."Maintainence Status"::"Written Off";
                    end;

                    Vendor.Reset();
                    Vendor.SetRange("No.", "Fixed Asset"."Maintenance Vendor No.");
                    if Vendor.Find('-') then
                        MaintenanceVendor := Vendor.Name;
                end;
            end;

            trigger OnPreDataItem()
            begin
                MyFilters := "Fixed Asset".GetFilters;
            end;
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
    labels
    {
    }

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        FA: Record "Fixed Asset";
        Vendor: Record Vendor;
        MaintainStatus: Option;
        MaintenanceVendor: Text;
        MyFilters: Text;
}





