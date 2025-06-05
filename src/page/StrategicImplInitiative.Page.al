page 52207 "Strategic Impl Initiative"
{
    ApplicationArea = All;
    Caption = 'Strategic Implementation Initiative';
    PageType = ListPart;
    SourceTable = "Strategic Imp Initiatives";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Initiatives; Rec.Initiatives)
                {
                    ToolTip = 'Specifies the value of the Initiatives field';
                }
                field(ObjectiveCode; Rec.ObjectiveCode)
                {
                    Caption = 'Strategic objectives code';
                    ToolTip = 'Specifies the value of the Strategic objectives code field';
                    Visible = false;
                }
                field("Strategic Objectives"; Rec."Strategic Objectives")
                {
                    ToolTip = 'Specifies the value of the Strategic Objectives field';
                    Visible = false;
                }
            }
        }
    }

    /* actions
    {
        area(Navigation)
        {
            action(Activities)
            {
                Image = CampaignEntries;
                RunObject = page "Strategic Impl Activities";
                RunPageLink = InitiativeCode = field(Code);
                ApplicationArea = All;
                ToolTip = 'Executes the Activities action';
                Visible = false;
            }
        }
    } */
}





