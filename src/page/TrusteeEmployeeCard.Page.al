page 52178 "Trustee Employee Card"
{
    ApplicationArea = All;
    Caption = 'Employee Card';
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit();
                    end;
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
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = FALSE;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                    Visible = FALSE;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                    Visible = FALSE;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    Visible = FALSE;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                    Visible = FALSE;
                }
                field("BOSA Member No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the BOSA Member No. field.';
                    Visible = FALSE;
                }
                field("FOSA Account No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the FOSA Account No. field.';
                    Visible = FALSE;
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
                group(Control197)
                {
                    ShowCaption = false;
                    Visible = DisabilityView;

                    field("Disability Certificate"; Rec."Disability Certificate")
                    {
                        Caption = 'Disability Certificate No.';
                        ToolTip = 'Specifies the value of the Disability Certificate No. field';
                    }
                }
                field("Date of Birth"; Rec."Birth Date")
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
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
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
                    Visible = false;
                    Caption = 'Ethnic Community';
                    ToolTip = 'Specifies the value of the Ethnic Community field';
                }
                field("Home District"; Rec."Home District")
                {
                    ToolTip = 'Specifies the value of the Home District field';
                    Caption = 'Country of Origin';
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
            group("Address & Contact")
            {
                Caption = 'Address & Contact';

                group(Control13)
                {
                    ShowCaption = false;

                    field(Address; Rec.Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;

                        field(County; Rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = true;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            Rec.DisplayMap();
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;

                    field("Mobile Phone No."; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager; Rec.Pager)
                    {
                        ToolTip = 'Specifies the employee''s pager number.';
                        Visible = FALSE;
                    }
                    field(Extension; Rec.Extension)
                    {
                        Visible = FALSE;
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                        Visible = FALSE;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = ' Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Alt. Address Code"; Rec."Alt. Address Code")
                    {
                        Visible = FALSE;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                    {
                        Visible = FALSE;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    }
                    field("Alt. Address End Date"; Rec."Alt. Address End Date")
                    {
                        Visible = FALSE;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                    }
                }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';

                field("Job Position"; Rec."Job Position")
                {
                    ToolTip = 'Specifies the value of the Job Position field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Title field';
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
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field';
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
                field(Control58; Rec."Acting Position")
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
            group(Payments)
            {
                Caption = 'Payments';

                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Debtor Code"; Rec."Debtor Code")
                {
                    ToolTip = 'Specifies the value of the Debtor Code field';
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                    Visible = false;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                    Visible = false;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                    Visible = FALSE;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    Visible = FALSE;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    Visible = FALSE;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the PIN Number field';
                }
                field("NHIF No."; Rec."NHIF No")
                {
                    Visible = FALSE;
                    Caption = 'NHIF No.';
                    ToolTip = 'Specifies the value of the NHIF No. field';
                }
                field("NSSF No."; Rec."Social Security No.")
                {
                    Visible = FALSE;
                    ToolTip = 'Specifies the value of the Social Security No. field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field("Employee's Bank"; Rec."Employee's Bank")
                {
                    Caption = 'Bank';
                    TableRelation = Banks;
                    ToolTip = 'Specifies the value of the Bank field';

                    trigger OnValidate()
                    begin

                        if Banks.Get(Rec."Employee's Bank") then
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
                    Visible = FALSE;
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
                field(Present; Rec."Present Pointer")
                {
                    Visible = FALSE;
                    Caption = 'Present Pointer';
                    ToolTip = 'Specifies the value of the Present Pointer field';
                }
                field(Previous; Rec.Previous)
                {
                    Visible = FALSE;
                    Caption = 'Previous Pointer';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Previous Pointer field';
                }
                field(Halt; Rec.Halt)
                {
                    Visible = FALSE;
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
                    Visible = FALSE;
                    ToolTip = 'Specifies the value of the Pays tax? field';
                }
                field("Secondary Employee"; Rec."Secondary Employee")
                {
                    Visible = FALSE;
                    ToolTip = 'Specifies the value of the Secondary Employee field';
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    Visible = FALSE;
                    ToolTip = 'Specifies the value of the Insurance Relief field';
                }
                field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pro-Rata Calculated field';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Basic Pay field';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated House Allowance field';
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Premium field';
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Earnings field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Deductions field';
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated Taxable Allowance field';
                }
                field("Cumm. PAYE"; Rec."Cumm. PAYE")
                {
                    ToolTip = 'Specifies the value of the Total Accumulated PAYE field';
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
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ToolTip = 'Specifies the value of the Grounds for Term. Code field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
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
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(5200),
                              "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
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
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;

                action(Action81)
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Action184)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = const(5200),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(Action76)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = page "Employee Picture";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = page "Alternative Address List";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("&Relatives")
                {
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = page "Employee Relatives";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = page "Employee Qualifications";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                separator(Action23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = page "Empl. Absences by Categories";
                    RunPageLink = "No." = field("No."),
                                  "Employee No. Filter" = field("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
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
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = field("No."),
                                  "Remaining Amount" = filter(< 0),
                                  "Applies-to ID" = filter('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
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
                action(Action189)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action(Action188)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action(Action187)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = page "Employee Qualifications";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action(Action186)
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
                separator(Action182)
                {
                }
                action(Action181)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = page "Empl. Absences by Categories";
                    RunPageLink = "No." = field("No."),
                                  "Employee No. Filter" = field("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action(Action180)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action(Action179)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action178)
                {
                }
                action(Action177)
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

                group(Action192)
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
            action("Opening Balances")
            {
                RunObject = page "Deductions Balances";
                RunPageLink = "Employee No" = field("No.");
                ToolTip = 'Executes the Opening Balances action';
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
            separator(Action151)
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
                    Payroll.DefaultEarningsDeductionsAssignment(Rec);
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
                    Employee.SetRange("Employee Type", Employee."Employee Type"::"Board Member");
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
                    if PayPeriod.Find('-') then begin
                        CurrentMonth := PayPeriod."Starting Date";
                        Employee.SetRange("Employee Type", Employee."Employee Type"::"Board Member");
                        Employee.SetRange("Pay Period Filter", CurrentMonth);
                        Report.Run(Report::"Payroll Run Trustees", true, false, Employee);
                    end else
                        Error('You cannot run payroll for a closed period');
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
            action("Change Request")
            {
                Image = Change;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Change Request action';

                trigger OnAction()
                begin

                    Numb := HRMgt.EmployeeChangeReq(Rec);
                    EmployeeChange.SetRange(Number, Numb);
                    HRMgt.EmployeeChangeReq(Rec);
                    Page.Run(Page::"Employee Change Card", EmployeeChange);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ContractView := false;
        DisabilityView := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
        Rec."Employment Type" := Rec."Employment Type"::Trustee;
        Rec."Secondary Employee" := true;
        Rec."Pays tax?" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
        Rec."Employment Type" := Rec."Employment Type"::Trustee;
        Rec."Secondary Employee" := true;
        Rec."Pays tax?" := true;
    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible();
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");

        SetContractView();
        DisabilityView := false;

        //ProbationPeriod:=HRSetup."Probation Duration";

        // IF LeaveType.GET('ANNUAL') THEN
        // "Annual Leave Days":= LeaveType.Days;
        // //MODIFY;
        //
        // IF LeaveType.GET('PATERNITY') THEN
        //  BEGIN
        //  IF Gender = LeaveType.Gender THEN
        //    Visibility:=TRUE;
        //    "Paternity Leave Days":=LeaveType.Days;
        //  END
        //  ELSE Visibility:=FALSE;
        // //MODIFY;
        //
        // IF LeaveType.GET('COMPASSION') THEN
        //  "Compassionate Leave Days":=LeaveType.Days;
        // //MODIFY;
        //
        // IF LeaveType.GET('SICK') THEN
        //  "Sick Leave Days":=LeaveType.Days;
        // //MODIFY;
        //
        // IF LeaveType.GET('UNPAID') THEN
        //  "Other Leave Days (Total)":=LeaveType.Days;
        // //MODIFY;
        //
        // IF LeaveType.GET('MATERNITY') THEN
        //  BEGIN
        //  IF Gender = LeaveType.Gender THEN
        //  Visibility:=TRUE ELSE Visibility:=FALSE;
        //  "Maternity Leave Days":=LeaveType.Days;
        //  END
        // ELSE Visibility:=FALSE;
        // //MODIFY;
        //
        // IF LeaveType.GET('STUDY') THEN
        // "Study Leave Days":=LeaveType.Days;
    end;

    var
        Banks: Record Banks;
        Employee: Record Employee;
        EmployeeChange: Record "Employee Change Request";
        PayPeriod: Record "Payroll Period Trustees";
        FormatAddress: Codeunit "Format Address";
        HRMgt: Codeunit "HR Management";
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        ProbationPeriod: DateFormula;
        ContractView: Boolean;
        DisabilityView: Boolean;
        IsCountyVisible: Boolean;
        NoFieldVisible: Boolean;
        Numb: Code[20];
        CurrentMonth: Date;
        ShowMapLbl: Label 'Show on Map';
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

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;
}





