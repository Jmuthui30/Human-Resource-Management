page 52010 "Employee Separation List"
{
    ApplicationArea = All;
    Caption = 'Employee Separation List';
    PageType = List;
    SourceTable = "Employee Separation";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Employee Separtion Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Separation Type"; Rec."Separation Type")
                {
                    ToolTip = 'Specifies the value of the Separation Type field.';
                }
            }
        }
    }
}






