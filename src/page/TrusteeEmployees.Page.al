page 52177 "Trustee Employees"
{
    ApplicationArea = All;
    CardPageID = "Trustee Employee Card";
    PageType = List;
    SourceTable = Employee;
    SourceTableView = where("Employee Type" = filter("Board Member"));
    Caption = 'Trustee Employees';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
    end;
}





