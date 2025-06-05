table 52072 "Employee Change Request"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Change Request';
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[60])
        {
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                /*
                if "Search Name" = '' then
                  "Search Name" := SetSearchNameToFullnameAndInitials;
                */

            end;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                /*
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GuiAllowed);
                  if PostCode.Get(PostCode.Code) then
                    begin
                      City:=PostCode."Search City";
                    end;
                */

            end;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code where("Employee No." = field("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Date of Birth"; Date)
        {
            Caption = 'Birth Date';

            trigger OnValidate()
            var
                HumanResSetup: Record "Human Resources Setup";
                HRDates: Codeunit "Dates Management";
                dateform: DateFormula;
                DOBForm: DateFormula;
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
                    "Retirement Date" := CalcDate(dateform, "Date of Birth");
                    if "Retirement Date" <= Today then
                        Error(EmployeeRetiredErr);

                    "Date of Birth - Age" := HRDates.DetermineAge("Date of Birth", Today);
                end;

            end;
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            TableRelation = Union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';

            trigger OnValidate()
            begin
                //"Employment Date - Age":=HRDates.DetermineAge("Employment Date",TODAY);
            end;
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Dormant,Probation,Terminated,Retired,Deceased';
            OptionMembers = Active,Dormant,Probation,Terminated,Retired,Deceased;

            trigger OnValidate()
            begin
                // EmployeeQualification.SETRANGE("Employee No.","No.");
                // EmployeeQualification.MODIFYALL("Employee Status",Status);
                // MODIFY;
            end;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Global Dimension 1 Code';

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Global Dimension 2 Code';

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource where(Type = const(Person));

            trigger OnValidate()
            begin
                /*
                if ("Resource No." <> '') and Res.WritePermission then
                  EmployeeResUpdate.ResUpdate(Rec)
                */

            end;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const(Employee),
                                                                     "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(45; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = sum("Employee Absence"."Quantity (Base)" where("Employee No." = field("No."),
                                                                          "Cause of Absence Code" = field("Cause of Absence Filter"),
                                                                          "From Date" = field("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Company E-Mail");
            end;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(55; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(56; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
            TableRelation = "Bank Branches" where("Bank Code" = field("Employee's Bank"));
        }
        field(57; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(58; IBAN; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(59; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Employee Ledger Entry".Amount where("Employee No." = field("No."),
                                                                              "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                              "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                              "Posting Date" = field("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(61; "Bank Code"; Code[20])
        {
            TableRelation = Banks.Code;
            Caption = 'Bank Code';
        }
        field(62; "ID No."; Code[20])
        {
            Caption = 'ID No.';
        }
        field(63; "Passport No."; Code[20])
        {
            Caption = 'Passport No.';
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(81; "Date of Birth - Age"; Text[50])
        {
            Editable = false;
            Caption = 'Date of Birth - Age';
        }
        field(82; Password; Code[20])
        {
            ExtendedDatatype = Masked;
            Caption = 'Password';
        }
        field(83; "Nature of Employment"; Text[50])
        {
            TableRelation = "Employment Contract".Code;
            Caption = 'Nature of Employment';

            trigger OnValidate()
            begin
                /*
                if EmpContract.Get("Nature of Employment") then
                 "Employee Type":=EmpContract."Employee Type"
                 */

            end;
        }
        field(84; "Contract Start Date"; Date)
        {
            Caption = 'Contract Start Date';

            trigger OnValidate()
            begin
                /*
                ContractPeriod:=CalcDate("Contract Length","Contract Start Date");
                "Contract End Date":=ContractPeriod;
                */

            end;
        }
        field(85; "Contract End Date"; Date)
        {
            Editable = false;
            Caption = 'Contract End Date';
        }
        field(86; "Employment Date - Age"; Text[50])
        {
            Editable = false;
            Caption = 'Employment Date - Age';
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(153; "First Language"; Code[20])
        {
            Caption = 'First Language';
        }
        field(154; "Second Language"; Code[20])
        {
            Caption = 'Second Language';
        }
        field(155; "First Language Read"; Boolean)
        {
            Caption = 'First Language Read';
        }
        field(156; "First Language Write"; Boolean)
        {
            Caption = 'First Language Write';
        }
        field(157; "First Language Speak"; Boolean)
        {
            Caption = 'First Language Speak';
        }
        field(158; "Second Language Read"; Boolean)
        {
            Caption = 'Second Language Read';
        }
        field(159; "Second Language Write"; Boolean)
        {
            Caption = 'Second Language Write';
        }
        field(160; "Second Language Speak"; Boolean)
        {
            Caption = 'Second Language Speak';
        }
        field(161; "Other Language"; Code[20])
        {
            Caption = 'Other Language';
        }
        field(170; "Job Position"; Code[20])
        {
            TableRelation = "Company Job";
            Caption = 'Job Position';

            trigger OnValidate()
            begin
                /*
                if Jobs.Get("Job Position") then
                  begin
                    "Job Title":= Jobs."Job Description";
                  end;
                */

            end;
        }
        field(171; "Job Position Title"; Text[80])
        {
            Caption = 'Job Position Title';
        }
        field(180; "Annual Leave Days"; Decimal)
        {
            Caption = 'Annual Leave Days';
        }
        field(181; "Compassionate Leave Days"; Decimal)
        {
            Caption = 'Compassionate Leave Days';
        }
        field(182; "Maternity Leave Days"; Decimal)
        {
            Caption = 'Maternity Leave Days';
        }
        field(183; "Paternity Leave Days"; Decimal)
        {
            Caption = 'Paternity Leave Days';
        }
        field(184; "Sick Leave Days"; Decimal)
        {
            Caption = 'Sick Leave Days';
        }
        field(185; "Study Leave Days"; Decimal)
        {
            Caption = 'Study Leave Days';
        }
        field(186; "Other Leave Days (Total)"; Decimal)
        {
            Caption = 'Other Leave Days (Total)';
        }
        field(187; "Leave Period Filter"; Code[20])
        {
            Caption = 'Leave Period Filter';
        }
        field(188; "Leave Type Filter"; Code[20])
        {
            Caption = 'Leave Type Filter';
        }
        field(189; "Reimbursed Leave Days"; Decimal)
        {
            Caption = 'Reimbursed Leave Days';
        }
        field(190; "Cash - Leave Earned"; Decimal)
        {
            Caption = 'Cash - Leave Earned';
        }
        field(191; "Cash Per Leave Day"; Decimal)
        {
            Caption = 'Cash Per Leave Day';
        }
        field(1100; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Cost Center";
        }
        field(1101; "Cost Object Code"; Code[20])
        {
            Caption = 'Cost Object Code';
            TableRelation = "Cost Object";
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8001; Signature; MediaSet)
        {
            Caption = 'Signature';
        }
        field(8002; "Lecturer Type"; Option)
        {
            OptionCaption = ' ,Full-Time,Part-Time';
            OptionMembers = " ","Full-Time","Part-Time";
            Caption = 'Lecturer Type';
        }
        field(8003; "Lecturer Password"; Code[30])
        {
            ExtendedDatatype = Masked;
            Caption = 'Lecturer Password';
        }
        field(8004; "Is Lecturer"; Boolean)
        {
            Caption = 'Is Lecturer';
        }
        field(8005; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
        }
        field(9000; Disabled; Option)
        {
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;
            Caption = 'Disabled';
        }
        field(9002; "NSSF No."; Code[20])
        {
            Caption = 'NSSF No.';
        }
        field(50000; "Pays NSSF?"; Boolean)
        {
            Caption = 'Pays NSSF?';
        }
        field(50001; "Pays tax?"; Boolean)
        {
            Caption = 'Pays tax?';
        }
        field(50002; "Basic Pay"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Basic Salary Code" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Basic Pay';
        }
        field(50003; "Employee Nature"; Boolean)
        {
            Caption = 'Employee Nature';
        }
        field(50004; "Position TO Succeed"; Code[20])
        {
            Caption = 'Position TO Succeed';
        }
        field(50005; "Total Allowances"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  "Normal Earnings" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Allowances';
        }
        field(50006; "Taxable Allowance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Taxable = const(true),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Taxable Allowance';
        }
        field(50007; "Total Deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = filter(Deduction | Loan),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Deductions';
        }
        field(50008; "Employee's Bank"; Code[80])
        {
            TableRelation = Banks.Code;
            Caption = 'Employee''s Bank';
        }
        field(50009; "Bank Branch"; Code[50])
        {
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Employee's Bank"));
            Caption = 'Bank Branch';
        }
        field(50010; "Bank Account Number"; Code[80])
        {
            Caption = 'Bank Account Number';
        }
        field(50011; "Posting Group"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group';

            trigger OnValidate()
            begin
                /*
                if xRec."Posting Group"='PROBATION' then
                begin
                
                 if "Date Of Join"<>0D then
                 begin
                   NoofMonthsWorked:=0;
                   Nextmonth:="Date Of Join";
                   repeat
                      Nextmonth:=CalcDate('1M',Nextmonth);
                      NoofMonthsWorked:=NoofMonthsWorked+1;
                   until NoofMonthsWorked=HumanResSetup."Probation Period(Months)";
                      EndDate:=Nextmonth;
                 end;
                 if EndDate>Today then
                   Error('You cannot change status from Probation before the probation period has expired');
                end;
                */

            end;
        }
        field(50012; "Salary Scale"; Code[30])
        {
            TableRelation = "Salary Scale".Scale;
            Caption = 'Salary Scale';

            trigger OnValidate()
            begin
                /*
                if Scale.Get("Salary Scale") then
                 Halt:=Scale."Maximum Pointer";
                 */

            end;
        }
        field(50013; "Tax Deductible Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Tax Deductible" = const(true),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false)));
            FieldClass = FlowField;
            Caption = 'Tax Deductible Amount';
        }
        field(50014; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(50015; "SSF Employer to Date"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Employer Amount" where("Tax Deductible" = const(true),
                                                                             "Employee No" = field("No."),
                                                                             "Payroll Period" = field("Pay Period Filter")));
            FieldClass = FlowField;
            Caption = 'SSF Employer to Date';
        }
        field(50016; "PIN Number"; Code[20])
        {
            Caption = 'PIN Number';
        }
        field(50017; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Paye = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Cumm. PAYE';
        }
        field(50018; "NHIF No"; Code[20])
        {
            Caption = 'NHIF No';
        }
        field(50019; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(true),
                                                                  Type = const(Earning),
                                                                  Taxable = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Benefits-Non Cash';
        }
        field(50020; "Pay Mode"; Code[20])
        {
            TableRelation = "Employee Pay Modes";
            Caption = 'Pay Mode';
        }
        field(50021; "Home Savings"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Type = const(Deduction),
                                                                  "Tax Deductible" = const(true),
                                                                  Retirement = const(false)));
            FieldClass = FlowField;
            Caption = 'Home Savings';
        }
        field(50022; "Retirement Contribution"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Tax Deductible" = const(true),
                                                                  Retirement = const(true)));
            FieldClass = FlowField;
            Caption = 'Retirement Contribution';
        }
        field(50023; "Owner Occupier"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Type = const(Earning),
                                                                  "Tax Deductible" = const(true)));
            FieldClass = FlowField;
            Caption = 'Owner Occupier';
        }
        field(50024; "Total Savings"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  Type = const("Saving Scheme"),
                                                                  "Payroll Period" = field("Pay Period Filter")));
            FieldClass = FlowField;
            Caption = 'Total Savings';
        }
        field(50025; PensionNo; Code[20])
        {
            Caption = 'PensionNo';
        }
        field(50026; "Share Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  Shares = const(true)));
            Caption = 'coop skg fund';
            FieldClass = FlowField;
        }
        field(50027; "Other deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Paye = const(false)));
            FieldClass = FlowField;
            Caption = 'Other deductions';
        }
        field(50028; Interest; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Interest Amount" where("Employee No" = field("No."),
                                                                             "Payroll Period" = field("Pay Period Filter"),
                                                                             Type = filter(Deduction)));
            FieldClass = FlowField;
            Caption = 'Interest';
        }
        field(50029; "Taxable Income"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Taxable = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Taxable Income';
        }
        field(50031; Position; Code[30])
        {
            TableRelation = "Company Job";
            Caption = 'Position';

            trigger OnValidate()
            begin
                /*
                if Jobs.Get(Position) then
                    "Job Title":=Jobs."Job Description";
                
                    if ( (xRec.Position <> '') and (Position <> xRec.Position)) then begin
                        Jobs.Reset();
                        Jobs.SetRange(Jobs."Job ID",Position);
                        if Jobs.Find('-') then begin
                        "Job Title":=Jobs."Job Description";
                            {Payroll.Copy(Rec);
                            Payroll.Reset();
                            Payroll.SetRange(Payroll."No.","No.");
                            if Payroll.Find('-') then begin
                                Payroll."Salary Scheme Category":=Jobs.Category;
                                Payroll."Salary Steps":=Jobs.Grade;
                              //  Payroll.VALIDATE(Payroll."Salary Steps");
                                Payroll.Modify();
                            end;}
                            //"Salary Scheme Category":=Jobs.Category;
                            //"Salary Steps":=Jobs.Grade;
                            //MODIFY;
                        end;
                      end;
                */

            end;
        }
        field(50032; "Full / Part Time"; Option)
        {
            OptionCaption = 'Full Time, Part Time';
            OptionMembers = "Full Time"," Part Time";
            Caption = 'Full / Part Time';
        }
        field(50033; "Contract Type"; Code[30])
        {
            TableRelation = "Employment Contract".Code;
            Caption = 'Contract Type';

            trigger OnValidate()
            begin
                /*
                if "Contract Type"="Contract Type"::"Long-Term" then
                  "Contract Length"> '6M' else
                  Error('The Period is too short for the Contract Type');
                
                if "Contract Type"="Contract Type"::"Short-Term" then
                  "Contract Length"<'7M' else
                  Error('The Period is Longer than the Contract Type');
                */

            end;
        }
        field(50034; "Type of Contract"; Code[20])
        {
            TableRelation = "Employment Contract";
            Caption = 'Type of Contract';

            trigger OnValidate()
            begin
                /*
                if EmpContract.Get("Type of Contract") then
                  "Contract Length":=EmpContract.Tenure;
                */

            end;
        }
        field(50035; "Notice Period"; Code[10])
        {
            Caption = 'Notice Period';
        }
        field(50036; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Caption = 'Marital Status';
        }
        field(50037; "Ethnic Origin"; Option)
        {
            OptionCaption = 'African,Indian,White,Coloured';
            OptionMembers = African,Indian,White,Coloured;
            Caption = 'Ethnic Origin';
        }
        field(50038; "First Language (R/W/S)"; Code[20])
        {
            TableRelation = Language;
            Caption = 'First Language (R/W/S)';
        }
        field(50039; "Driving Licence"; Code[20])
        {
            Caption = 'Driving Licence';
        }
        field(50040; "KRA PIN No."; Code[15])
        {
            Caption = 'KRA PIN No.';
        }
        field(50041; "Date Of Join"; Date)
        {
            Caption = 'Date Of Join';

            trigger OnValidate()
            begin
                /*
                HumanResSetup.Get();
                HumanResSetup.TestField("Probation Period");
                "End Of Probation Date":=CalcDate(HumanResSetup."Probation Period","Date Of Join");
                */
                /*
                DateInt:=Date2DMY("Date Of Join",1);
                "Pro-Rata on Joining":=HumanResSetup."No. Of Days in Month"-DateInt+1;
                PayPeriod.Reset();
                PayPeriod.SetRange(PayPeriod."Starting Date",0D,"Date Of Join");
                PayPeriod.SetRange(PayPeriod."New Fiscal Year",true);
                if PayPeriod.Find('+') then
                begin
                FiscalStart:=PayPeriod."Starting Date";
                MaturityDate:=CalcDate('1Y',PayPeriod."Starting Date")-1;
                 Message('Maturity %1',MaturityDate)
                end;
                
                if ("Posting Group"='PERMANENT') or ("Posting Group"='DG') then begin
                //MESSAGE('Date of join %1',"Date Of Join") ;
                 Entitlement:=Round(((MaturityDate-"Date Of Join")/30),1)*2.5;
                
                EmpLeaves.Reset();
                EmpLeaves.SetRange(EmpLeaves."Employee No","No.");
                EmpLeaves.SetRange(EmpLeaves."Maturity Date",MaturityDate);
                if not EmpLeaves.Find('-') then begin
                  EmpLeaves."Employee No":="No.";
                  EmpLeaves."Leave Code":='ANNUAL';
                  EmpLeaves."Maturity Date":=MaturityDate;
                  EmpLeaves.Entitlement:=Entitlement;
                //IF NOT EmpLeaves.GET("No.",'ANNUAL',MaturityDate) THEN
                  EmpLeaves.Insert();
                end;
                
                end;
                  */

            end;
        }
        field(50042; "End Of Probation Date"; Date)
        {
            Caption = 'End Of Probation Date';
        }
        field(50045; "Pension Scheme Join"; Date)
        {
            Caption = 'Pension Scheme Join';

            trigger OnValidate()
            begin
                /*  if ("Date Of Leaving" <> 0D) and ("Pension Scheme Join" <> 0D) then
                   "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");

            */

            end;
        }
        field(50046; "Medical Scheme Join"; Date)
        {
            Caption = 'Medical Scheme Join';

            trigger OnValidate()
            begin
                /*  if  ("Date Of Leaving" <> 0D) and ("Medical Scheme Join" <> 0D) then
                   "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
                */

            end;
        }
        field(50047; "Date Of Leaving"; Date)
        {
            Caption = 'Date Of Leaving';

            trigger OnValidate()
            begin
                /* if ("Date Of Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
                 if ("Pension Scheme Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
                 if ("Medical Scheme Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");


                 if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin
                    ExitInterviews.SetRange("Employee No.","No.");
                    OK:= ExitInterviews.Find('-');
                    if OK then begin
                      ExitInterviews."Date Of Leaving":= "Date Of Leaving";
                      ExitInterviews.Modify();
                    end;
                    Commit();
                 end;


                if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin
                   CareerEvent.SetMessage('Left The Company');
                   CareerEvent.RunModal();
                   OK:= CareerEvent.ReturnResult;
                    if OK then begin
                       CareerHistory.Init();
                       if not CareerHistory.Find('-') then
                        CareerHistory."Line No.":=1
                      else begin
                        CareerHistory.Find('+');
                        CareerHistory."Line No.":=CareerHistory."Line No."+1;
                      end;

                       CareerHistory."Employee No.":= "No.";
                       CareerHistory."Date Of Event":= "Date Of Leaving";
                       CareerHistory."Career Event":= 'Left The Company';
                       CareerHistory."Employee First Name":= "Known As";
                       CareerHistory."Employee Last Name":= "Last Name";

                       CareerHistory.Insert();
                    end;
                end;
               */
                /*
                ExitInterviewTemplate.Reset();
                //TrainingEvalTemplate.SETRANGE(TrainingEvalTemplate."AIT/Evaluation",TrainingEvalTemplate."AIT/Evaluation"::AIT);
                if ExitInterviewTemplate.Find('-') then
                repeat
                ExitInterviewLines.Init();
                ExitInterviewLines."Employee No":="No.";
                ExitInterviewLines.Question:=ExitInterviewTemplate.Question;
                ExitInterviewLines."Line No":=ExitInterviewTemplate."Line No";
                ExitInterviewLines.Bold:=ExitInterviewTemplate.Bold;
                ExitInterviewLines."Answer Type":=ExitInterviewTemplate."Answer Type";
                if not ExitInterviewLines.Get(ExitInterviewLines."Line No",ExitInterviewLines."Employee No") then
                ExitInterviewLines.Insert()
                
                
                until ExitInterviewTemplate.Next()=0;
                */

            end;
        }
        field(50048; "Second Language (R/W/S)"; Code[20])
        {
            TableRelation = Language;
            Caption = 'Second Language (R/W/S)';
        }
        field(50049; "Additional Language"; Code[20])
        {
            TableRelation = Language;
            Caption = 'Additional Language';
        }
        field(50050; "Termination Category"; Option)
        {
            OptionCaption = ' ,Resignation,Non-Renewal Of Contract,Dismissal,Retirement,Death,Other';
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;
            Caption = 'Termination Category';

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                //**Added by ACR 12/08/2002
                //**Block resource if Terminated

                if "Resource No." <> '' then begin
                    OK := "Lrec Resource".Get("Resource No.");
                    "Lrec Resource".Blocked := true;
                    "Lrec Resource".Modify();
                end;

                //**
            end;
        }
        field(50051; "Passport Number"; Code[20])
        {
            Caption = 'Passport Number';
        }
        field(50058; "HELB No"; Code[20])
        {
            Caption = 'HELB No';
        }
        field(50059; "Co-Operative No"; Code[20])
        {
            Caption = 'Co-Operative No';
        }
        field(50061; "Succesion Date"; Date)
        {
            Caption = 'Succesion Date';
        }
        field(50062; "Send Alert to"; Code[20])
        {
            Caption = 'Send Alert to';
        }
        field(50063; Religion; Code[30])
        {
            Caption = 'Religion';
        }
        field(50064; "Served Notice Period"; Boolean)
        {
            Caption = 'Served Notice Period';
        }
        field(50065; "Exit Interview Date"; Date)
        {
            Caption = 'Exit Interview Date';
        }
        field(50066; "Exit Interview Done by"; Code[50])
        {
            TableRelation = Employee."No.";
            Caption = 'Exit Interview Done by';
        }
        field(50067; "Allow Re-Employment In Future"; Boolean)
        {
            Caption = 'Allow Re-Employment In Future';
        }
        field(50068; "Incremental Month"; Text[30])
        {
            Caption = 'Incremental Month';
        }
        field(50069; "Current Date"; Date)
        {
            Caption = 'Current Date';
        }
        field(50070; Present; Code[30])
        {
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Salary Scale"));
            Caption = 'Present';

            trigger OnValidate()
            begin
                //DefaultAssignment();
            end;
        }
        field(50071; Previous; Code[30])
        {
            TableRelation = "Salary Pointer";
            Caption = 'Previous';
        }
        field(50072; Halt; Code[30])
        {
            TableRelation = "Salary Pointer";
            Caption = 'Halt';
        }
        field(50074; "Insurance Premium"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Insurance Code" = const(true)));
            FieldClass = FlowField;
            Caption = 'Insurance Premium';
        }
        field(50075; "Date OfJoining Payroll"; Date)
        {
            Caption = 'Date OfJoining Payroll';
        }
        field(50076; "Pro-Rata Calculated"; Boolean)
        {
            Caption = 'Pro-Rata Calculated';
        }
        field(50077; "Basic Arrears"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Basic Pay Arrears" = const(true)));
            FieldClass = FlowField;
            Caption = 'Basic Arrears';
        }
        field(50078; "Relief Amount"; Decimal)
        {
            CalcFormula = - sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                   "Payroll Period" = field("Pay Period Filter"),
                                                                   "Non-Cash Benefit" = const(true),
                                                                   Type = const(Earning),
                                                                   "Tax Deductible" = const(true),
                                                                   "Tax Relief" = const(true)));
            FieldClass = FlowField;
            Caption = 'Relief Amount';
        }
        field(50079; "Employee Qty"; Integer)
        {
            CalcFormula = count(Employee);
            FieldClass = FlowField;
            Caption = 'Employee Qty';
        }
        field(50080; "Employee Act. Qty"; Integer)
        {
            CalcFormula = count(Employee where("Termination Category" = filter(= " ")));
            FieldClass = FlowField;
            Caption = 'Employee Act. Qty';
        }
        field(50081; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = count(Employee where("Termination Category" = filter(<> " ")));
            FieldClass = FlowField;
            Caption = 'Employee Arc. Qty';
        }
        field(50082; "Other Language Read"; Boolean)
        {
            Caption = 'Other Language Read';
        }
        field(50083; "Other Language Write"; Boolean)
        {
            Caption = 'Other Language Write';
        }
        field(50084; "Other Language Speak"; Boolean)
        {
            Caption = 'Other Language Speak';
        }
        field(50085; "Employee Job Type"; Option)
        {
            OptionCaption = '  ,Driver,Executive,Director';
            OptionMembers = "  ",Driver,Executive,Director;
            Caption = 'Employee Job Type';
        }
        field(50087; "Contract Number"; Code[20])
        {
            Caption = 'Contract Number';
        }
        field(50186; "Loan Interest"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Loan Interest" where(Type = filter(Deduction | Loan),
                                                                           "Employee No" = field("No."),
                                                                           "Payroll Period" = field("Pay Period Filter")));
            FieldClass = FlowField;
            Caption = 'Loan Interest';
        }
        field(50187; "Resource Centre"; Boolean)
        {
            Caption = 'Resource Centre';
        }
        field(50188; "Resource Request Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled;
            Caption = 'Resource Request Status';
        }
        field(50189; "Blood Type"; Code[10])
        {
            Caption = 'Blood Type';
        }
        field(50190; Disability; Text[30])
        {
            Caption = 'Disability';
        }
        field(50191; "County Code"; Code[30])
        {
            Caption = 'County Code';
        }
        field(50192; "Retirement Date"; Date)
        {
            Caption = 'Retirement Date';
        }
        field(50193; "Medical Member No"; Code[20])
        {
            Caption = 'Medical Member No';
        }
        field(50194; "Exit Ref No"; Code[30])
        {
            Caption = 'Exit Ref No';
        }
        field(50195; "Human Resouce Manager"; Boolean)
        {
            Caption = 'Human Resouce Manager';
        }
        field(50196; "Hours Worked"; Decimal)
        {
            Caption = 'Hours Worked';
        }
        field(50198; "Lost Book"; Boolean)
        {
            Caption = 'Lost Book';
        }
        field(50199; "House Allowance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "House Allowance Code" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'House Allowance';
        }
        field(50200; Company; Text[30])
        {
            TableRelation = Company;
            Caption = 'Company';
        }
        field(50201; "Min Tax Rate"; Decimal)
        {
            Caption = 'Min Tax Rate';
        }
        field(50202; "Acting Position"; Code[20])
        {
            Caption = 'Acting Position';
        }
        field(50203; "Acting No"; Code[30])
        {
            Caption = 'Acting No';
        }
        field(50204; "Acting Description"; Text[60])
        {
            Caption = 'Acting Description';
        }
        field(50205; "Relieved Employee"; Code[30])
        {
            Caption = 'Relieved Employee';
        }
        field(50206; "Relieved Name"; Text[60])
        {
            Caption = 'Relieved Name';
        }
        field(50207; "Reason for Acting"; Text[100])
        {
            Caption = 'Reason for Acting';
        }
        field(50208; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(50209; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(50210; "Disability Certificate"; Code[30])
        {
            Caption = 'Disability Certificate';
        }
        field(50211; "Ethnic Group"; Code[10])
        {
            TableRelation = "Ethnic Groups";
            Caption = 'Ethnic Group';
        }
        field(50212; "Pension Contribution"; Decimal)
        {
            Caption = 'Pension Contribution';
        }
        field(55000; "No. of Members"; Integer)
        {
            Editable = false;
            Caption = 'No. of Members';
        }
        field(55001; "Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Open,Pending Approval,Active,Canceled,Rejected,Inactive,Deferred,Claim Processing,Archived';
            OptionMembers = Open,"Pending Approval",Active,Canceled,Rejected,Inactive,Deferred,"Claim Processing",Archived;
            Caption = 'Status Filter';
        }
        field(60000; Name; Text[60])
        {
            Caption = 'Name';
        }
        field(60001; "Employment Status"; Option)
        {
            OptionCaption = 'Probation,Extended Probation,Confirmed';
            OptionMembers = Probation,"Extended Probation",Confirmed;
            Caption = 'Employment Status';

            trigger OnValidate()
            begin
                /* HumanResSetup.Get();
                 HumanResSetup.TestField("Maximum Probation Period");
                  if "Employment Status"="Employment Status"::"Extended Probation" then
                  "End Of Probation Date":=CalcDate(HumanResSetup."Maximum Probation Period","Date Of Join");
                 */

            end;
        }
        field(60002; "Contract Length"; DateFormula)
        {
            Caption = 'Contract Length';

            trigger OnValidate()
            begin
                /*
                if "Contract Type"="Contract Type"::"Long-Term" then
                  "Contract Length">'<6M>' else
                  Error('The Contract Period Should be Greater than 6 Months');
                */

            end;
        }
        field(60003; "Clearance Department"; Option)
        {
            OptionCaption = ' ,Exams,Library,Finance,Dean of Students,Sports,Hostel,Hospital,Dean of School,Dean of Academics,Faculty,Overall';
            OptionMembers = " ",Exams,Library,Finance,"Dean of Students",Sports,Hostel,Hospital,"Dean of School","Dean of Academics",Faculty,Overall;
            Caption = 'Clearance Department';
        }
        field(60004; "Portal Registered"; Boolean)
        {
            Caption = 'Portal Registered';
        }
        field(60005; "Activation Code"; Guid)
        {
            Caption = 'Activation Code';
        }
        field(60006; "Payroll Suspenstion Date"; Date)
        {
            Caption = 'Payroll Suspenstion Date';
        }
        field(60007; "Payroll Reactivation Date"; Date)
        {
            Caption = 'Payroll Reactivation Date';
        }
        field(60008; "Employee Type"; Option)
        {
            OptionCaption = 'Parmanent,Partime,Locum,Casual';
            OptionMembers = Parmanent,Partime,Locum,Casual;
            Caption = 'Employee Type';
        }
        field(60009; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(60010; "Net Pay"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false)));
            FieldClass = FlowField;
            Caption = 'Net Pay';
        }
        field(60011; "Employment Type"; Option)
        {
            OptionCaption = 'Contract,Permanent';
            OptionMembers = Contract,Permanent;
            Caption = 'Employment Type';
        }
        field(60012; "Area"; Code[50])
        {
            Caption = 'Area';
        }
        field(60013; "Ethnic Community"; Code[30])
        {
            TableRelation = "Ethnic Communities";
            Caption = 'Ethnic Community';

            trigger OnValidate()
            begin
                /*
                if Ethnic.Get("Ethnic Community") then
                  "Ethnic Name":=Ethnic."Ethnic Name";
                */

            end;
        }
        field(60014; "Ethnic Name"; Text[60])
        {
            Caption = 'Ethnic Name';
        }
        field(60015; "Home District"; Code[30])
        {
            Caption = 'Home District';
        }
        field(60016; "Employee Company"; Option)
        {
            OptionCaption = 'KUC,Utalii Hotel';
            OptionMembers = KUC,"Utalii Hotel";
            Caption = 'Employee Company';
        }
        field(60017; "Employee Bank Name"; Text[50])
        {
            Caption = 'Employee Bank Name';
        }
        field(60018; "Employee Bank Sort Code"; Code[20])
        {
            Caption = 'Employee Bank Sort Code';
        }
        field(60019; "Employee Branch Name"; Text[30])
        {
            Caption = 'Employee Branch Name';
        }
        field(60020; "Insurance Relief"; Boolean)
        {
            Caption = 'Insurance Relief';
        }
        field(60021; Number; Code[20])
        {
            Caption = 'Number';
        }
        field(60022; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Rejected,Approved';
            OptionMembers = Open,"Pending Approval",Rejected,Approved;
            Caption = 'Approval Status';
        }
    }

    keys
    {
        key(Key1; Number)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Employee Bank Sort Code" = '' then begin
            HRSetup.Get();
            NoSeriesMgt.InitSeries(HRSetup."Employee Change Nos", xRec."No. Series", 0D, "Employee Bank Sort Code", "No. Series");
        end;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





