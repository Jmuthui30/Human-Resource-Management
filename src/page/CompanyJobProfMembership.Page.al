page 52217 "Company Job Prof Membership"
{
    ApplicationArea = All;
    Caption = 'Company Job Professional membership';
    PageType = ListPart;
    SourceTable = "Company Job Prof Membership";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }
}





