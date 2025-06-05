page 52285 "HR Management Cues"
{
    ApplicationArea = All;
    Caption = 'HR Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HR Management Cue";

    layout
    {
        area(content)
        {
            cuegroup("Employees")
            {
                field("Employees Active"; Rec."Employees Active")
                {
                    ToolTip = 'Specifies the value of the Active Employees field';
                }
                field("Employees Inactive"; Rec."Employees Inactive")
                {
                    ToolTip = 'Specifies the value of the Inactive Employees field';
                }
            }
            cuegroup(Disciplinary)
            {
                field("Employee Discilinary cases"; Rec."Employee Discilinary cases")
                {
                    ToolTip = 'Specifies the value of the Employee Discilinary cases field';
                }
                field("Closed Disciplinary Cases"; Rec."Closed Disciplinary Cases")
                {
                    ToolTip = 'Specifies the value of the Closed Disciplinary Cases field';
                }
            }
            cuegroup(Recruitment)
            {
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ToolTip = 'Specifies the value of the Vacant Positions field';
                }
                field("Recruitment Requests"; Rec."Recruitment Requests")
                {
                    ToolTip = 'Specifies the value of the Recruitment Requests field';
                }
                field(Applicants; Rec.Applicants)
                {
                    ToolTip = 'Specifies the value of the Applicants field';
                }
                field("Recruitment Shortlist"; Rec."Recruitment Shortlist")
                {
                    ToolTip = 'Specifies the value of the Recruitment Shortlist field';
                }
                field("Interview List"; Rec."Interview List")
                {
                    ToolTip = 'Specifies the value of the Interview List field';
                }
            }
            cuegroup("Leave Management")
            {
                field("Leave Applications"; Rec."Leave Applications")
                {
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the Leave Applications field';
                }
                field("Leave Recalls"; Rec."Leave Recalls")
                {
                    ToolTip = 'Specifies the value of the Leave Recalls field';
                }
                field("Leave Adjustments"; Rec."Leave Adjustments")
                {
                    ToolTip = 'Specifies the value of the Leave Adjustments field';
                }
            }
            cuegroup("Perfomance")
            {
                field("Open Appraisals"; Rec."Open Appraisals")
                {
                    ToolTip = 'Specifies the value of the Open Appraisals field';
                }
                field("Appraisals Under Review"; Rec."Appraisals Under Review")
                {
                    ToolTip = 'Specifies the value of the Rolleover/Repayments Due field';
                }
                field("Appraisals Further Review"; Rec."Appraisals Further Review")
                {
                    ToolTip = 'Specifies the value of the Appraisals Under Further Review field';
                }
                field("Completed Appraisals"; Rec."Completed Appraisals")
                {
                    ToolTip = 'Specifies the value of the Completed Appraisals field';
                }
            }
            cuegroup("Acting and Promotion")
            {
                field("Acting Duties"; Rec."Acting Duties")
                {
                    DrillDownPageId = "Acting Duties List";
                    ToolTip = 'Specifies the value of the Acting Duties field';
                }
                field("Acting Duties Approved"; Rec."Acting Duties Approved")
                {
                    DrillDownPageId = "Acting Duties List";
                    ToolTip = 'Specifies the value of the Acting Duties Approved field';
                }
                field("Promotions/Demotions"; Rec.Promotions)
                {
                    DrillDownPageId = "Promotion_Demotion List";
                    ToolTip = 'Specifies the value of the Promotions field';
                }
                field("Promotions Approved"; Rec."Promotions Approved")
                {
                    DrillDownPageId = "Promotion_Demotions Approved";
                    ToolTip = 'Specifies the value of the Promotions Approved field';
                }
            }
            cuegroup("Training")
            {
                field("Training Needs"; Rec."Training Needs")
                {
                    ToolTip = 'Specifies the value of the Training Needs field';
                }
                field("Training Needs Applications"; Rec."Training Needs Applications")
                {
                    ToolTip = 'Specifies the value of the Training Needs Applications field';
                }
                field("Training Requests"; Rec."Training Requests")
                {
                    ToolTip = 'Specifies the value of the Training Requests field';
                }
                field("Approved Training requests"; Rec."Approved Training requests")
                {
                    ToolTip = 'Specifies the value of the Approved Training requests field';
                }
            }
            cuegroup(Transport)
            {
                Visible = false;
                field("Travel Requests"; Rec."Travel Requests")
                {
                    ToolTip = 'Specifies the value of the Travel Requests field';
                }
                field("Travel Requests Approved"; Rec."Travel Requests Approved")
                {
                    ToolTip = 'Specifies the value of the Travel Requests Approved field';
                }
                field("Ongoing Trips"; Rec."Ongoing Trips")
                {
                    ToolTip = 'Specifies the value of the Ongoing Trips field';
                }
                field("Completed Trips"; Rec."Completed Trips")
                {
                    ToolTip = 'Specifies the value of the Completed Trips field';
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies the value of the Requests to Approve field';
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    DrillDownPageID = "Approval Request Entries";
                    ToolTip = 'Specifies the value of the Requests Sent for Approval field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID Filter", UserId);
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}





