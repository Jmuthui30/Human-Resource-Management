table 52015 "Employee Appraisal"
{
    DrillDownPageId = "Applicants List";
    LookupPageId = "Applicants List";
    DataClassification = CustomerContent;
    Caption = 'Employee Appraisal';
    fields
    {
        field(1; "Appraisal No"; Code[20])
        {
            Caption = 'Appraisal No';
        }
        field(2; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Appraisee Name" := Employee.FullName();
                    "Appraisee's Job Title" := Employee."Job Position Title";
                    "Job Group" := Employee."Salary Scale";
                    "Appraisee ID" := Employee."User ID";
                end;
            end;
        }
        field(3; "Appraisal Type"; Code[20])
        {
            Caption = 'Appraisal Type';
            trigger OnValidate()
            begin
                /*
                AppraisalFormat.RESET;
                //AppraisalFormat.SETRANGE(Type,"Appraisal Type");
                IF AppraisalFormat.FIND('-') THEN
                    REPEAT
                        AppraisalLines.INIT;
                        AppraisalLines."Appraisal No":="Appraisal No";
                        AppraisalLines."Employee No":="Employee No";
                        AppraisalLines."Appraisal Type":="Appraisal Type";
                        AppraisalLines."Appraisal Period":="Appraisal Period";
                        //AppraisalLines.Description:=AppraisalFormat.Value;
                        AppraisalLines."Line No":=AppraisalLines."Line No"+1000;
                        //AppraisalLines."Appraisal Heading Type":=AppraisalFormat."Appraisal Heading Type";
                        AppraisalLines."Appraisal Header":=AppraisalFormat."Appraisal Header";
                        AppraisalLines.Bold:=AppraisalFormat.Bold;
                    IF NOT AppraisalLines.GET(AppraisalLines."Appraisal No",AppraisalLines."Line No") THEN
                        AppraisalLines.INSERT;
                    UNTIL AppraisalFormat.NEXT=0;
                */
            end;

        }
        field(4; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Periods".Period where(Active = const(true));
            Caption = 'Appraisal Period';

            trigger OnValidate()
            begin
                EmpAppraisal.Reset();
                EmpAppraisal.SetRange("Employee No", "Employee No");
                EmpAppraisal.SetRange("Appraisal Period", "Appraisal Period");
                if EmpAppraisal.Find('-') then
                    Error(Error001, "Appraisal Period");

                if AppraisalPeriods.Get("Appraisal Period") then begin
                    AppraisalPeriods.TestField("Start Date");
                    AppraisalPeriods.TestField("End Date");
                    "Period Start" := AppraisalPeriods."Start Date";
                    "Period End" := AppraisalPeriods."End Date";
                    AppraisalType := AppraisalPeriods."Appraisal Type";
                end;
            end;
        }
        field(5; "No. Supervised (Directly)"; Integer)
        {
            Caption = 'No. Supervised (Directly)';
        }
        field(6; "No. Supervised (In-Directly)"; Integer)
        {
            Caption = 'No. Supervised (In-Directly)';
        }
        field(7; "Job ID"; Code[30])
        {
            Caption = 'Job ID';
        }
        field(8; "Agreement With Rating"; Option)
        {
            OptionMembers = Entirely,Mostly,"To some extent","Not at all";
            Caption = 'Agreement With Rating';
        }
        field(9; "General Comments"; Text[250])
        {
            Caption = 'General Comments';
        }
        field(10; Date; Date)
        {
            Caption = 'Date';
        }
        field(11; Rating; Decimal)
        {
            CalcFormula = sum("Appraisal Lines".Rating where("Appraisal No" = field("Appraisal No")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
            Caption = 'Rating';

            trigger OnValidate()
            begin
                /*
                CALCFIELDS(Rating);
                Grades.RESET;
                Grades.SETRANGE(Points,Rating);
                IF Grades.FIND('-') THEN
                  BEGIN
                    "Rating Description":=Grades.Rating;
                  END;
                */

            end;
        }
        field(12; "Rating Description"; Text[150])
        {
            Caption = 'Rating Description';
        }
        field(13; "Appraiser No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Appraiser No / Reporting To';

            trigger OnValidate()
            begin
                if "Employee No" = "Appraiser No" then
                    Error('You can not appraise yourself');

                if Employee.Get("Appraiser No") then begin
                    "Appraisers Name" := Employee.FullName();
                    "Appraiser's Job Title" := Employee."Job Position Title";
                    "Appraiser ID" := Employee."User ID";
                end;
            end;
        }
        field(14; "Appraisers Name"; Text[50])
        {
            Caption = 'Appraisers Name';
        }
        field(15; "Appraisee ID"; Code[30])
        {
            Caption = 'Appraisee ID';
        }
        field(16; "Appraiser ID"; Code[30])
        {
            Caption = 'Appraiser ID';
        }
        field(17; "Appraisee Name"; Text[50])
        {
            Caption = 'Appraisee Name';
        }
        field(18; "Job Group"; Code[10])
        {
            Caption = 'Job Group';
        }
        field(19; "Appraiser's Job Title"; Text[50])
        {
            Caption = 'Appraiser''s Job Title';
        }
        field(20; "Appraisee's Job Title"; Text[50])
        {
            Caption = 'Appraisee''s Job Title';
        }
        field(21; "No. series"; Code[10])
        {
            Caption = 'No. series';
        }
        field(27; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Pending Comments Approval,Completed,Mid-Year Approval';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,"Pending Comments Approval",Completed,"Mid-Year Approved";
            Caption = 'Status';
        }
        field(28; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(29; "Period Start"; Date)
        {
            Caption = 'Period Start';
        }
        field(30; "Period End"; Date)
        {
            Caption = 'Period End';
        }
        field(31; "Target Score"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines".Rating where("Appraisal No" = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Target Score';
        }
        field(32; "Target Avg"; Decimal)
        {
            CalcFormula = average("Appraisal Lines".Rating where("Appraisal No" = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Target Avg';
        }
        field(33; "Appraisal Status"; Option)
        {
            OptionCaption = 'Setting,Set,Review,Further review,Completed';
            OptionMembers = Setting,Set,Review,"Further review",Completed;
            Caption = 'Appraisal Status';
        }
        field(34; "Values Total"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Value/Core Competence" = const(Values),
                                                                   "Appraisal No." = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Values Total';
        }
        field(35; "Values Mean"; Decimal)
        {
            Caption = 'Values Mean';
        }
        field(36; "Competences Total"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Value/Core Competence" = const("Core Competences"),
                                                                   "Appraisal No." = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Competences Total';
        }
        field(37; "Competences Mean"; Decimal)
        {
            Caption = 'Competences Mean';
        }
        field(38; "Curriculum Total"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Value/Core Competence" = const("Curriculum Delivery"),
                                                                   "Appraisal No." = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Curriculum Total';
        }
        field(39; "Curriculum Mean"; Decimal)
        {
            Caption = 'Curriculum Mean';
        }
        field(40; "Research Total"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Value/Core Competence" = const(Research),
                                                                   "Appraisal No." = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Research Total';
        }
        field(41; "Research Mean"; Decimal)
        {
            Caption = 'Research Mean';
        }
        field(42; "Initiative Total"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Value/Core Competence" = const("Initiative & Willingness"),
                                                                   "Appraisal No." = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Initiative Total';
        }
        field(43; "Initiative Mean"; Decimal)
        {
            Caption = 'Initiative Mean';
        }
        field(44; "Managerial Total"; Decimal)
        {
            CalcFormula = sum("Appraisal Competences".Score where("Value/Core Competence" = const("Managerial & Supervisory"),
                                                                   "Appraisal No." = field("Appraisal No")));
            FieldClass = FlowField;
            Caption = 'Managerial Total';
        }
        field(45; "Managerial  Mean"; Decimal)
        {
            Caption = 'Managerial  Mean';
        }
        field(46; "Total Weighting"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines".Weighting where("Appraisal No" = field("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Weighting';

        }
        field(47; "Total Mid-Year"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines"."Mid-Year Appraisal" where("Appraisal No" = field("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Mid-Year';
        }
        field(48; "Total Final Self"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines"."Final Self-Appraisal" where("Appraisal No" = field("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Final Self';
        }
        field(50; "Appraisal Type Description"; Text[150])
        {
            CalcFormula = lookup("Appraisal Type".Description where(Code = field("Appraisal Type")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Appraisal Type Description';
        }
        field(51; "Responsibilty Center"; Code[20])
        {
            CalcFormula = lookup(Employee."Responsibility Center" where("No." = field("Employee No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Responsibilty Center';
        }
        field(52; Type; Option)
        {
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ","Mid-Year","Final Year";
            Caption = 'Type';
        }
        field(53; "AppraisalType"; Option)
        {
            Caption = 'Appraisal Type';
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ","Mid-Year","Final Year";
        }
        field(55; "Grade-Attributes"; Text[50])
        {
            Caption = 'Perfomance grade';
            Editable = false;
        }
        field(56; "Total Percentage-Attributes"; Decimal)
        {
            Caption = 'Total percentage score';
            //CalcFormula = Sum("Appraisal - attributes".Rating WHERE("Appraisal No." = FIELD("Appraisal No")));
            Editable = false;
            //FieldClass = FlowField;
            trigger OnValidate()
            begin
                Matrix.Reset();
                Matrix.SetFilter(Start, '<=%1', "Total Percentage-Attributes");
                Matrix.SetFilter("End", '>=%1', "Total Percentage-Attributes");
                if Matrix.FindFirst() then
                    "Grade-Attributes" := Matrix.Grade;
            end;
        }
        field(58; "Total Percentage FY Rating"; Decimal)
        {
            Caption = 'Total percentage score';
            //CalcFormula = Sum("Appraisal - attributes".Rating WHERE("Appraisal No." = FIELD("Appraisal No")));
            Editable = false;
            //FieldClass = FlowField;
            trigger OnValidate()
            begin
                Matrix.Reset();
                Matrix.SetFilter(Start, '<=%1', "Total Percentage FY Rating");
                Matrix.SetFilter("End", '>=%1', "Total Percentage FY Rating");
                if Matrix.FindFirst() then
                    "Grade final year rating" := Matrix.Grade;
            end;
        }
        field(59; "Grade final year rating"; Text[50])
        {
            Caption = 'Perfomance grade';
            Editable = false;
        }
        field(60; "Total score"; Decimal)
        {
            Editable = false;
            Caption = 'Total score';
        }
        field(61; "Total FY Rating"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines".Rating where("Appraisal No" = field("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total FY Rating';
        }
        field(62; "Total FY Attributes"; Decimal)
        {
            Caption = 'Total rating';
            CalcFormula = sum("Appraisal - attributes".Rating where("Appraisal No." = field("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Expected TR -attributes"; Decimal)
        {
            CalcFormula = sum("Appraisal - attributes"."Expected rating attributes" where("Appraisal No." = field("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Expected TR -attributes';
        }
        field(64; "Appraisee Agreed"; Boolean)
        {
            Caption = 'Appraisee Agreed';
            DataClassification = ToBeClassified;
        }
        field(65; "Appraiser Agreed"; Boolean)
        {
            Caption = 'Appraiser Agreed';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Appraisal No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Appraisal Nos");
            NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos", xRec."No. series", 0D, "Appraisal No", "No. series");
        end;

        Date := Today;

        "Appraisee ID" := UserId;

        /*Employee.SETRANGE("User ID","Appraiser ID");
         IF Employee.FINDFIRST THEN
           BEGIN
             "Appraiser No":=Employee."No.";
             "Appraiser's Job Title":=Employee."Job Title";
             "Appraisers Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
            END;*/


        if UserSetup.Get(UserId) then begin
            "Appraisee ID" := UserSetup."User ID";
            "Appraiser ID" := UserSetup."Approver ID";
            //"Department Code":=UserSetup."Responsibility Center";
            if Employee.Get(UserSetup."Employee No.") then begin
                "Employee No" := Employee."No.";
                "Appraisee Name" := Employee.FullName();
                "Job Group" := Employee."Salary Scale";
                "Appraisee's Job Title" := Employee."Job Position Title";
                Employee.TestField("Responsibility Center");
                //"Department Code":=Employee."Global Dimension 1 Code";

                /*AppraisalType.RESET;
                IF AppraisalType.FIND('-') THEN
                  REPEAT
                    IF ((Employee."Salary Scale">=AppraisalType."Minimum Job Group") AND (Employee."Salary Scale"<=AppraisalType."Maximum Job Group")) THEN
                      BEGIN
                        "Appraisal Type":=AppraisalType.Code;
                        VALIDATE("Appraisal Type");
                      END;
                  UNTIL AppraisalType.NEXT=0;*/
                if UserSetup.Get(UserSetup."Approver ID") then
                    if Employee.Get(UserSetup."Employee No.") then begin
                        "Appraiser No" := Employee."No.";
                        "Appraisers Name" := Employee.FullName();
                        "Appraiser's Job Title" := Employee."Job Position Title";
                    end;
            end;


            //Insert Workplan Codes
            CalcFields("Responsibilty Center");
            AppraisalWorkplanCodes.Reset();
            AppraisalWorkplanCodes.SetRange("Responsibility Center", "Responsibilty Center");
            if AppraisalWorkplanCodes.FindSet() then
                repeat
                    AppraisalLines.Init();
                    AppraisalLines."Appraisal No" := "Appraisal No";
                    AppraisalLines."Line No" := LineNo;
                    AppraisalLines.Validate("Workplan Code", AppraisalWorkplanCodes.Code);
                    //AppraisalLines."Initiative code";
                    AppraisalLines.Insert();
                    LineNo += 10000;
                until AppraisalWorkplanCodes.Next() = 0;
        end;

    end;

    var
        AppraisalLines: Record "Appraisal Lines";
        AppraisalPeriods: Record "Appraisal Periods";
        AppraisalWorkplanCodes: Record "Appraisal Workplan Code";
        Employee: Record Employee;
        EmpAppraisal: Record "Employee Appraisal";
        HRSetup: Record "Human Resources Setup";
        Matrix: Record "Perfomance rating matrix";
        UserSetup: Record "User Setup";
        //AppraisalType: Record "Appraisal Type";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        Error001: Label 'You have already created an appraisal for %1';
}













