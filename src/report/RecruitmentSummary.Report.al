report 52115 "Recruitment Summary"
{
    ApplicationArea = All;
    Caption = 'Recruitment Summary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/RecruitmentSummary.rdl';

    dataset
    {
        dataitem(RecruitmentNeeds; "Recruitment Needs")
        {
            column(No; "No.")
            {
            }
            column(JobID; "Job ID")
            {
            }
            column(Description; Description)
            {
            }
            column(ReasonforRecruitment; "Reason for Recruitment")
            {
            }
            column(StageCode; "Stage Code")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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
}






