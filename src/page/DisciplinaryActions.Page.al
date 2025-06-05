page 52036 "Disciplinary Actions"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Disciplinary Actions";
    Caption = 'Disciplinary Actions';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Warning Letter"; Rec."Warning Letter")
                {
                    ToolTip = 'Specifies the value of the Warning Letter field';
                }
            }
        }
    }

    actions
    {
    }
}





