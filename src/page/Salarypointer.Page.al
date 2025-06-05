page 52235 "Salary pointer"
{
    ApplicationArea = All;
    Caption = 'Salary Steps';
    PageType = List;
    SourceTable = "Salary Pointer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Salary Scale"; Rec."Salary Scale")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Salary Scale field';
                    Caption = 'Salary Grade';
                }
                field("Salary Pointer"; Rec."Salary Pointer")
                {
                    ToolTip = 'Specifies the value of the Salary Pointer field';
                    Caption = 'Salary Step';
                }
                field("No. of Employees"; Rec."No. of Employees")
                {
                    ToolTip = 'Specifies the value of the No. of Employees field.';
                }
                field("Basic Pay int"; Rec."Basic Pay int")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Basic Pay int field';
                    Caption = 'Basic Pay int';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Basic Pay field';
                    Caption = 'Basic Pay';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Earnings)
            {
                Caption = 'Earnings';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = false;
                RunObject = page "Scale Benefits";
                RunPageLink = "Salary Scale" = field("Salary Scale"),
                              "Salary Pointer" = field("Salary Pointer");
                ToolTip = 'Executes the Earnings action';
            }
        }
    }
}





