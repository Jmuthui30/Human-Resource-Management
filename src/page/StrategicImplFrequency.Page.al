page 52205 "Strategic Impl Frequency"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Strategic Imp Frequency";
    Caption = 'Strategic Impl Frequency';
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
            }
        }
    }

    actions
    {
    }
}





