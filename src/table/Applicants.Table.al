table 52086 "Applicants"
{
    DrillDownPageId = "Applicant Card";
    LookupPageId = "Applicants List";
    DataClassification = CustomerContent;
    Caption = 'Applicants';
    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
            Caption = 'No.';
        }
        field(2; "First Name"; Text[80])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                GetFullName();
            end;
        }
        field(3; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
            trigger OnValidate()
            begin
                GetFullName();
            end;
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                GetFullName();
            end;
        }
        field(5; Initials; Text[15])
        {
            Caption = 'Initials';
        }
        field(7; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(8; "Postal Address"; Text[80])
        {
            Caption = 'Postal Address';
        }
        field(9; "Residential Address"; Text[80])
        {
            Caption = 'Residential Address';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            Caption = 'Post Code';
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
        }
        field(13; "Home Phone Number"; Text[30])
        {
            Caption = 'Home Phone Number';
        }
        field(14; "Cellular Phone Number"; Text[30])
        {
            Caption = 'Cellular Phone Number';
        }
        field(15; "Work Phone Number"; Text[30])
        {
            Caption = 'Work Phone Number';
        }
        field(16; "Ext."; Text[7])
        {
            Caption = 'Ext.';
        }
        field(17; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            trigger OnValidate()
            begin
                Mail.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(19; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(20; "ID Number"; Text[30])
        {
            Caption = 'ID Number';
            trigger OnValidate()
            begin
                if (strlen("ID Number") < 7) or (strlen("ID Number") > 10) then
                    Error('ID Number can not be less than 7 and more than 10 characters');
            end;
        }
        field(21; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(22; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
            Caption = 'Country Code';
        }
        field(23; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
            Caption = 'Status';
        }
        field(24; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
            Caption = 'Comment';
        }
        field(25; "Fax Number"; Text[30])
        {
            Caption = 'Fax Number';
        }
        field(26; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Caption = 'Marital Status';
        }
        field(27; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
            Caption = 'Ethnic Origin';
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            Caption = 'First Language (R/W/S)';
        }
        field(29; "Driving Licence"; Code[10])
        {
            Caption = 'Driving Licence';
        }
        field(30; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
            Caption = 'Disabled';
        }
        field(31; "Health Assesment?"; Boolean)
        {
            Caption = 'Health Assesment?';
        }
        field(32; "Health Assesment Date"; Date)
        {
            Caption = 'Health Assesment Date';
        }
        field(33; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';

            trigger OnValidate()
            var
                HumanResSetup: Record "Human Resources Setup";
                dateform, DOBForm : DateFormula;
                RetirementDate: Date;
                DateofBirthError: Label 'This date cannot be greater than today.';
                EmployeeRetiredErr: Label 'Employee''s age is more than allowable retirement age';
                MinimumAgeError: Label 'Date of birth must not be less than %1';
            begin
                if "Date of Birth" <> 0D then begin
                    HumanResSetup.Get();
                    HumanResSetup.TestField("Retirement Age");
                    HumanResSetup.TestField("Minimum Employee Age");

                    //Validate minimum & maximum age
                    if "Date of Birth" > Today then
                        Error(DateofBirthError);

                    Evaluate(DOBForm, Format(HumanResSetup."Minimum Employee Age") + 'Y');

                    if CalcDate(DOBForm, "Date of Birth") > Today then
                        Error(MinimumAgeError, HumanResSetup."Minimum Employee Age");

                    //Validate Retirement Age
                    Evaluate(dateform, Format(HumanResSetup."Retirement Age") + 'Y');
                    RetirementDate := CalcDate(dateform, "Date of Birth");
                    if RetirementDate <= Today then
                        Error(EmployeeRetiredErr);

                    "Age" := Dates.DetermineAge("Date of Birth", Today);
                end;
            end;
        }
        field(34; Age; Text[80])
        {
            Caption = 'Age';
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            Caption = 'Second Language (R/W/S)';
        }
        field(36; "Additional Language"; Code[10])
        {
            Caption = 'Additional Language';
        }
        field(37; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            Caption = 'Primary Skills Category';
        }
        field(38; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
            Caption = 'Level';
        }
        field(39; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;
            Caption = 'Termination Category';

            trigger OnValidate()
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
            Caption = 'Postal Address2';
        }
        field(41; "Postal Address3"; Text[20])
        {
            Caption = 'Postal Address3';
        }
        field(42; "Residential Address2"; Text[30])
        {
            Caption = 'Residential Address2';
        }
        field(43; "Residential Address3"; Text[20])
        {
            Caption = 'Residential Address3';
        }
        field(44; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
            Caption = 'Post Code2';
        }
        field(45; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;
            Caption = 'Citizenship';
        }
        field(46; "Disabling Details"; Text[50])
        {
            Caption = 'Disabling Details';
        }
        field(47; "Disability Grade"; Text[30])
        {
            Caption = 'Disability Grade';
        }
        field(48; "Passport Number"; Text[30])
        {
            Caption = 'Passport Number';
        }
        field(49; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            Caption = '2nd Skills Category';
        }
        field(50; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            Caption = '3rd Skills Category';
        }
        field(51; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            Caption = 'Region';
        }
        field(52; "First Language Read"; Boolean)
        {
            Caption = 'First Language Read';
        }
        field(53; "First Language Write"; Boolean)
        {
            Caption = 'First Language Write';
        }
        field(54; "First Language Speak"; Boolean)
        {
            Caption = 'First Language Speak';
        }
        field(55; "Second Language Read"; Boolean)
        {
            Caption = 'Second Language Read';
        }
        field(56; "Second Language Write"; Boolean)
        {
            Caption = 'Second Language Write';
        }
        field(57; "Second Language Speak"; Boolean)
        {
            Caption = 'Second Language Speak';
        }
        field(58; "PIN Number"; Code[20])
        {
            Caption = 'PIN Number';
        }
        field(59; "Job Applied For"; Code[20])
        {
            Editable = true;
            TableRelation = "Company Job";
            Caption = 'Job Applied For';

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange("Job ID", "Job Applied For");
                if Jobs.Find('-') then begin
                    "Job Description" := Jobs."Job Description";
                    Practical := Jobs.Practical;
                    Classroom := Jobs.Classroom;
                    "Oral (Board)" := Jobs."Oral Interview (Board)";
                    Oral := Jobs."Oral Interview";
                end;
            end;
        }
        field(61; "Total Score"; Decimal)
        {
            CalcFormula = sum("Applicants Qualification".Score where(No = field("No.")));
            FieldClass = FlowField;
            Caption = 'Total Score';
        }
        field(62; Shortlist; Boolean)
        {
            Caption = 'Shortlist';
        }
        field(63; Employ; Boolean)
        {
            Caption = 'Employ';

            trigger OnValidate()
            begin

                if Jobs.Get("Job Applied For") then begin
                    Oral := Jobs."Oral Interview";
                    "Oral (Board)" := Jobs."Oral Interview (Board)";
                    Classroom := Jobs.Classroom;
                    Practical := Jobs.Practical;
                    Modify();
                end;
            end;
        }
        field(64; Stage; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Stage';
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if "Applicant Type" = "Applicant Type"::External then
                    "Employee No" := '' else begin


                    Employee.Reset();
                    Employee.SetRange(Employee."No.", "Employee No");
                    if Employee.Find('-') then begin
                        "First Name" := Employee."First Name";
                        "Middle Name" := Employee."Middle Name";
                        "Last Name" := Employee."Last Name";
                        //Initials:=Employee.Initials;
                        //"Search Name":=Employee."Search Name";
                        "Postal Address" := Employee.Address;
                        //"Residential Address":=Employee."Residential Address";
                        City := Employee.City;
                        "Post Code" := Employee."Post Code";
                        County := Employee.County;
                        "Home Phone Number" := Employee."Phone No.";
                        "Cellular Phone Number" := Employee."Mobile Phone No.";
                        //"Work Phone Number":=Employee."Work Phone Number";
                        "Ext." := Employee.Extension;
                        "E-Mail" := Employee."E-Mail";
                        "ID Number" := Employee."ID No.";
                        Gender := Employee.Gender;
                        "Country Code" := Employee."Country/Region Code";
                        "Fax Number" := Employee."Fax No.";
                        "Marital Status" := Employee."Marital Status";
                        "Ethnic Origin" := Employee."Ethnic Origin";
                        "First Language (R/W/S)" := Employee."First Language (R/W/S)";
                        "Driving Licence" := Employee."Driving Licence";
                        //Disabled:=Employee.Disabled;
                        //"Health Assesment?":=Employee."Health Assesment?";
                        //"Health Assesment Date":=Employee."Health Assesment Date";
                        "Date Of Birth" := Employee."Birth Date";
                        //Age:=Employee.Age;
                        "Second Language (R/W/S)" := Employee."Second Language (R/W/S)";
                        "Additional Language" := Employee."Additional Language";
                        //"Postal Address2":=Employee."Postal Address2";
                        //"Postal Address3":=Employee."Postal Address3";
                        //"Residential Address2":=Employee."Residential Address2";
                        //"Residential Address3":=Employee."Residential Address3";
                        //"Post Code2":=Employee."Post Code2";
                        //Citizenship:=Employee.Citizenship;
                        //"Passport Number":=Employee."Passport Number";
                        "First Language Read" := Employee."First Language Read";
                        "First Language Write" := Employee."First Language Write";
                        "First Language Speak" := Employee."First Language Speak";
                        "Second Language Read" := Employee."Second Language Read";
                        "Second Language Write" := Employee."Second Language Write";
                        "Second Language Speak" := Employee."Second Language Speak";
                        "PIN Number" := Employee."PIN Number";
                        //"Country Code":=Employee."Country Code";

                        //"Applicant Type":="Applicant Type"::Internal;

                        EmpQualifications.Reset();
                        EmpQualifications.SetRange(EmpQualifications."Employee No.", Employee."No.");
                        if EmpQualifications.Find('-') then
                            repeat
                                AppQualifications."Employee No." := "No.";
                                //AppQualifications."Qualification Type":=EmpQualifications."Qualification Type";
                                AppQualifications."Qualification Code" := EmpQualifications."Qualification Code";
                                AppQualifications."From Date" := EmpQualifications."From Date";
                                AppQualifications."To Date" := EmpQualifications."To Date";
                                AppQualifications.Type := EmpQualifications.Type;
                                AppQualifications.Description := EmpQualifications.Description;
                                AppQualifications.Institution_Company := EmpQualifications."Institution/Company";
                                //AppQualifications.CourseType:=EmpQualifications.CourseType;
                                //AppQualifications.Score:=EmpQualifications.Grade;
                                AppQualifications.Comment := EmpQualifications.Comment;
                                AppQualifications.Insert(true);

                            until EmpQualifications.Next() = 0
                    end
                end;
            end;
        }
        field(67; "Applicant Type"; Option)
        {
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
            Caption = 'Applicant Type';

            trigger OnValidate()
            begin

                if "Applicant Type" = "Applicant Type"::External then
                    "Employee No" := '';
            end;
        }
        field(68; "Application Date"; Date)
        {
            Caption = 'Application Date';
            trigger OnValidate()
            begin
                if "Application Date" > Today then
                    Error('Date can not be in the future');
            end;
        }
        field(69; "Job Description"; Text[200])
        {
            Editable = false;
            Caption = 'Job Description';
        }
        field(70; "Interview Score"; Decimal)
        {
            CalcFormula = average("Interview Stage"."Marks Awarded" where("Applicant No" = field("No.")));
            FieldClass = FlowField;
            Caption = 'Interview Score';
        }
        field(71; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(72; "Applicant Status"; Enum "Job Applicant Status")
        {
            Caption = 'Applicant Status';
        }
        field(73; "Not Under Notice"; Boolean)
        {
            Caption = 'Not Under Notice';
        }
        field(74; Hobbies; Text[200])
        {
            Caption = 'Hobbies';
        }
        field(75; Notified; Boolean)
        {
            Caption = 'Notified';

            trigger OnValidate()
            begin

                //IF Notified THEN
                //BEGIN
                if CompanyJob.Get("Job Applied For") then
                    Oral := CompanyJob."Oral Interview";
                "Oral (Board)" := CompanyJob."Oral Interview (Board)";
                Classroom := CompanyJob.Classroom;
                Practical := CompanyJob.Practical;
                Modify();
                // END;
            end;
        }
        field(76; Submitted; Boolean)
        {
            Caption = 'Submitted';
        }
        field(77; Interviewed; Boolean)
        {
            Caption = 'Interviewed';
        }
        field(78; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
        field(79; Selected; Boolean)
        {
            Caption = 'Selected';
        }
        field(80; "Interview Date"; Date)
        {
            Caption = 'Interview Date';
            trigger OnValidate()
            begin
                if "Interview Date" > Today() then
                    Error('Date can not be in the future');
            end;
        }
        field(81; "Interview Time"; Time)
        {
            Caption = 'Interview Time';
        }
        field(82; "Expected Reporting Date"; Date)
        {
            Caption = 'Expected Reporting Date';
        }
        field(83; Oral; Boolean)
        {
            Caption = 'Oral';
        }
        field(84; "Oral (Board)"; Boolean)
        {
            Caption = 'Oral (Board)';
        }
        field(85; Practical; Boolean)
        {
            Caption = 'Practical';
        }
        field(86; Classroom; Boolean)
        {
            Caption = 'Classroom';
        }
        field(87; "Practical Score"; Decimal)
        {
            CalcFormula = average("Interview Stage"."Marks Awarded" where("Applicant No" = field("No."), "Interview Type" = const(Practical)));
            FieldClass = FlowField;
            Caption = 'Practical Score';
            Editable = false;
        }
        field(88; "Classroom Score"; Decimal)
        {
            CalcFormula = average("Classroom Interview".Score where("Applicant No" = field("No.")));
            FieldClass = FlowField;
            Caption = 'Classroom Score';
        }
        field(89; "Oral Score"; Decimal)
        {
            CalcFormula = average("Interview Stage"."Marks Awarded" where("Applicant No" = field("No."), "Interview Type" = const(Oral)));
            FieldClass = FlowField;
            Caption = 'Oral Score';
            Editable = false;
        }
        field(90; "Oral (Board) Score"; Decimal)
        {
            CalcFormula = average("Oral Interview (Board)".Score where("Applicant No" = field("No.")));
            FieldClass = FlowField;
            Caption = 'Oral (Board) Score';
        }
        field(91; "Applicant Remarks"; Text[1024])
        {
            Caption = 'Why do you think you are qualified for this job?';
        }
        field(92; "Current Gross Salary"; Decimal)
        {
            Caption = 'Current Gross Salary';
        }
        field(93; "Expected Gross Salary"; Decimal)
        {
            Caption = 'Expected Gross Salary';
        }
        field(94; "Full Name"; Text[100])
        {
            Editable = false;
            Caption = 'Full Name';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Full Name")
        {
        }
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Applicants Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Application Date" := Today;
        end;
    end;

    var
        AppQualifications: Record "Applicants Qualification";
        CompanyJob: Record "Company Job";
        Jobs: Record "Company Job";
        Employee: Record Employee;
        EmpQualifications: Record "Employee Qualification";
        HRSetup: Record "Human Resources Setup";
        Dates: Codeunit "Dates Management";
        Mail: Codeunit "Mail Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    procedure GetFullName(): Text[100]
    begin
        Clear("Full Name");

        if "Middle Name" = '' then
            "Full Name" := ("First Name" + ' ' + "Last Name");

        "Full Name" := ("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}





