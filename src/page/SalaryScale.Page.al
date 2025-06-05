page 52234 "Salary Scale"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Salary Scale";
    Caption = 'Salary Scale';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Scale; Rec.Scale)
                {
                    ToolTip = 'Specifies the value of the Scale field';
                    Caption = 'Grade';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("No. of Employees"; Rec."No. of Employees")
                {
                    ToolTip = 'Specifies the value of the No. of Employees field.';
                }
                field("Minimum Pointer"; Rec."Minimum Pointer")
                {
                    ToolTip = 'Specifies the value of the Minimum Pointer field';
                    Caption = 'Minimum Step';
                }
                field("Maximum Pointer"; Rec."Maximum Pointer")
                {
                    ToolTip = 'Specifies the value of the Maximum Pointer field';
                    Caption = 'Maximum Step';
                }
                field("Max Imprest"; Rec."Max Imprest")
                {
                    Visible = false;
                    Caption = 'Max Imprest Unsurrendered';
                    ToolTip = 'Specifies the value of the Max Imprest Unsurrendered field';
                }
                field("Leave Days"; Rec."Leave Days")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Days field';
                    Caption = 'Leave Days';
                }
                field("In Patient Limit"; Rec."In Patient Limit")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the In Patient Limit field';
                    Caption = 'In Patient Limit';
                }
                field("Out Patient Limit"; Rec."Out Patient Limit")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Out Patient Limit field';
                    Caption = 'Out Patient Limit';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Per Diem field';
                    Caption = 'Per Diem';
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Location field';
                    Caption = 'Location';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Pointers)
            {
                Caption = 'Steps';
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Salary pointer";
                RunPageLink = "Salary Scale" = field(Scale);
                ToolTip = 'Executes the Pointer action';
            }
            action(Allowances)
            {
                Caption = 'Allowances';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                RunObject = page "Salary Scale Allowances";
                RunPageLink = "Salary Scale" = field(Scale);
                ToolTip = 'Executes the Pointer action';
            }
        }
    }
}





