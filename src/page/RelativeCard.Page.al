page 52129 "Relative Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Relative";
    Caption = 'Relative Card';
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
                field("Dependant No"; Rec."Dependant No")
                {
                    ToolTip = 'Specifies the value of the Dependant No field';
                }
                field("Relative Code"; Rec."Relative Code")
                {
                    ToolTip = 'Specifies the value of the Relative Code field';
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
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                }
                field("Relative's Employee No."; Rec."Relative's Employee No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Relative''s Employee No. field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Dependant; Rec.Dependant)
                {
                    ToolTip = 'Specifies the value of the Dependant field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}





