page 52228 "Pay Period"
{
    PageType = List;
    SourceTable = "Payroll Period";
    UsageCategory = Lists;
    ApplicationArea = All;
    Caption = 'Pay Period';
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
                    ToolTip = 'Specifies the value of the Closed field';
                    Editable = false;
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    ToolTip = 'Specifies the value of the Close Pay field';
                    Editable = false;
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                    ToolTip = 'Specifies the value of the P.A.Y.E field';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.';
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
                // "Payroll Project Allocation"
                action("Payroll Project Allocation")
                {
                    Caption = 'Payroll Project Allocation';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    Image = Process;
                    RunObject = page "Payroll Project Allocation";
                    //  Visible = false;
                    ToolTip = '"Payroll Project Allocation"';
                }
            }
        }
    }

    var
        ClosingFunction: Report "Close Pay Period";
}





