table 52049 "Stage Shortlist"
{
    DataClassification = CustomerContent;
    Caption = 'Stage Shortlist';
    fields
    {
        field(1; "Need Code"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "Recruitment Needs"."No.";
            Caption = 'Need Code';
        }
        field(2; "Stage Code"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            Caption = 'Stage Code';
        }
        field(3; Applicant; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = Applicants."No.";
            Caption = 'Applicant';
        }
        field(4; "Stage Score"; Decimal)
        {
            Editable = false;
            Caption = 'Stage Score';
        }
        field(5; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
        field(6; "First Name"; Text[100])
        {
            Editable = false;
            Caption = 'First Name';
        }
        field(7; "Middle Name"; Text[100])
        {
            Editable = false;
            Caption = 'Middle Name';
        }
        field(8; "Last Name"; Text[100])
        {
            Editable = false;
            Caption = 'Last Name';
        }
        field(9; "ID No"; Text[100])
        {
            Editable = false;
            Caption = 'ID No';
        }
        field(10; Gender; Enum "Employee Gender")
        {
            Editable = false;
            Caption = 'Gender';
        }
        field(11; "Marital Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Caption = 'Marital Status';
        }
        field(12; "Manual Change"; Boolean)
        {
            Editable = false;
            Caption = 'Manual Change';
        }
        field(13; Employ; Boolean)
        {
            Caption = 'Employ';

            trigger OnValidate()
            begin
                if Employ then begin
                    RNeeds.Reset();
                    RNeeds.SetFilter(RNeeds."No.", "Need Code");
                    if RNeeds.Find('-') then begin
                        if RNeeds.Positions = 1 then begin
                            RNeeds."End Date" := Today;
                            RNeeds.Modify();
                            if RNeeds."Start Date" <> 0D then begin
                                RNeeds."Turn Around Time" := RNeeds."End Date" - RNeeds."Start Date";
                                RNeeds.Modify();
                            end;
                        end;
                        if RNeeds.Positions > 0 then begin
                            RNeeds.Positions := RNeeds.Positions - 1;
                            RNeeds.Modify();
                        end;
                    end;
                    Date := Today;
                    Applicants.Reset();
                    Applicants.SetRange(Applicants."No.", Applicant);
                    if Applicants.Find('-') then
                        if Applicants."Applicant Type" = Applicants."Applicant Type"::External then begin
                            ;
                            Employee."No." := '';
                            Employee."First Name" := Applicants."First Name";
                            Employee."Middle Name" := Applicants."Middle Name";
                            Employee."Last Name" := Applicants."Last Name";
                            Employee.Initials := Applicants.Initials;
                            Employee."Search Name" := Applicants."Search Name";
                            Employee.Address := Applicants."Postal Address";
                            //Employee."Residential Address":=Applicants."Residential Address";
                            Employee.City := Applicants.City;
                            Employee."Post Code" := Applicants."Post Code";
                            Employee.County := Applicants.County;
                            Employee."Phone No." := Applicants."Home Phone Number";
                            Employee."Mobile Phone No." := Applicants."Cellular Phone Number";
                            //Employee."Work Phone Number":=Applicants."Work Phone Number";
                            Employee.Extension := Applicants."Ext.";
                            Employee."E-Mail" := Applicants."E-Mail";
                            //Employee."Total Savings":=Applicants."ID Number";
                            Employee.Gender := Applicants.Gender;
                            Employee."Country/Region Code" := Applicants."Country Code";
                            Employee."Fax No." := Applicants."Fax Number";
                            Employee."Marital Status" := Applicants."Marital Status";
                            Employee."Ethnic Origin" := Applicants."Ethnic Origin";
                            Employee."First Language (R/W/S)" := Applicants."First Language (R/W/S)";
                            Employee."Driving Licence" := Applicants."Driving Licence";
                            //Employee.Disabled:=Applicants.Disabled;
                            //Employee."Health Assesment?":=Applicants."Health Assesment?";
                            //Employee."Health Assesment Date":=Applicants."Health Assesment Date";
                            Employee."Birth Date" := Applicants."Date Of Birth";
                            //Employee.Age:=Applicants.Age;
                            Employee."Second Language (R/W/S)" := Applicants."Second Language (R/W/S)";
                            Employee."Additional Language" := Applicants."Additional Language";
                            //Employee."Postal Address2":=Applicants."Postal Address2";
                            //Employee."Postal Address3":=Applicants."Postal Address3";
                            //Employee."Residential Address2":=Applicants."Residential Address2";
                            //Employee."Residential Address3":=Applicants."Residential Address3";
                            //Employee."Post Code2":=Applicants."Post Code2";
                            //Employee.Citizenship:=Applicants.Citizenship;
                            Employee."Passport Number" := Applicants."Passport Number";
                            Employee."First Language Read" := Applicants."First Language Read";
                            Employee."First Language Write" := Applicants."First Language Write";
                            Employee."First Language Speak" := Applicants."First Language Speak";
                            Employee."Second Language Read" := Applicants."Second Language Read";
                            Employee."Second Language Write" := Applicants."Second Language Write";
                            Employee."Second Language Speak" := Applicants."Second Language Speak";
                            Employee."PIN Number" := Applicants."PIN Number";
                            Employee.Position := Applicants."Job Applied For";
                            Employee."Country/Region Code" := Applicants."Country Code";
                            Employee.Insert(true);

                            Applicants.Employ := true;
                            Applicants.Modify();

                            AppQualifications.Reset();
                            AppQualifications.SetRange(AppQualifications."Employee No.", Applicant);
                            if AppQualifications.Find('-') then
                                repeat
                                    EmpQualifications.Init();
                                    EmpQualifications."Employee No." := Employee."No.";
                                    EmpQualifications."Line No." := EmpQualifications."Line No." + 10000;
                                    //EmpQualifications."Qualification Type":=AppQualifications."Qualification Type";
                                    EmpQualifications."Qualification Code" := AppQualifications."Qualification Code";
                                    EmpQualifications."From Date" := AppQualifications."From Date";

                                    EmpQualifications."To Date" := AppQualifications."To Date";
                                    EmpQualifications.Type := AppQualifications.Type;
                                    EmpQualifications.Description := AppQualifications.Description;
                                    EmpQualifications."Institution/Company" := AppQualifications.Institution_Company;
                                    //EmpQualifications.CourseType:=AppQualifications.Qualification;
                                    //EmpQualifications.Grade:=AppQualifications."Course Grade";
                                    EmpQualifications.Comment := AppQualifications.Comment;
                                    EmpQualifications.Validate(EmpQualifications."Qualification Code");

                                    EmpQualifications.Insert();

                                until AppQualifications.Next() = 0
                        end
                        else begin
                            Employee.Reset();
                            Employee.SetRange(Employee."No.", Applicants."Employee No");
                            if Employee.Find('-') then begin
                                Employee.Position := Applicants."Job Applied For";
                                Employee.Modify();
                            end
                        end
                end
            end;
        }
        field(14; Date; Date)
        {
            Caption = 'Date';
        }
        field(15; Position; Integer)
        {
            Caption = 'Position';
        }
        field(16; "Reporting Date"; Date)
        {
            Caption = 'Reporting Date';
        }
    }

    keys
    {
        key(Key1; "Need Code", "Stage Code", Applicant)
        {
            Clustered = true;
        }
        key(Key2; "Stage Score")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Applicants: Record Applicants;
        AppQualifications: Record "Applicants Qualification";
        Employee: Record Employee;
        EmpQualifications: Record "Employee Qualification";
        RNeeds: Record "Recruitment Needs";
}





