page 52993 "Cash Payment"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cash Payment";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'the Tooltip property for PageField "Employee No" must be filled';

                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'The Tooltip property for PageField "Employee Name" must be filled';
                    Visible = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'The Tooltip property for PageField "Payroll Period" must be filled.';

                }
                field("Cash Amount"; Rec."Cash Amount")
                {
                    ToolTip = 'The Tooltip property for PageField "Cash Amount" must be filled.';

                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'The Tooltip property for PageField Location must be filled';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'The Tooltip property for PageField Status must be filled.';

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}