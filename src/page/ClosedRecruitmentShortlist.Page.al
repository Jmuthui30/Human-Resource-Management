page 52149 "Closed Recruitment Shortlist"
{
    ApplicationArea = All;
    CardPageID = "Short List Card";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Recruitment Needs";
    SourceTableView = where("Shortlisting Closed" = filter(true));
    Caption = 'Closed Recruitment Shortlist';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field(Positions; Rec.Positions)
                {
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field(Approved; Rec.Approved)
                {
                    ToolTip = 'Specifies the value of the Approved field';
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ToolTip = 'Specifies the value of the Date Approved field';
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
        area(processing)
        {
        }
    }
}





