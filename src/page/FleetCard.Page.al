page 52073 "Fleet Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Fixed Asset";
    Caption = 'Fleet Card';
    layout
    {
        area(content)
        {
            group("Car Info")
            {
                Caption = 'Car Info';

                label("Car Tracking Information")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Registration No"; Rec."Registration No")
                {
                    ToolTip = 'Specifies the value of the Registration No field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ToolTip = 'Specifies the value of the Vehicle Type field';
                }
                field("Car Rating"; Rec."Car Rating")
                {
                    ToolTip = 'Specifies the value of the Car Rating field';
                }
                field("Year of Manufacture"; Rec.YOM)
                {
                    ToolTip = 'Specifies the value of the YOM field';
                }
                field(Duty; Rec.Duty)
                {
                    ToolTip = 'Specifies the value of the Duty field';
                }
                field("Car Tracking Company"; Rec."Car Tracking Company")
                {
                    ToolTip = 'Specifies the value of the Car Tracking Company field';
                }
                field("Tracking Date"; Rec."Tracking Date")
                {
                    ToolTip = 'Specifies the value of the Tracking Date field';
                }
                field("Tracking Renewal date"; Rec."Tracking Renewal Date")
                {
                    ToolTip = 'Specifies the value of the Tracking Renewal Date field';
                }
                field("LogBook No"; Rec."Logbook No")
                {
                    ToolTip = 'Specifies the value of the Logbook No field';
                }
                field(Make; Rec.Make)
                {
                    ToolTip = 'Specifies the value of the Make field';
                }
                field(Body; Rec.Body)
                {
                    ToolTip = 'Specifies the value of the Body field';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field';
                }
                field("Seating/carrying capacity"; Rec."Seating/carrying capacity")
                {
                    ToolTip = 'Specifies the value of the Seating/carrying capacity field';
                }
                field("Current Odometer Reading"; Rec."Current Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Current Odometer Reading field';
                }
            }
            group("Insurance Info")
            {
                field("Policy No"; Rec."Policy No")
                {
                    ToolTip = 'Specifies the value of the Policy No field';
                }
                field(Insurer; Rec.Insurer)
                {
                    ToolTip = 'Specifies the value of the Insurer field';
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ToolTip = 'Specifies the value of the Insurance Company field';
                }
                field("Premium Amount"; Rec."Premium Amount")
                {
                    ToolTip = 'Specifies the value of the Premium Amount field';
                }
                field(Valuer; Rec.Valuer)
                {
                    ToolTip = 'Specifies the value of the Valuer field';
                }
                field("Valuation Firm"; Rec."Valuation Firm")
                {
                    ToolTip = 'Specifies the value of the Valuation Firm field';
                }
                field("Last Valued Date"; Rec."Last Valued Date")
                {
                    ToolTip = 'Specifies the value of the Last Valued Date field';
                }
                field("Date of Commencement"; Rec."Date of Commencement")
                {
                    ToolTip = 'Specifies the value of the Date of Commencement field';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field';
                }
                field("Date of purchase"; Rec."Date of purchase")
                {
                    ToolTip = 'Specifies the value of the Date of purchase field';
                }
                field("Amount of Purchase"; Rec."Amount of Purchase")
                {
                    ToolTip = 'Specifies the value of the Amount of Purchase field';
                }
            }
            group(Maintenance)
            {
                Caption = 'Maintenance';

                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field';
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Maintenance Vendor No. field';
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                    ToolTip = 'Specifies the value of the Under Maintenance field';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ToolTip = 'Specifies the value of the Warranty Date field';
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ToolTip = 'Specifies the value of the Next Service Date field';
                }
                field("Maintainence Status"; Rec."Maintainence Status")
                {
                    Caption = 'Vehicle Status';
                    ToolTip = 'Specifies the value of the Vehicle Status field';
                }
            }
        }
        area(factboxes)
        {
            part(Control40; "Fixed Asset Picture")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Vehicle Equipment")
            {
                RunObject = page "Vehicle Equipment";
                RunPageLink = "Vehicle No" = field("No.");
                ToolTip = 'Executes the Vehicle Equipment action';
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Fixed Asset Type" := Rec."Fixed Asset Type"::Fleet;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Fixed Asset Type" := Rec."Fixed Asset Type"::Fleet;
    end;
}





