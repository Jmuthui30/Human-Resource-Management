page 52053 "Employment History"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Employment History";
    SourceTableView = sorting(From, To)
                      order(descending);
    Caption = 'Employment History';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field';
                }
                field("To"; Rec."To")
                {
                    ToolTip = 'Specifies the value of the To field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Key Experience"; Rec."Key Experience")
                {
                    ToolTip = 'Specifies the value of the Key Experience field';
                }
                field("Salary On Leaving"; Rec."Salary On Leaving")
                {
                    ToolTip = 'Specifies the value of the Salary On Leaving field';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field';
                }
                field("Reason For Leaving"; Rec."Reason For Leaving")
                {
                    ToolTip = 'Specifies the value of the Reason For Leaving field';
                }
                field(Current; Rec.Current)
                {
                    ToolTip = 'Specifies the value of the Current field';
                }
            }
        }
    }

    actions
    {
    }
}





