page 52002 "Payroll Requests"
{
    ApplicationArea = All;
    CardPageID = "Payroll Request Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Requests";
    Caption = 'Payroll Requests';
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
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Responsibility Code"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Code Descripton"; Rec."Code Descripton")
                {
                    ToolTip = 'Specifies the value of the Code Descripton field';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
                field("Date of Activity"; Rec."Date of Activity")
                {
                    ToolTip = 'Specifies the value of the Date of Activity field.';
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





