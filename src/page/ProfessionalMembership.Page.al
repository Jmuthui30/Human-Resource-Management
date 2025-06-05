page 52050 "Professional Membership"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Professional Membership";
    Caption = 'Professional Membership';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field';
                }
                field(Organisation; Rec.Organisation)
                {
                    ToolTip = 'Specifies the value of the Organisation field';
                }
                field("Date Admitted"; Rec."Date Admitted")
                {
                    ToolTip = 'Specifies the value of the Date Admitted field';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field("Annual Fee"; Rec."Annual Fee")
                {
                    ToolTip = 'Specifies the value of the Annual Fee field';
                }
                field("Renewal Date"; Rec."Renewal Date")
                {
                    ToolTip = 'Specifies the value of the Renewal Date field';
                }
                field("Company Pays Fees"; Rec."Company Pays Fees")
                {
                    ToolTip = 'Specifies the value of the Company Pays Fees field';
                }
            }
        }
    }

    actions
    {
    }
}





