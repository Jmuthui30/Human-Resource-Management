page 52161 "Qualifications Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = Qualification;
    Caption = 'Qualifications Setup';
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
            }
        }
    }

    actions
    {
    }
}





