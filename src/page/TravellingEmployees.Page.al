page 52078 "Travelling Employees"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Travelling Employee";
    Caption = 'Travelling Employees';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Shortcut Dimension 1"; Rec."Shortcut Dimension 1")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 field';
                }
                field("Shortcut Dimension 2"; Rec."Shortcut Dimension 2")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 field';
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Per Diem field';
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Request No."; Rec."Request No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Request No. field';
                }
            }
        }
    }

    actions
    {
    }
}





