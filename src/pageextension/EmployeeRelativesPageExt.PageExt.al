pageextension 52004 "EmployeeRelativesPageExt" extends "Employee Relatives"
{
    layout
    {
        modify("Middle Name")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field("Employee No."; Rec."Employee No.")
            {
                Enabled = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee No. field';
            }
        }
        addafter("Middle Name")
        {
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Name field';
            }
        }
        addafter("Birth Date")
        {

            field(Age; Rec.Age)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Age field.';
                Editable = false;
            }
        }
    }
}





