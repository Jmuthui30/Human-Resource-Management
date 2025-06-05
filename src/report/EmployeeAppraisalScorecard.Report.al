report 52107 "Employee Appraisal Scorecard"
{
    ApplicationArea = All;
    Caption = 'Employee Appraisal Scorecard';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeAppraisalScorecard.rdl';

    dataset
    {
        dataitem(EmployeeAppraisal; "Employee Appraisal")
        {
            column(AppraiseeName; "Appraisee Name")
            {
            }
            column(AppraiseesJobTitle; "Appraisee's Job Title")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            column(AppraisersName; "Appraisers Name")
            {
            }
            column(AppraisersJobTitle; "Appraiser's Job Title")
            {
            }
            column(PeriodStart; "Period Start")
            {
            }
            column(PeriodEnd; "Period End")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }

            dataitem(AppraisalLines; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");

                column(WorkplanCode; GetWorkplanName("Workplan Code"))
                {
                }
                column(PerformanceMeasure; "Performance Measure")
                {
                }
                column(Actualtargets; "Actual targets")
                {
                }
                column(Initiativecode; "Initiative code")
                {
                }
                column(Description; Description)
                {
                }
                column(Achieved; "Achieved (%)")
                {
                }
                column(Rating; Rating)
                {
                }
                column(Weighting; Weighting)
                {
                }
                column(WeightedRating; "Weighted Rating")
                {
                }
            }

            dataitem("Appraisee Comments"; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where(Person = const(Appraisee));

                column(Comments_on_Performance_Appraisee; "Comments on Performance")
                {

                }
            }
            dataitem("Appraiser Comments"; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where(Person = const(Appraiser));

                column(Comments_on_Performance_Appraiser; "Comments on Performance")
                {

                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Workplans: Record "Appraisal Workplan Code";
        CompanyInfo: Record "Company Information";


    local procedure GetWorkplanName(WorkplanCode: Code[50]): Text
    begin
        if Workplans.Get(WorkplanCode) then
            exit(Workplans.Description)
        else
            exit(WorkplanCode);
    end;
}






