page 52224 "Perfomance rating matrix"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Perfomance rating matrix";
    Caption = 'Perfomance rating matrix';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Start; Rec.Start)
                {
                    ToolTip = 'Specifies the value of the Start field';
                }
                field("End"; Rec."End")
                {
                    ToolTip = 'Specifies the value of the End field';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                }
            }
        }
    }

    actions
    {
    }
}





