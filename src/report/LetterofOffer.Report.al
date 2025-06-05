report 52003 "Letter of Offer"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/LetterofOffer.rdl';
    Caption = 'Letter of Offer';
    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            column(First_Name; Applicants."First Name")
            {
            }
            column(Middle_Name; Applicants."Middle Name")
            {
            }
            column(Last_Name; Applicants."Last Name")
            {
            }
            column(Postal_Address; Applicants."Postal Address")
            {
            }
            column(Residential_Address; Applicants."Residential Address")
            {
            }
            column(Job_Description; JobDescription)
            {
            }
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Address; CompanyInfo.Address)
            {
            }
            column(Comp_Tel; CompanyInfo."Phone No.")
            {
            }
            column(Comp_City; CompanyInfo.City)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Comp_Email; CompanyInfo."E-Mail")
            {
            }
            column(Comp_Website; CompanyInfo."Home Page")
            {
            }
            column(Comp_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Salutation; Salutation)
            {
            }
            column(Job_Grade; JobGroup)
            {
            }
            column(Basic_Salary; BasicPay)
            {
            }
            column(House_Allowance; HouseAllowance)
            {
            }
            column(Salary_Pointer; MinPointer)
            {
            }
            column(Reporting_To; ReportingTo)
            {
            }
            column(Reporting_Date; Applicants."Expected Reporting Date")
            {
            }
            column(Sign_Name; '')
            {
            }
            column(Sign_Title; '')
            {
            }
            column(Sign_Signature; '')
            {
            }
            dataitem("Applicant job applied"; "Applicant job applied")
            {
                DataItemTableView = sorting("Applicant No.", "Need Code");
                DataItemLink = "Applicant No." = field("No.");
                column(Need_Code; "Applicant job applied"."Need Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Applicants.Get("Job Application"."Applicant No.");

                RecruitmentNeeds.Get("Job Application"."Job Applied Code");

                Jobs.Get(RecruitmentNeeds."Job ID");
                JobGroup := Jobs.Grade;
                JobDescription := Jobs."Job Description";

                ReportingTo := GetJobReporting(Jobs."Position Reporting to");

                if Scale.Get(JobGroup) then
                    MinPointer := Scale."Minimum Pointer";

                Pointer.Reset();
                if Pointer.Get(JobGroup, MinPointer) then begin
                    //Get Basic Salary
                    Earning.Reset();
                    Earning.SetRange("Basic Salary Code", true);
                    if Earning.Find('-') then begin
                        Benefits.Reset();
                        Benefits.SetRange("ED Code", Earning.Code);
                        if Benefits.FindFirst() then
                            BasicPay := Benefits.Amount;
                    end;

                    //Get House Allowance
                    Earning.Reset();
                    Earning.SetRange("House Allowance Code", true);
                    if Earning.Find('-') then begin
                        Benefits.Reset();
                        Benefits.SetRange("ED Code", Earning.Code);
                        if Benefits.FindFirst() then
                            HouseAllowance := Benefits.Amount;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Applicants: Record Applicants;
        CompanyInfo: Record "Company Information";
        Jobs: Record "Company Job";
        Earning: Record Earnings;
        RecruitmentNeeds: Record "Recruitment Needs";
        Pointer: Record "Salary Pointer";
        Scale: Record "Salary Scale";
        Benefits: Record "Scale Benefits";
        JobGroup: Code[10];
        MinPointer: Code[10];
        BasicPay: Decimal;
        HouseAllowance: Decimal;
        JobDescription: Text;
        ReportingTo: Text;
        Salutation: Text;

    local procedure GetJobReporting(JobId: Code[10]): Text[250]
    var
        Jobs: Record "Company Job";
    begin
        if Jobs.Get(JobId) then
            exit(Jobs."Job Description");
    end;
}





