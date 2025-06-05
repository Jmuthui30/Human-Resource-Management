page 52128 "Employee Relative Change Reque"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Emp NOK Change Request";
    Caption = 'Employee Relative Change Reque';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Dependant No"; Rec."Dependant No")
                {
                    ToolTip = 'Specifies the value of the Dependant No field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                }
                field("Relative Code"; Rec."Relative Code")
                {
                    ToolTip = 'Specifies the value of the Relative Code field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import dependants")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Import dependants action';

                trigger OnAction()
                begin
                    // CLEAR(ImportDependants);
                    // ImportDependants.RUN;
                end;
            }
        }
    }
}





