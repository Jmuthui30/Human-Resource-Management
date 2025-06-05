page 52165 "User Incidences"
{
    ApplicationArea = All;
    CardPageID = "User Incidences Card";
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(Pending | Escalated));
    Caption = 'User Incidences';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    ToolTip = 'Specifies the value of the Incident Reference field';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ToolTip = 'Specifies the value of the Incident Date field';
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    ToolTip = 'Specifies the value of the Incident Status field';
                }
            }
        }
    }

    actions
    {
    }
}





