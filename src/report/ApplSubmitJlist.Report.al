report 52959 "Appl. Submit J list"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSubJ;

    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            RequestFilterFields = "Job Applied Code", "Job Title", "Applicant No.";

            // DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No")WHERE(Type=CONST(Deduction), Code=const('PROVIDENT'));
            DataItemTableView = where(Submitted = filter(true));

            column(No_; "No.")
            {
            }
            column(countNo; countNo) { }
            column(Applicant_No_; "Applicant No.") { }
            column(Applicant_Name; "Applicant Name") { }

            column(Gender; Gender) { }

            column(Job_Applied_Code; "Job Applied Code") { }
            column(Job_Title; "Job Title") { }
            column(Date_Time_Created; "Date-Time Created") { }
            dataitem("Applicants Qualification"; "Applicants Qualification")
            {
                DataItemLink = "Employee No." = field("Applicant No.");
                column(Qualification; Qualification) { }
                column(Description; Description) { }
                column(To_Date; "To Date") { }
                column(From_Date; "From Date") { }
            }
            trigger OnAfterGetRecord()
            begin
                countNo := countNo + 1;
            end;

        }
    }



    rendering
    {
        layout(ApplSubJ)
        {

            //Type = Excel;
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ApplSubmit_list.RDLC';

            Caption = 'Applicants Submitted Jobs';
        }
    }

    var

        // HRDatesExt: Codeunit "HR Dates Mgt";
        // SharePointIntergration: Record "SharePoint Intergration";
        //  RelevantCoursesTrainings: Record "Relevant Courses & Trainings";
        // ApplicantProfessionalBodies: Record "Applicant Professional Bodies";
        /// // //Applicant Professional Bodies
        //  ApplicantCurrentEmployment: Record "Applicant Current Employment";
        //  ApplicantsQualification: Record "Applicants Qualification";
        //  ApplicantApp: Record Applicant;
        //  RecrmntNeed: Record "Recruitment Needs";
        // Years: Text[100];
        countNo: Integer;
    //Dates: Codeunit "HR Dates Mgt";



}