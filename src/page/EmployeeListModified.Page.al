page 52257 "Employee List Modified"
{
    ApplicationArea = All;
    Caption = 'Employee List Inactive';
    CardPageID = "Employee Card Custom";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = where(Status = filter(<> Active),
                            "Employee Type" = filter(<> "Board Member"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ToolTip = 'Specifies the value of the PIN Number field';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ToolTip = 'Specifies the value of the Social Security No. field';
                }
                field("NHIF No"; Rec."NHIF No")
                {
                    ToolTip = 'Specifies the value of the NHIF No field';
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Employment Type field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    ToolTip = 'Specifies the value of the Ethnic Name field';
                }
                field("Home District"; Rec."Home District")
                {
                    ToolTip = 'Specifies the value of the Home District field';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = BasicHR;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable := Rec.EnforcePayrollPermissions();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        NoDeleteEmployeeErr: Label 'You are not allowed to delete an employee';
    begin
        Error(NoDeleteEmployeeErr);
    end;
}





