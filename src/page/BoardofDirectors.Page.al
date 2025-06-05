page 52064 "Board of Directors"
{
    ApplicationArea = All;
    CardPageID = "Board of Director";
    PageType = List;
    SourceTable = "Board of Director";
    Caption = 'Board of Directors';
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
                field(SurName; Rec.SurName)
                {
                    ToolTip = 'Specifies the value of the SurName field';
                }
                field("Other Names"; Rec."Other Names")
                {
                    ToolTip = 'Specifies the value of the Other Names field';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Phone No field';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
            }
        }
    }

    actions
    {
    }
}





