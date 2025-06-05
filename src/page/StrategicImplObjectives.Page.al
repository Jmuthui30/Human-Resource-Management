page 52206 "Strategic Impl Objectives"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Strategic Imp Objectives";
    Caption = 'Strategic Impl Objectives';
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
            action(Initiatives)
            {
                Image = CampaignEntries;
                RunObject = page "Strategic Impl Initiative";
                RunPageLink = ObjectiveCode = field(Code);
                ToolTip = 'Executes the Initiatives action';
            }
        }
    }
}





