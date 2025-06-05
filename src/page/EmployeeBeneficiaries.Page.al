page 52146 "Employee Beneficiaries"
{
    ApplicationArea = All;
    CardPageID = "Beneficiary Cards";
    PageType = List;
    SourceTable = "Employee Beneficiaries";
    Caption = 'Employee Beneficiaries';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Beneficiary No."; Rec."Beneficiary No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Beneficiary No. field';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
            }
        }
    }

    actions
    {
    }
}





