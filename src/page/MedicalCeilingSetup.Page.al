page 52288 "Medical Ceiling Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Medical Ceiling Setup";
    Caption = 'Medical Ceiling Setup';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
                field("Annual Amount"; Rec."Annual Amount")
                {
                    ToolTip = 'Specifies the value of the Annual Amount field';
                }
            }
        }
    }

    actions
    {
    }
}





