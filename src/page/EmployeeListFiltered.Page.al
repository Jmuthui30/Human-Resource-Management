page 52164 "Employee List-Filtered"
{
    ApplicationArea = All;
    Caption = 'Employees-Active';
    CardPageID = "Employee Card";
    Editable = true;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = where("Employee Type" = filter(<> "Board Member"), Status = const(Active));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(FullName; Rec.FullName())
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the employee.';
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Mobile Phone No.';
                    ToolTip = 'Specifies the employee''s private telephone number.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    Caption = 'TIN No.';
                    ToolTip = 'Specifies the value of the PIN Number field';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ToolTip = 'Specifies the value of the Social Security No. field';
                }
                field("NHIF No"; Rec."NHIF No")
                {
                    ToolTip = 'Specifies the value of the NHIF No field';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies if a comment has been entered for this entry.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action(AssignEarnings)
                {
                    Caption = 'Update Earnings & Deductions - All Staff';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Assign Default Ded/Earnings action';
                    Image = Refresh;
                    Visible = false;

                    trigger OnAction()
                    var
                        Employee: Record Employee;
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Employee.SetRange(Status, Employee.Status::Active);
                            Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
                            if Employee.FindSet() then begin
                                repeat
                                    Payroll.DefaultEarningsDeductionsAssignment(Employee);
                                until Employee.Next() = 0;
                                Message('Updated Successfully');
                            end;
                        end;
                    end;
                }
                action("Payroll Run")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Payroll Run action';

                    trigger OnAction()
                    var
                        PayPeriod: Record "Payroll Period";
                        CurrentMonth: Date;
                    begin
                        PayPeriod.Reset();
                        PayPeriod.SetRange(Closed, false);
                        if PayPeriod.FindLast() then begin
                            CurrentMonth := PayPeriod."Starting Date";
                            //Check to prevent calculation when under approval
                            Payroll.CheckIfPayrollPeriodUnderApproval(CurrentMonth);
                            Employee.SetRange("Pay Period Filter", CurrentMonth);
                            Report.Run(Report::"Payroll Run", true, false, Employee);
                        end else
                            Error('You cannot run payroll for a closed period')
                    end;
                }

                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    action("Dimensions-Single")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = page "Default Dimensions";
                        RunPageLink = "Table ID" = const(5200),
                                      "No." = field("No.");
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = tabledata Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            Employee: Record Employee;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(Employee);
                            DefaultDimMultiple.SetMultiRecord(Employee, Rec.FieldNo("No."));
                            DefaultDimMultiple.RunModal();
                        end;
                    }
                }
                action("&Picture")
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
                action("Co&nfidential Information")
                {
                    Caption = 'Co&nfidential Information';
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
                separator(Action51)
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
                action("Con&fidential Info. Overview")
                {
                    Caption = 'Con&fidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
            }
        }
        area(processing)
        {
            action("Absence Registration")
            {
                Caption = 'Absence Registration';
                Image = Absence;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Absence Registration";
                ToolTip = 'Register absence for the employee.';
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
                Visible = false;
            }
            action(PayEmployee)
            {
                Visible = false;
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
                ToolTip = 'View employee ledger entries for the selected record with remaining amount that have not been paid yet.';
            }
        }
    }
    trigger OnOpenPage()
    begin
        // CurrPage.Editable := Rec.EnforcePayrollPermissions();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        NoDeleteEmployeeErr: Label 'You are not allowed to delete an employee';
    begin
        Error(NoDeleteEmployeeErr);
    end;

    var
        Employee: Record Employee;
        Payroll: Codeunit Payroll;
}





