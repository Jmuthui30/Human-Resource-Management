page 52208 "Strategic Impl Activities"
{
    ApplicationArea = All;
    Caption = 'Strategic Implimentation Activities';
    PageType = List;
    SourceTable = "Strategic Imp Activities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("Activity Code"; Rec."Activity Code")
                {
                    ToolTip = 'Specifies the value of the # field';
                }
                field(Activities; Rec.Activities)
                {
                    ToolTip = 'Specifies the value of the Activities field';
                }
                field(InitiativeCode; Rec.InitiativeCode)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the InitiativeCode field';
                }
                field(Initiative; Rec.Initiative)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initiative field';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Measure; Rec.Measure)
                {
                    ToolTip = 'Specifies the value of the Measure field';
                }
                field(KPI; Rec.KPI)
                {
                    Caption = 'Key Perfomance Indicators';
                    ToolTip = 'Specifies the value of the Key Perfomance Indicators field';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field';
                }
            }
        }
    }

    actions
    {
    }
}





