page 52223 "Work related indicators"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Work related indicators";
    Caption = 'Work related indicators';
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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(AttributeCode; Rec.AttributeCode)
                {
                    ToolTip = 'Specifies the value of the AttributeCode field';
                }
            }
        }
    }

    actions
    {
    }
}
