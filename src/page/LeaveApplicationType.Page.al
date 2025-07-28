page 52897 "Leave Application Type"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Leave Application Type";
    Caption = 'Current Application Details';
    layout
    {

        area(content)
        {
            repeater(Group)
            {

                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Leave Code';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Leave Period';


                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Leave Type';
                    trigger OnValidate()
                    begin
                        //  CurrPage.LeaveStatistics.Page.GetLeaveEarnedToDate(Rec."Leave Code");
                        //rec."Leave Earned to Date" := HRManagement.GetLeaveDaysEarnedToDate(Rec, Rec."Leave Code");
                        CurrPage.Update();
                    end;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Leave Earned to Date';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    ToolTip = 'Days Applied';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'From';
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the From field';
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'To';
                    Editable = false;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the To field';
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Editable = false;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Resumption Date field';
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duties Taken Over By field';
                }

                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Leave Balance';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field';
                }
            }





        }
    }

    actions
    {
    }
}





