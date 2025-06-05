page 52106 "Medical Dependants"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Medical Scheme Lines";
    Caption = 'Medical Dependants';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field';
                }
                field(SurName; Rec.SurName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the SurName field';
                }
                field("Other Names"; Rec."Other Names")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Other Names field';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Of Birth field';
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Policy Start Date field';
                }
                field("Amount Spent (In-Patient)"; Rec."Amount Spend (In-Patient)")
                {
                    ToolTip = 'Specifies the value of the Amount Spend (In-Patient) field';
                }
                field("Amout Spent (Out-Patient)"; Rec."Amout Spend (Out-Patient)")
                {
                    ToolTip = 'Specifies the value of the Amout Spend (Out-Patient) field';
                }
            }
        }
    }

    actions
    {
    }
}





