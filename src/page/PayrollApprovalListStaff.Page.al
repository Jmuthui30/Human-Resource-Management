page 52274 "Payroll Approval List-Staff"
{
    ApplicationArea = All;
    Caption = 'Payroll Approval-Staff';
    CardPageId = "Payroll Approval-Staff";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Approval";
    //SourceTableView = where("Employee Type" = const(Staff));

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
                field("Total Earnings"; Rec."Total Earnings")
                {
                    ToolTip = 'Specifies the value of the Total Earnings field.';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;
}





