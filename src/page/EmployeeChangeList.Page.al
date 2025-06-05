page 52013 "Employee Change List"
{
    ApplicationArea = All;
    Caption = 'Employee Change List';
    CardPageId = "Employee Change Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Employee Change Request";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    ToolTip = 'Specifies the value of the Job Position Title field.';
                }
            }
        }
    }
}






