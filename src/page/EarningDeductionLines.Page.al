page 52253 "Earning & Deduction Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Import Earn & Ded Lines";
    Caption = 'Earning & Deduction Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount field';
                }
            }
        }
    }

    actions
    {
    }
}





