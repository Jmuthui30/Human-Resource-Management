page 52283 "Allowance Register Lines"
{
    ApplicationArea = All;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Allowance Register Line";
    Caption = 'Allowance Register Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Type"; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Earning Code"; Rec."Earning Code")
                {
                    ToolTip = 'Specifies the value of the Earning Code field.';

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Earning Description"; Rec."Earning Description")
                {
                    ToolTip = 'Specifies the value of the Earning Description field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ShowMandatory = true;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    ToolTip = 'Specifies the value of the Destination Code field.';
                    Editable = BasedOnRatesEditable;
                    ShowMandatory = true;
                }
                field("Date of Activity"; Rec."Date of Activity")
                {
                    ToolTip = 'Specifies the value of the Date of Activity field.';
                    ShowMandatory = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("No of sittings"; Rec."No of sittings")
                {
                    ToolTip = 'Specifies the value of the No of sittings field';
                }
                field(Rate; Rec.Rate)
                {
                    Caption = 'Rate(Exclusive Tax)';
                    ToolTip = 'Specifies the value of the Rate field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("PAYE Amount"; Rec."PAYE Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the PAYE Amount field.';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the value of the Net Amount field.';
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        BasedOnRatesEditable: Boolean;

    local procedure SetControlAppearance()
    begin
        if Rec."Earnings Calculation Method" = Rec."Earnings Calculation Method"::"Based on Travel Rates" then
            BasedOnRatesEditable := true
        else
            BasedOnRatesEditable := false;
    end;
}





