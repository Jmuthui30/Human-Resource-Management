page 52243 "Loan Application List-Payroll"
{
    ApplicationArea = All;
    CardPageID = "Loan Application Form-Payroll";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Loan Application";
    SourceTableView = where("Loan Status" = filter(<> Issued));
    Caption = 'Loan Application List-Payroll';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Loan Product Type field';
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ToolTip = 'Specifies the value of the Loan Status field';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Interest Calculation Method field';
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                    ToolTip = 'Specifies the value of the Amount Requested field';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ToolTip = 'Specifies the value of the Issued Date field';
                }
                field(Instalment; Rec.Instalment)
                {
                    ToolTip = 'Specifies the value of the Instalment field';
                }
                field(Repayment; Rec.Repayment)
                {
                    ToolTip = 'Specifies the value of the Repayment field';
                }
                field("Flat Rate Principal"; Rec."Flat Rate Principal")
                {
                    ToolTip = 'Specifies the value of the Flat Rate Principal field';
                }
                field("Flat Rate Interest"; Rec."Flat Rate Interest")
                {
                    ToolTip = 'Specifies the value of the Flat Rate Interest field';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field';
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Deduction Code field';
                }
            }
        }
    }

    actions
    {
    }
}





