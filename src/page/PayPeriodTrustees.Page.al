page 52262 "Pay Period Trustees"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Payroll Period Trustees";
    Caption = 'Pay Period Trustees';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ToolTip = 'Specifies the value of the New Fiscal Year field';
                }
                field("Pay Date"; Rec."Pay Date")
                {
                    ToolTip = 'Specifies the value of the Pay Date field';
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Closed field';
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Close Pay field';
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    ToolTip = 'Specifies the value of the Total Allowances field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field';
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                    ToolTip = 'Specifies the value of the P.A.Y.E field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action12)
            {
                action("Close Pay Period")
                {
                    Caption = 'Close Pay Period';
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Close Pay Period action';

                    trigger OnAction()
                    begin

                        if not Confirm('You are about to close the current Pay period are you sure you want to do this?' + //
                        ' Make sure all reports are correct before closing the current pay period, Go ahead?', false) then
                            exit;

                        ClosingFunction.GetCurrentPeriod(Rec);
                        ClosingFunction.Run();
                    end;
                }
                action("Create Period")
                {
                    Caption = 'Create Period';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    RunObject = report "Create Payroll Period";
                    Visible = false;
                    ToolTip = 'Executes the Create Period action';
                }
            }
        }
    }

    var
        ClosingFunction: Report "Close Pay Period - Trustees";
}





