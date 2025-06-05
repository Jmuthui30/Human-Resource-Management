page 52127 "Employee Change Card"
{
    ApplicationArea = All;
    Caption = 'Employee Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Effect Changes';
    SourceTable = "Employee Change Request";

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';

                field("No."; Rec."No.")
                {
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        //AssistEdit;
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the value of the Initials field';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ToolTip = 'Specifies the value of the Passport No. field';
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                    ToolTip = 'Specifies the value of the Driving Licence field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';

                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field';

                    trigger OnValidate()
                    begin

                        if Rec.Disabled = Rec.Disabled::No then
                            DisabilityView := false
                        else
                            DisabilityView := true;
                    end;
                }
                group(Control129)
                {
                    ShowCaption = false;
                    Visible = DisabilityView;

                    field("Disability Certificate"; Rec."Disability Certificate")
                    {
                        Caption = 'Disability Certificate No.';
                        ToolTip = 'Specifies the value of the Disability Certificate No. field';
                    }
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Birth';
                    Importance = Standard;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Date of Birth - Age"; Rec."Date of Birth - Age")
                {
                    Caption = ' Age';
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the  Age field';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field';
                }
                field(Religion; Rec.Religion)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Religion field';
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ethnic Origin field';
                }
                field("Ethnic Community"; Rec."Ethnic Community")
                {
                    Caption = 'Ethnic Code';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ethnic Code field';
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    Caption = 'Ethnic Community';
                    ToolTip = 'Specifies the value of the Ethnic Community field';
                }
                field("Home District"; Rec."Home District")
                {
                    ToolTip = 'Specifies the value of the Home District field';
                }
                field(County; Rec.County)
                {
                    Caption = 'Home District';
                    ToolTip = 'Specifies the value of the Home District field';
                }
                field("First Language"; Rec."First Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the First Language field';
                }
                field("Second Language"; Rec."Second Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Second Language field';
                }
                field("Other Language"; Rec."Other Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Other Language field';
                }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';

                field("Employee Company"; Rec."Employee Company")
                {
                    Caption = 'Company';
                    ToolTip = 'Specifies the value of the Company field';
                }
                field("Job Position"; Rec."Job Position")
                {
                    ToolTip = 'Specifies the value of the Job Position field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the value of the Area field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';
                    ToolTip = 'Specifies the value of the Employment Type field';

                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                field("Clearance Department"; Rec."Clearance Department")
                {
                    ToolTip = 'Specifies the value of the Clearance Department field';
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = false;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                        ToolTip = 'Specifies the value of the Contract Type field';
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                        ToolTip = 'Specifies the value of the Contract Number field';
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                        ToolTip = 'Specifies the value of the Contract Length field';
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                        ToolTip = 'Specifies the value of the Contract Start Date field';
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                        ToolTip = 'Specifies the value of the Contract End Date field';
                    }
                }
            }
            group("Acting Position")
            {
                Caption = 'Acting Position';
                Editable = false;

                field("Acting No"; Rec."Acting No")
                {
                    ToolTip = 'Specifies the value of the Acting No field';
                }
                field(Control159; Rec."Acting Position")
                {
                    ToolTip = 'Specifies the value of the Acting Position field';
                }
                field("Acting Description"; Rec."Acting Description")
                {
                    ToolTip = 'Specifies the value of the Acting Description field';
                }
                label("Details:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                    ToolTip = 'Specifies the value of the Relieved Employee field';
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    ToolTip = 'Specifies the value of the Relieved Name field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Reason for Acting"; Rec."Reason for Acting")
                {
                    ToolTip = 'Specifies the value of the Reason for Acting field';
                }
            }
            group(Administration)
            {
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ToolTip = 'Specifies the value of the Inactive Date field';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ToolTip = 'Specifies the value of the Cause of Inactivity Code field';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ToolTip = 'Specifies the value of the Termination Date field';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ToolTip = 'Specifies the value of the Grounds for Term. Code field';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ToolTip = 'Specifies the value of the Statistics Group Code field';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resource No. field';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field';
                }
            }
            group("Lecturer Info")
            {
                Visible = false;
                Caption = 'Lecturer Info';

                field("Is Lecturer"; Rec."Is Lecturer")
                {
                    ToolTip = 'Specifies the value of the Is Lecturer field';
                }
                field("Lecturer Type"; Rec."Lecturer Type")
                {
                    ToolTip = 'Specifies the value of the Lecturer Type field';
                }
                field("Lecturer Password"; Rec."Lecturer Password")
                {
                    ToolTip = 'Specifies the value of the Lecturer Password field';
                }
                field("Portal Registered"; Rec."Portal Registered")
                {
                    ToolTip = 'Specifies the value of the Portal Registered field';
                }
                field("Activation Code"; Rec."Activation Code")
                {
                    ToolTip = 'Specifies the value of the Activation Code field';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                Editable = true;
                Visible = false;

                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employee Posting Group field';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the PIN Number field';
                }
                field("NHIF No."; Rec."NHIF No")
                {
                    Caption = 'NHIF No.';
                    ToolTip = 'Specifies the value of the NHIF No. field';
                }
                field("NSSF No."; Rec."Social Security No.")
                {
                    ToolTip = 'Specifies the value of the Social Security No. field';
                }
                field("HELB No"; Rec."HELB No")
                {
                    ToolTip = 'Specifies the value of the HELB No field';
                }
                field("Co-Operative No"; Rec."Co-Operative No")
                {
                    ToolTip = 'Specifies the value of the Co-Operative No field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field("Employee's Bank"; Rec."Employee's Bank")
                {
                    Caption = 'Bank';
                    ToolTip = 'Specifies the value of the Bank field';

                    trigger OnValidate()
                    begin

                        if Banks.Get(Rec."Bank Code") then
                            BankName := Banks.Name;
                    end;
                }
                field("Employee Bank Name"; Rec."Employee Bank Name")
                {
                    Caption = 'Bank Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field';
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field';
                }
                field("Employee Branch Name"; Rec."Employee Branch Name")
                {
                    Caption = 'Branch Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Branch Name field';
                }
                field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
                {
                    Caption = 'Sort Code';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sort Code field';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ToolTip = 'Specifies the value of the Bank Account Number field';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'HR Posting Group';
                    ToolTip = 'Specifies the value of the HR Posting Group field';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field';
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
                field(Present; Rec.Present)
                {
                    Caption = 'Present Pointer';
                    ToolTip = 'Specifies the value of the Present Pointer field';
                }
                field(Previous; Rec.Previous)
                {
                    Caption = 'Previous Pointer';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Previous Pointer field';
                }
                field(Halt; Rec.Halt)
                {
                    Caption = 'Halt Pointer';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Halt Pointer field';
                }
                field("Incremental Month"; Rec."Incremental Month")
                {
                    ToolTip = 'Specifies the value of the Incremental Month field';
                }
                field("Pays tax?"; Rec."Pays tax?")
                {
                    ToolTip = 'Specifies the value of the Pays tax? field';
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Relief field';
                }
                field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pro-Rata Calculated field';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the House Allowance field';
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Premium field';
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    ToolTip = 'Specifies the value of the Total Allowances field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field';
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                    ToolTip = 'Specifies the value of the Taxable Allowance field';
                }
                field("Cumm. PAYE"; Rec."Cumm. PAYE")
                {
                    ToolTip = 'Specifies the value of the Cumm. PAYE field';
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Date Of Join"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field';

                    trigger OnValidate()
                    begin

                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the ProbationPeriod field';
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Probation End Date field';
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme Join field';
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Medical Scheme Join field';
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Retirement Date field';
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                Visible = false;

                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ToolTip = 'Specifies the value of the Annual Leave Days field';
                }
                field("Compassionate Leave Days"; Rec."Compassionate Leave Days")
                {
                    ToolTip = 'Specifies the value of the Compassionate Leave Days field';
                }
                field("Maternity Leave Days"; Rec."Maternity Leave Days")
                {
                    Visible = Visibility;
                    ToolTip = 'Specifies the value of the Maternity Leave Days field';
                }
                field("Paternity Leave Days"; Rec."Paternity Leave Days")
                {
                    Visible = Visibility;
                    ToolTip = 'Specifies the value of the Paternity Leave Days field';
                }
                field("Sick Leave Days"; Rec."Sick Leave Days")
                {
                    ToolTip = 'Specifies the value of the Sick Leave Days field';
                }
                field("Study Leave Days"; Rec."Study Leave Days")
                {
                    ToolTip = 'Specifies the value of the Study Leave Days field';
                }
                field("Other Leave Days (Total)"; Rec."Other Leave Days (Total)")
                {
                    ToolTip = 'Specifies the value of the Other Leave Days (Total) field';
                }
            }
            group(Separation)
            {
                Caption = 'Separation';

                field("Notice Period"; Rec."Notice Period")
                {
                    ToolTip = 'Specifies the value of the Notice Period field';
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ToolTip = 'Specifies the value of the Send Alert to field';
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ToolTip = 'Specifies the value of the Served Notice Period field';
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field';
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Termination Category field';
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ToolTip = 'Specifies the value of the Exit Interview Date field';
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ToolTip = 'Specifies the value of the Exit Interview Done by field';
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                    ToolTip = 'Specifies the value of the Allow Re-Employment In Future field';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Picture)
            {
                Caption = 'Picture';
                Image = Picture;

                action("Co&mments")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                    ToolTip = 'View or add comments for the record.';
                    Visible = true;
                }
                action(Dimensions)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = const(5200),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    Visible = true;
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = page "Employee Picture";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                    Visible = true;
                }
            }
            group(Employee)
            {
                Caption = 'Employee';

                action(AlternativeAddresses)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = page "Alternative Address List";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("Next of Kin")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    RunObject = page "Employee Relatives";
                    RunPageLink = "Employee No." = field("No.");
                    RunPageMode = View;
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = page "Employee Qualifications";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                action(Disciplinary)
                {
                    Image = DeleteAllBreakpoints;
                    RunObject = page "Closed Disciplinary Cases";
                    RunPageLink = "Employee No" = field("No.");
                    ToolTip = 'Executes the Disciplinary action';
                }
                separator(Action23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = page "Empl. Absences by Categories";
                    RunPageLink = "No." = field("No."),
                                  "Employee No. Filter" = field("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action61)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = field("No.");
                    RunPageView = sorting("Employee No.")
                                  order(descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Employment History")
                {
                    Image = History;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = page "Employment History";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Executes the Employment History action';
                }
                action("Employee Appointment Checklist")
                {
                    Caption = 'Appointment Checklist';
                    Image = CheckList;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = page "Appointment Checklist ListPart";
                    ToolTip = 'Executes the Appointment Checklist action';
                }
                action("Leave Aplications")
                {
                    Image = JobResponsibility;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedOnly = true;
                    RunObject = page "Leave Application List";
                    RunPageLink = "Employee No" = field("No.");
                    ToolTip = 'Executes the Leave Aplications action';
                }
                action("Professional Membership")
                {
                    Image = Agreement;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = page "Professional Membership";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Executes the Professional Membership action';
                }
                action(Union)
                {
                    Image = Union;
                    ToolTip = 'Executes the Union action';
                }
                action("Acting Positions")
                {
                    Image = EditCustomer;
                    RunObject = page "Acting Duties List";
                    RunPageLink = "Acting Employee No." = field("No.");
                    ToolTip = 'Executes the Acting Positions action';
                }
                action(Beneficiaries)
                {
                    Image = Employee;
                    RunObject = page "Employee Beneficiaries";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Executes the Beneficiaries action';
                }
            }
            group("Performance Management")
            {
                Caption = 'Performance Management';
                Visible = false;

                group(Action72)
                {
                    Caption = 'Performance Management';
                    Image = Travel;

                    action(Appraisal)
                    {
                        ToolTip = 'Executes the Appraisal action';

                        trigger OnAction()
                        begin
                            Message('Coming Soon');
                        end;
                    }
                }
            }
        }
        area(creation)
        {
            group(Earnings)
            {
                Visible = false;
            }
            action("Assign Earnings")
            {
                Caption = 'Assign Earnings';
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Earning),
                              Closed = const(false);
                ToolTip = 'Executes the Assign Earnings action';
            }
            action("Dispay Reccuring Earnings")
            {
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Earning),
                              Frequency = const(Recurring),
                              Closed = const(false);
                ToolTip = 'Executes the Dispay Reccuring Earnings action';
            }
            action("Display Non-reccuring Earnings")
            {
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Earning),
                              Frequency = const("Non-recurring"),
                              Closed = const(false);
                ToolTip = 'Executes the Display Non-reccuring Earnings action';
            }
            group(Deductions)
            {
                Visible = false;
            }
            action("Assign Deductions")
            {
                Caption = 'Assign Deductions';
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Deduction),
                              Closed = const(false);
                ToolTip = 'Executes the Assign Deductions action';
            }
            action("Deductions List")
            {
                RunObject = page "Deductions";
                ToolTip = 'Executes the Deductions List action';
            }
            action("Display Reccuring Deductions")
            {
                Caption = 'Display Reccuring Deductions';
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Deduction),
                              Frequency = const(Recurring),
                              Closed = const(false);
                ToolTip = 'Executes the Display Reccuring Deductions action';
            }
            action("Display Non-reccuring Deductions")
            {
                Caption = 'Display Non-reccuring Deductions';
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Deduction),
                              Frequency = const("Non-recurring"),
                              Closed = const(false);
                ToolTip = 'Executes the Display Non-reccuring Deductions action';
            }
            group(Loans)
            {
            }
            action("Deduction Loan")
            {
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Type = const(Loan),
                              Closed = const(false);
                ToolTip = 'Executes the Deduction Loan action';
            }
            action("Employee Loan(s) List")
            {
                Caption = 'Employee Loan(s) List';
                ToolTip = 'Executes the Employee Loan(s) List action';
            }
            action("Savings Withdrawals")
            {
                RunObject = page "Payments & Deductions";
                RunPageLink = "Employee No" = field("No."),
                              Closed = const(false),
                              Type = const("Saving Scheme");
                ToolTip = 'Executes the Savings Withdrawals action';
            }
            group("Pay Manager")
            {
            }
            action("Pay Information")
            {
                ToolTip = 'Executes the Pay Information action';
            }
            separator(Action147)
            {
            }
            action("Account Mapping")
            {
                ToolTip = 'Executes the Account Mapping action';
            }
        }
        area(processing)
        {
            action("Assign Default Ded/Earnings")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Assign Default Ded/Earnings action';

                trigger OnAction()
                begin
                    //DefaultAssignment();
                end;
            }
            action(Payslip)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Executes the Payslip action';

                trigger OnAction()
                begin
                    PayPeriod.Reset();
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then
                        CurrentMonth := PayPeriod."Starting Date";
                    Employee.SetRange("No.", Rec."No.");
                    Employee.SetRange("Pay Period Filter", CurrentMonth);
                    Report.Run(Report::"New Payslipx", true, false, Employee);
                end;
            }
            action("Payroll Run")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Payroll Run action';

                trigger OnAction()
                begin
                    PayPeriod.Reset();
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then
                        CurrentMonth := PayPeriod."Starting Date";
                    Employee.SetRange("No.", Employee."No.");
                    Employee.SetRange("Pay Period Filter", CurrentMonth);
                    Report.Run(Report::"Payroll Run-veryold", true, false, Employee);
                end;
            }
            action("Yearly Bonus")
            {
                Image = Holiday;
                ToolTip = 'Executes the Yearly Bonus action';

                trigger OnAction()
                begin

                    Payroll.GetYearlyBonus(Rec."No.");
                end;
            }
            action("Mail Payslip")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Mail Payslip action';

                trigger OnAction()
                var
                    MailBulkPayslips: Report "Mail Bulk Payslips";
                begin
                    if Confirm(Text0001, false) = true then begin
                        //Mail single
                        Employee.Reset();
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst() then begin
                            MailBulkPayslips.SetTableView(Employee);
                            MailBulkPayslips.Run();
                        end;
                    end else
                        exit;
                end;
            }
            action("Import Data")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Import Data action';

                trigger OnAction()
                begin

                    Clear(EmployeeXML);
                    EmployeeXML.Run();
                end;
            }
            action(SendApproval)
            {
                Caption = 'Effect Changes';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin

                    Employee.Reset();
                    Employee.SetRange("No.", Rec."No.");
                    if Employee.Find('-') then
                        //  Employee.TransferFields(Rec);
                        //**********************************************************************************************changes
                        if Rec."First Name" <> '' then
                            Employee."First Name" := Rec."First Name";
                    if Rec."Middle Name" <> '' then
                        Employee."Middle Name" := Rec."Middle Name";
                    if rec."Last Name" <> '' then
                        Employee."Last Name" := Rec."Last Name";
                    if Rec.Name <> '' then
                        Employee.Name := Rec.Name;
                    if Rec.Gender <> Rec.Gender::" " then
                        Employee.Gender := Rec.Gender;
                    if Rec."Phone No." <> '' then
                        Employee."Phone No." := Rec."Phone No.";
                    if Rec."Mobile Phone No." <> '' then
                        Employee."Mobile Phone No." := Rec."Mobile Phone No.";
                    if Rec."E-Mail" <> '' then
                        Employee."E-Mail" := Rec."E-Mail";
                    if Rec."Global Dimension 1 Code" <> '' then
                        Employee."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    if Rec."Global Dimension 2 Code" <> '' then
                        Employee."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    if Rec.Position <> '' then
                        Employee.Position := Rec.Position;
                    if rec.Address <> '' then
                        Employee.Address := Rec.Address;
                    if Rec."Job Position" <> '' then
                        Employee."Job Position" := Rec."Job Position";
                    if Rec."Job Position Title" <> '' then
                        Employee."Job Position Title" := Rec."Job Position Title";
                    if Rec."Job Title" <> '' then
                        Employee."Job Title" := Rec."Job Title";
                    if Rec."Date of Birth" <> 0D then
                        Employee."Birth Date" := Rec."Date of Birth";

                    if Rec."Marital Status" <> Rec."Marital Status"::" " then
                        Employee."Marital Status" := Rec."Marital Status";
                    // if Rec."Employee Type" <> Rec."Employee Type":: then
                    //     Employee."Employee Type" := Rec."Employee Type";

                    Employee.Modify();
                    Message('Change Made Successfully');
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ContractView := false;
        DisabilityView := false;
    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible();
        SetLecturerVisible();
        SetContractView();
        DisabilityView := false;
    end;

    var
        Banks: Record Banks;
        Employee: Record Employee;
        PayPeriod: Record "Payroll Period";
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        ProbationPeriod: DateFormula;
        ContractView: Boolean;
        DisabilityView: Boolean;
        IsLecturerVisible: Boolean;
        NoFieldVisible: Boolean;
        Visibility: Boolean;
        CurrentMonth: Date;
        Text0001: Label 'Do you want to send the payslip?';
        BankName: Text;

    local procedure ContractFields()
    begin
        /*//"Contract Type":='';
        "Contract Number":=0;
        "Contract Start Date":=0D;
        "Contract End Date":=0D;
        "Send Alert to":='';
        Modify();
        */

    end;

    local procedure Disability()
    begin
        if Rec."No." <> '' then
            if Rec.Disabled = Rec.Disabled::No then
                DisabilityView := false
            else
                DisabilityView := true;
    end;

    local procedure DisabilityField()
    begin
        Rec.Disability := '';
    end;

    local procedure GetCurrentPayPeriod(): Date
    begin
        PayPeriod.Reset();
        PayPeriod.SetRange(Closed, false);
        if PayPeriod.FindFirst() then
            exit(PayPeriod."Starting Date");
    end;

    local procedure SetContractView()
    begin
        if Rec."No." <> '' then
            if Rec."Nature of Employment" <> 'CONTRACT' then
                ContractView := false
            else
                ContractView := true;
    end;

    local procedure SetLecturerVisible()
    begin
        if Rec."Is Lecturer" = true then
            IsLecturerVisible := true
        else
            IsLecturerVisible := false;
    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;
}





