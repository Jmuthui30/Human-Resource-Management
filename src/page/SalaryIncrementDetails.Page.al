page 52289 "Salary Increment Details"
{
    ApplicationArea = All;
    Caption = 'Salary Increment Details';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Salary Pointer Increment";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field("Increment Date"; Rec."Increment Date")
                {
                    ToolTip = 'Specifies the value of the Increment Date field.';
                }
                field("Increment Year"; Rec."Increment Year")
                {
                    ToolTip = 'Specifies the value of the Increment Year field.';
                }
                field("Previous Scale"; Rec."Previous Scale")
                {
                    ToolTip = 'Specifies the value of the Previous Scale field.';
                }
                field("Previous Pointer"; Rec."Previous Pointer")
                {
                    ToolTip = 'Specifies the value of the Previous Pointer field.';
                }
                field("Present Scale"; Rec."Present Scale")
                {
                    ToolTip = 'Specifies the value of the Present Scale field.';
                }
                field("Present Pointer"; Rec."Present Pointer")
                {
                    ToolTip = 'Specifies the value of the Present Pointer field.';
                }
                field("Next Increment Date"; Rec."Next Increment Date")
                {
                    ToolTip = 'Specifies the value of the Next Increment Date field.';
                }
            }
        }
    }
}


