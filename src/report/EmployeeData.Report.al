report 52010 "Employee Data"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeData.rdl';
    Caption = 'Employee Data';
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = Gender, "Job Position", Status, "Responsibility Center";
            DataItemTableView = where("Employee Type" = filter(<> "Board Member"), Status = const(Active));
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Employee_No; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(Name_Employee; Employee.FullName())
            {
            }
            column(Job_ID; Employee."Job Position")
            {
            }
            column(JobTitle_Employee; Employee."Job Position Title")
            {
            }
            column(GlobalDimension1Code_Employee; Employee."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Employee; GetDept(Employee."Global Dimension 2 Code"))
            {
            }
            column(Salary_Scale; Employee."Salary Scale")
            {
            }
            column(Pointer_Employee; Employee."Present Pointer")
            {
            }
            column(Employment_Date; Employee."Employment Date")
            {
            }
            column(RetirementDate; "Retirement Date")
            {
            }
            column(Date_of_Birth; Employee."Birth Date")
            {
            }
            column(Basic_Pay; Employee."Basic Pay")
            {
            }
            column(House_Allowance; Employee."House Allowance")
            {
            }
            column(Gender; Employee.Gender)
            {
            }
            column(Ethnicity; Employee."Ethnic Origin")
            {
            }
            column(employee_Country; Employee."Country/Region Code")
            {
            }
            column(Disability; Employee.Disability)
            {
            }
            column(Age; "Date of Birth - Age")
            {
            }
            column(EmploymentDateAge; "Employment Date - Age")
            {
            }
            column(IDNo_Employee; "ID No.")
            {
            }
            column(NHIFNo_Employee; "NHIF No")
            {
            }
            column(SocialSecurityNo_Employee; "Social Security No.")
            {
            }
            column(ResponsibilityCenter_Employee; "Responsibility Center")
            {
            }
            column(CompanyEMail_Employee; "Company E-Mail")
            {
            }
            column(DateOfJoin_Employee; "Date Of Join")
            {
            }
            column(FOSAAccountNo_Employee; "Vendor No.")
            {
            }
            column(BOSAMemberNo_Employee; "Customer No.")
            {
            }
            column(MobilePhoneNo_Employee; "Mobile Phone No.")
            {
            }
            column(PINNumber_Employee; "PIN Number")
            {
            }
            column(Status_Employee; Status)
            {
            }
            column(UserID_Employee; "User ID")
            {
            }
            column(EMail_Employee; "E-Mail")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Employee."Birth Date" <> 0D then begin
                    Employee.Validate("Birth Date");
                    Employee.Modify();
                end;

                if Employee."Date Of Join" <> 0D then begin
                    Employee.Validate("Date Of Join");
                    Employee.Modify();
                end;

                EmpName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
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
        CompanyInfo: Record "Company Information";
        EmpName: Text;

    procedure GetDept("Code": Code[20]): Text[200]
    var
        DimValue: Record "Dimension Value";
    begin
        DimValue.Reset();
        DimValue.SetRange(Code, Code);
        if DimValue.Find('-') then
            exit(DimValue.Name);
    end;
}


