
page 52901 "Employee Timesheet"
{
    CardPageId = "Employee Timesheet card";
    ApplicationArea = All;
    Editable = true;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Employee Work Time";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Work Date field';

                }



                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Work Date field';

                }




            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {

            //     // trigger OnAction()
            //     // begin

            //     // end;
            // }
        }
    }
    trigger OnOpenPage()
    begin
        // rec."Line No." := Rec."Line No." + 1;
    end;

    var
}