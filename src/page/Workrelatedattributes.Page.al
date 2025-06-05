page 52222 "Work related attributes"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Work related attributes";
    Caption = 'Work related attributes';
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
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Indicators)
            {
                Image = CampaignEntries;
                RunObject = page "Work related indicators";
                RunPageLink = AttributeCode = field(Code);
                ToolTip = 'Executes the Indicators action';
            }
        }
    }
}





