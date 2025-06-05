pageextension 52000 "EmployeeListPageExt" extends "Employee List"
{
    //Editable = false;
    layout
    {
        modify("Job Title")
        {
            Visible = false;
        }
        addafter("Last Name")
        {
            field("Job Position Title"; Rec."Job Position Title")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employee''s job title.';
            }
        }
        modify(Comment)
        {
            Visible = false;
        }

        addafter(Comment)
        {
            field(Gender; Rec.Gender)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gender field';
            }
            field("PIN Number"; Rec."PIN Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PIN Number field';
                Visible = false;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ID No. field';
                Visible = false;
            }
            field("Social Security No."; Rec."Social Security No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Social Security No. field';
                Visible = false;
            }
            field("NHIF No"; Rec."NHIF No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NHIF No field';
                Visible = false;
            }
            field(Disabled; Rec.Disabled)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Disabled field';
                Visible = false;
            }
            field("Employment Type"; Rec."Employment Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employment Type field';
                Visible = false;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field';
                Visible = false;
            }
            field("Bank Account Number"; Rec."Bank Account Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Account Number field';
                Visible = false;
            }
        }
    }

    actions
    {
        modify("Absence Registration")
        {
            Visible = false;
        }
        modify(PayEmployee)
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify("Sent Emails")
        {
            Visible = false;
        }
        modify(Email)
        {
            Visible = false;
        }
    }

    trigger OnOpenPage()
    begin
        //  CurrPage.Editable := Rec.EnforcePayrollPermissions();
    end;
}





