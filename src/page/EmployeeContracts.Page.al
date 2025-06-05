page 52124 "Employee Contracts"
{
    ApplicationArea = All;
    CardPageID = "Employee Contract";
    PageType = List;
    SourceTable = "Employee Contracts";
    SourceTableView = where(Status = filter(<> Released));
    Caption = 'Employee Contracts';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field';
                }
                field(Tenure; Rec.Tenure)
                {
                    ToolTip = 'Specifies the value of the Tenure field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
    }
}





