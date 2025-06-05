page 52095 "Recruitment Stages"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Recruitment Stages";
    Caption = 'Recruitment Stages';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Recruitement Stage"; Rec."Recruitement Stage")
                {
                    ToolTip = 'Specifies the value of the Recruitement Stage field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Application; Rec.Application)
                {
                    ToolTip = 'Specifies the value of the Application field';
                }
                field(Interview; Rec.Interview)
                {
                    ToolTip = 'Specifies the value of the Interview field';
                }
            }
        }
    }

    actions
    {
    }
}





