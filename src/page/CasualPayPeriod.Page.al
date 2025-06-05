page 52245 "Casual Pay Period"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Payroll Period Casuals";
    Caption = 'Casual Pay Period';
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
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    ToolTip = 'Specifies the value of the Close Pay field';
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                    ToolTip = 'Specifies the value of the P.A.Y.E field';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field';
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
                    ToolTip = 'Executes the Close Pay Period action';

                    trigger OnAction()
                    begin

                        if not Confirm('You are about to close the current Pay period are you sure you want to do this?' + //
                        ' Make sure all reports are correct before closing the current pay period, Go ahead?', false) then
                            exit;

                        //ClosingFunction.GetCurrentPeriod(Rec);
                        //ClosingFunction.RUN;
                    end;
                }
                group(Action14)
                {
                    action("Create Period")
                    {
                        Caption = 'Create Period';
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = New;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;
                        //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedOnly = false;
                        RunObject = report "Create Payroll Period- Casual";
                        ToolTip = 'Executes the Create Period action';
                    }
                }
            }
        }
    }
}





