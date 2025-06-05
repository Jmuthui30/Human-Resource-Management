page 52282 "Allowance Register List"
{
    ApplicationArea = All;
    CardPageID = "Allowance Register";
    Editable = false;
    PageType = List;
    SourceTable = "Allowance Register";
    Caption = 'Allowance Register List';
    //DeleteAllowed = false;

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
                field("Employee Type"; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field';
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





