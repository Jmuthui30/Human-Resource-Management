page 52084 "Approved Recruitment Requests"
{
    ApplicationArea = All;
    Caption = 'Recruitment';
    CardPageId = "Recruitment Card";
    PageType = List;
    SourceTable = "Recruitment Needs";
    SourceTableView = where(Status = const(Released));

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
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Appointment Type Description"; Rec."Appointment Type Description")
                {
                    ToolTip = 'Specifies the value of the Appointment Type Description field';
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                }
                field("Shortlisting Started"; Rec."Shortlisting Started")
                {
                    ToolTip = 'Specifies the value of the Shortlisting Started field';
                }
                field("Documentation Link"; Rec."Documentation Link")
                {
                    ToolTip = 'Specifies the value of the Documentation Link field';
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                    ToolTip = 'Specifies the value of the Turn Around Time field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field';
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                    ToolTip = 'Specifies the value of the Reason for Recruitment field';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    ToolTip = 'Specifies the value of the Expected Reporting Date field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Reason for Recruitment(text)"; Rec."Reason for Recruitment(text)")
                {
                    ToolTip = 'Specifies the value of the Reason for Recruitment(text) field';
                }
            }
        }
    }

    actions
    {
    }
}





