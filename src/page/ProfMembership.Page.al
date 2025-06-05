page 52220 "Prof Membership"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Professional Memberships";
    UsageCategory = Lists;
    Editable = true;
    Caption = 'Prof Membership';
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





