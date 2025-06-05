page 52144 "Rejected Acting Positions"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Employee Acting Position";
    SourceTableView = where("Document Type" = filter(Acting),
                            Status = filter(Rejected));
    Caption = 'Rejected Acting Positions';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field';
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                    ToolTip = 'Specifies the value of the Relieved Employee field';
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    ToolTip = 'Specifies the value of the Relieved Name field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Employee No."; Rec."Acting Employee No.")
                {
                    Caption = 'Reliever';
                    ToolTip = 'Specifies the value of the Reliever field';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Promotion Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Promotion Type field';
                }
            }
        }
    }

    actions
    {
    }
}





