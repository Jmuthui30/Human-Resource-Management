page 52147 "Beneficiary Cards"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Beneficiaries";
    Caption = 'Beneficiary Cards';
    layout
    {
        area(content)
        {
            group(General)
            {
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
            }
        }
    }

    actions
    {
    }
}





