page 52240 "Payroll Request Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Payroll Request Lines";
    Caption = 'Payroll Request Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Previous Value"; Rec."Previous Value")
                {
                    ToolTip = 'Specifies the value of the Previous Value field';
                }
                field("New Value"; Rec."New Value")
                {
                    ToolTip = 'Specifies the value of the New Value field';
                }
                field(Change; Rec.Change)
                {
                    ToolTip = 'Specifies the value of the Change field';
                }
            }
        }
    }

    actions
    {
    }
}





