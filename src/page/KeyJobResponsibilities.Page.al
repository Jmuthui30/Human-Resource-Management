page 52027 "Key Job Responsibilities"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Key Job responsibilities";
    Caption = 'Key Job Responsibilities';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Responsibility Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Remarks; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}





