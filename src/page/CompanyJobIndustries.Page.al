page 52194 "Company Job Industries"
{
    ApplicationArea = All;
    Caption = 'Company Job Industries';
    PageType = List;
    SourceTable = "Company Job Industry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
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
}





