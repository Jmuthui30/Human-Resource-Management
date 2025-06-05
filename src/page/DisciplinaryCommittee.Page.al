page 52298 "Disciplinary Committee"
{
    ApplicationArea = All;
    Caption = 'Disciplinary Committee';
    PageType = ListPart;
    SourceTable = "Disciplinary Committee";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member Type"; Rec."Member Type")
                {
                    ToolTip = 'Specifies the value of the Member Type field.';
                }
                field("Committee Member No."; Rec."Committee Member No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Committee Member Name"; Rec."Committee Member Name")
                {
                    ToolTip = 'Specifies the value of the Committee Member Name field.';
                }
            }
        }
    }
}






