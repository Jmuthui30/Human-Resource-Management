Page 52313 "Payroll Project Allocation"
{
    PageType = List;
    SourceTable = "Payroll Project Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ToolTip = 'The Tooltip property for PageField Period must be filled';
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'The Tooltip property for PageField "Employee No" must be filled';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'The Tooltip property for PageField "Employee Name" must be filled.';
                    ApplicationArea = All;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'The Tooltip property for PageField "Project Code" must be filled.';
                    ApplicationArea = All;
                }
                field("Budget Line Code"; Rec."Budget Line Code")
                {
                    ToolTip = 'The Tooltip property for PageField "Budget Line Code" must be filled.';
                    ApplicationArea = All;
                }
                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'The Tooltip property for PageField Allocation must be filled.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadAllocations)
            {
                ApplicationArea = All;
                Caption = 'Load Allocations';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'The Tooltip property for PageAction LoadAllocations must be filled.';
                trigger OnAction()
                begin
                    PayrollCalender_AU.Reset;
                    PayrollCalender_AU.SetRange(Closed, true);
                    if PayrollCalender_AU.FindLast then begin
                        PayrollProjectAllocation.Reset;
                        PayrollProjectAllocation.SetRange(Period, PayrollCalender_AU."Pay Date");
                        if PayrollProjectAllocation.FindSet then begin
                            repeat
                                PayrollCalender_AU2.Reset;
                                if PayrollCalender_AU2.FindLast then begin
                                    PayrollProjectAllocation2.Init;
                                    PayrollProjectAllocation2.Period := PayrollCalender_AU2."Pay Date";
                                    PayrollProjectAllocation2."Project Code" := PayrollProjectAllocation."Project Code";
                                    PayrollProjectAllocation2."Budget Line Code" := PayrollProjectAllocation."Budget Line Code";
                                    PayrollProjectAllocation2."Employee No" := PayrollProjectAllocation."Employee No";
                                    PayrollProjectAllocation2."Employee Name" := PayrollProjectAllocation."Employee Name";
                                    PayrollProjectAllocation2.Allocation := PayrollProjectAllocation.Allocation;
                                    PayrollProjectAllocation2.Insert;
                                end;
                            until PayrollProjectAllocation.Next = 0;
                        end;
                        Message('Completed');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Employee Name" = '' then begin
            if HREmployees.Get(Rec."Employee No") then begin
                Rec."Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                Rec.Modify;
            end;
        end;
    end;

    var
        HREmployees: Record Employee;
        PayrollProjectAllocation: Record "Payroll Project Allocation";
        PayrollCalender_AU: Record "Payroll Period";
        PayrollCalender_AU2: Record "Payroll Period";
        PayrollProjectAllocation2: Record "Payroll Project Allocation";
}

