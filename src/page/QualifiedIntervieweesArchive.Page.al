page 52044 "Qualified Interviewees Archive"
{
    ApplicationArea = All;
    CardPageID = "Qualified Interviewee Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Recruitment Needs";
    SourceTableView = where(Status = const(Archived), "Shortlisting Closed" = const(true));
    Caption = 'Qualified Interviewees Archive';
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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}





