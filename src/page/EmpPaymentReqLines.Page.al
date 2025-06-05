page 52248 "Emp. Payment Req Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Employee Pay Requests";
    Caption = 'Emp. Payment Req Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Employee Category"; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field';
                }
                field("No. of Units"; Rec."No. of Units")
                {
                    ToolTip = 'Specifies the value of the No. of Units field';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
                field(Leason; Rec.Leason)
                {
                    ToolTip = 'Specifies the value of the Leason field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("ED Code"; Rec."ED Code")
                {
                    ToolTip = 'Specifies the value of the ED Code field';
                }
                field(Rate; Rec.Rate)
                {
                    ToolTip = 'Specifies the value of the Rate field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
                ToolTip = 'Executes the Send Approval Request action';
            }
            action("Cancel Approval Request")
            {
                ToolTip = 'Executes the Cancel Approval Request action';
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SETRANGE("USER ID",USERID);
    end;
}





