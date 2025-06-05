page 52920 "Employee Timesheet line"
{
    Caption = 'Timesheet line';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Employee Working  Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                    Visible = false;
                }



                field("Donor Code"; Rec."Donor Code")
                {
                    ToolTip = 'Specifies the value of the Donor Code field';
                    ApplicationArea = all;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field';
                    ApplicationArea = all;
                }
                field("Amount Allocated ch"; Rec."Amount Allocated ch")
                {
                    ToolTip = 'Specifies the value of the Project Code field';
                    ApplicationArea = all;
                    Caption = 'Amount Allocation';
                }



                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Billable Time field';
                }
                field("No."; Rec."No.")
                {
                    // Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Billable Time field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Billable Time field';


                }

            }
        }
        // area(Factboxes)
        // {

        // }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}
