page 52057 "Company Activities"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Company Activities";
    Caption = 'Company Activities';
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
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the value of the Day field';
                }
                field(Venue; Rec.Venue)
                {
                    ToolTip = 'Specifies the value of the Venue field';
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ToolTip = 'Specifies the value of the Responsibility field';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field';
                }
            }
        }
    }

    actions
    {
    }
}





