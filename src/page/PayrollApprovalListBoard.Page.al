page 52276 "Payroll Approval List-Board"
{
    ApplicationArea = All;
    Caption = 'Payroll Approval List-Board';
    CardPageId = "Payroll Approval-Board";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payroll Approval";
    SourceTableView = where("Employee Type" = const("Board Member"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ToolTip = 'Specifies the value of the Prepared By field';
                }
                field("Date-Time Prepared"; Rec."Date-Time Prepared")
                {
                    ToolTip = 'Specifies the value of the Date-Time Prepared field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }
}





