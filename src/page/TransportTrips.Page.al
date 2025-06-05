page 52017 "Transport Trips"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Transport Trips";
    Caption = 'Transport Trips';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Request No field';
                }
                field(Date; Rec.Date)
                {
                    Enabled = not Requisition;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ToolTip = 'Specifies the value of the Vehicle Type field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                    Enabled = Requisition;
                    Editable = Rec."Vehicle Type" <> Rec."Vehicle Type"::Taxi;
                    ToolTip = 'Specifies the value of the Vehicle No field';
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vehicle Description field';
                }
                field("Vehicle Capacity"; Rec."Vehicle Capacity")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vehicle Capacity field';
                }
                field(Driver; Rec.Driver)
                {
                    Enabled = Requisition;
                    Editable = Rec."Vehicle Type" <> Rec."Vehicle Type"::Taxi;
                    ToolTip = 'Specifies the value of the Driver field';
                }
                field("Drivers Name"; Rec."Drivers Name")
                {
                    Editable = Rec."Vehicle Type" <> Rec."Vehicle Type"::Taxi;
                    ToolTip = 'Specifies the value of the Drivers Name field';
                }
                field("Previous KM"; Rec."Previous KM")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Previous KM field';
                }
                field("Time Out"; Rec."Time Out")
                {
                    Enabled = Requisition;
                    ToolTip = 'Specifies the value of the Time Out field';
                }
                field("Time In"; Rec."Time In")
                {
                    Editable = not Requisition;
                    ToolTip = 'Specifies the value of the Time In field';
                }
                field("End of Journey KM"; Rec."End of Journey KM")
                {
                    Editable = not Requisition;
                    ToolTip = 'Specifies the value of the End of Journey KM field';
                }
                field("KM Driven"; Rec."KM Driven")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the KM Driven field';
                }
                field("Litres of Oil"; Rec."Litres of Oil")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Litres of Oil field';
                }
                field("Litres of Fuel"; Rec."Litres of Fuel")
                {
                    Editable = false;
                    Visible = Rec."Vehicle Type" <> Rec."Vehicle Type"::Taxi;
                    ToolTip = 'Specifies the value of the Litres of Fuel field';
                }
                field("Order/Invoice/Cash/Voucher No."; Rec."Order/Invoice/Cash/Voucher No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Order/Invoice/Cash/Voucher No. field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CheckEditability();
    end;

    trigger OnOpenPage()
    begin
        CheckEditability();
    end;

    var
        Requisition: Boolean;

    procedure CheckEditability(): Boolean
    var
        TravelReq: Record "Travel Requests";
    begin
        if TravelReq.Get(GetReqCode()) then
            if TravelReq."Transport Status" = TravelReq."Transport Status"::Requisition then
                Requisition := true
            else
                Requisition := false;
    end;

    procedure GetReqCode(): Code[20]
    begin
        exit(Rec."Request No");
    end;
}





