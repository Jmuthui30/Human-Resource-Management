page 52107 "Travelling Employees List"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Employees Travelling";
    Caption = 'Travelling Employees List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                    Caption = 'Transport';
                    ToolTip = 'Specifies the value of the Transport field';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    ToolTip = 'Specifies the value of the Per Diem field';
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                    ToolTip = 'Specifies the value of the Tuition Fee field';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Total Cost field';
                }
            }
        }
    }

    actions
    {
    }
}





