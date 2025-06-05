page 52121 "HR Role Center"
{
    ApplicationArea = All;
    PageType = RoleCenter;
    Caption = 'HR Role Center';
    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                ShowCaption = false;
                Caption = 'Control2';
            }
            part("Employee Cues"; "Employee Payroll Cue")
            {
                Caption = 'Employee Payroll Cue';
            }
            part("HR Management Cues"; "HR Management Cues")
            {
                Caption = 'HR Management Cues';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Disciplinary Actions ")
            {
                Image = Holiday;
                ToolTip = 'Executes the Disciplinary Actions  action';
                Caption = 'Disciplinary Actions ';
            }
            action("Staff Absence ")
            {
                Image = Absence;
                RunObject = report "Employee - Staff Absences";
                ToolTip = 'Executes the Staff Absence  action';
                Caption = 'Staff Absence ';
            }
            action("HRSetup")
            {
                RunObject = page "Human Resources Setup";
                ToolTip = 'Executes the HRSetup action';
                Caption = 'HR Setup';
            }
            action(ExecuteHRNotifications)
            {
                Caption = 'Execute HR Notifications';
                RunObject = codeunit "HR Notifications";
            }
            group("Payroll Setups ")
            {
                Image = Departments;
                Caption = 'Payroll Setups';

                action("Payroll Period1")
                {
                    RunObject = page "Pay Period";
                    ToolTip = 'Executes the Payroll Period action';
                    Caption = 'Payroll Period';
                }
                action(Earnings1)
                {
                    RunObject = page "Earnings";
                    ToolTip = 'Executes the Earnings action';
                    Caption = 'Earnings';
                }
                action(Deductions1)
                {
                    RunObject = page "Deductions";
                    ToolTip = 'Executes the Deductions action';
                    Caption = 'Deductions';
                }
                action("Bracket Tables1")
                {
                    RunObject = page "Bracket Table";
                    ToolTip = 'Executes the Bracket Tables action';
                    Caption = 'Bracket Tables';
                }
                action(Stations1)
                {
                    RunObject = page Dimensions;
                    ToolTip = 'Executes the Stations action';
                    Caption = 'Stations';
                }
                action("Salary Scale1")
                {
                    RunObject = page "Salary Scale";
                    ToolTip = 'Executes the Salary Scale action';
                    Caption = 'Salary Grades';
                }
                action("Salary Pointers1")
                {
                    RunObject = page "Salary pointer";
                    Visible = false;
                    ToolTip = 'Executes the Salary Pointers action';
                    Caption = 'Salary Steps';
                }
                action("Employee Posting Groups1")
                {
                    RunObject = page "Emp Posting Group";
                    ToolTip = 'Executes the Employee Posting Groups action';
                    Caption = 'Employee Posting Groups';
                }
                action("Employee Payment Types1")
                {
                    RunObject = page "Employee Pay Modes";
                    ToolTip = 'Executes the Employee Payment Types action';
                    Caption = 'Employee Payment Types';
                }
                action("Casual Pay Periods1")
                {
                    RunObject = page "Casual Pay Period";
                    Visible = false;
                    ToolTip = 'Executes the Casual Pay Periods action';
                    Caption = 'Casual Pay Periods';
                }
                action("Loan Product Types1")
                {
                    RunObject = page "Loan Product Types-Payroll";
                    ToolTip = 'Executes the Loan Product Types action';
                    Caption = 'Loan Product Types';
                }
                action(Banks1)
                {
                    Caption = 'Banks';
                    RunObject = page Banks;
                    ToolTip = 'Executes the Banks action';
                }
                action("Bank Branches1")
                {
                    RunObject = page "Bank Branches List";
                    ToolTip = 'Executes the Bank Branches action';
                    Caption = 'Bank Branches';
                }
                action(Destinations1)
                {
                    Image = Holiday;
                    RunObject = page "Destination Code";
                    ToolTip = 'Executes the Destinations action';
                    Caption = 'Destinations';
                }
            }
        }
        area(sections)
        {
            group("Acting & Promotion ")
            {
                Image = ResourcePlanning;
                Caption = 'Acting & Promotion ';
                action("Acting Duties List ")
                {
                    RunObject = page "Acting Duties List";
                    RunPageLink = Status = filter(<> Approved | Rejected);
                    ToolTip = 'Executes the Acting Duties List  action';
                    Caption = 'Acting Duties List ';
                }
                action("Acting Duties List Approved ")
                {
                    RunObject = page "Acting Duties List";
                    RunPageLink = Status = filter(Approved);
                    ToolTip = 'Executes the Acting Duties List Approved  action';
                    Caption = 'Acting Duties List Approved ';
                }
                action("Promotion/Demotion List ")
                {
                    RunObject = page "Promotion_Demotion List";
                    ToolTip = 'Executes the Promotion List  action';
                    Caption = 'Promotion List ';
                }
                action("Promotion List Approved ")
                {
                    RunObject = page "Promotion_Demotions Approved";
                    ToolTip = 'Executes the Promotion List Approved  action';
                    Caption = 'Promotion List Approved ';
                }
                group(ActingReports)
                {
                    Caption = 'Reports';
                    action("Acting Duties Report")
                    {
                        RunObject = report "Acting Report";
                        ToolTip = 'Executes the Acting Duties Report action';
                        Caption = 'Acting Duties Report';
                    }
                    action("Promotion Report")
                    {
                        RunObject = report "Employee acting and promotion";
                        ToolTip = 'Executes the Promotion Report action';
                        Caption = 'Promotion Report';
                    }
                }
            }
            group("Board Members")
            {
                Caption = 'Board Members';
                Image = HumanResources;
                action("Trustee Employees")
                {
                    Caption = 'Board Members';
                    RunObject = page "Trustee Employees";
                    ToolTip = 'Executes the Board Members action';
                }
                action("Allowance Registers")
                {
                    RunObject = page "Allowance Register List";
                    ToolTip = 'Executes the Allowances Register action';
                    Caption = 'Allowance Register';
                }

                group("Setups")
                {
                    Visible = false;
                    Caption = 'Setups';
                    action("Pay Period Trustees")
                    {
                        Caption = 'Pay Period - Board Members';
                        RunObject = page "Pay Period Trustees";
                        ToolTip = 'Executes the Pay Period - Board Members action';
                    }
                }

                group("Trustee Payment Reversal")
                {
                    Visible = false;
                    Caption = 'Board Payment Reversal';
                    action("Trustee Payment Reversals")
                    {
                        Caption = 'Board Payment Reversals';
                        RunObject = page "Trustee Payment Reversals";
                        ToolTip = 'Executes the Board Payment Reversals action';
                    }

                    action("Posted Trustee Payment Reversals")
                    {
                        Caption = 'Posted Board Payment Reversals';
                        RunObject = page "Trustee Payment Reversals-Post";
                        ToolTip = 'Executes the Posted Board Payment Reversals action';
                    }
                }

                group("Periodic Activities")
                {
                    Visible = false;
                    Caption = 'Periodic Activities';
                    action("Payroll Run-Trustees")
                    {
                        Caption = 'Payroll Run - Board Members';
                        RunObject = report "Payroll Run Trustees";
                        ToolTip = 'Executes the Payroll Run - Board Members action';
                    }

                    action("Open General Journal")
                    {
                        RunObject = page "General Journal";
                        ToolTip = 'Executes the Open General Journal action';
                        Caption = 'Open General Journal';
                    }
                    action("Export To Bank")
                    {
                        RunObject = xmlport "Payroll Export To Bank";
                        ToolTip = 'Executes the Export To Bank action';
                        Caption = 'Export To Bank';
                    }
                }

                group(Reports)
                {
                    Caption = 'Reports';
                    Visible = false;
                    group("Bank-Details")
                    {
                        Caption = 'Bank-Details';
                        action("Board Bank Details")
                        {
                            Image = "Report";
                            RunObject = report "Trustee Bank Details";
                            ToolTip = 'Executes the Board Bank Details action';
                            Caption = 'Board Bank Details';
                        }

                    }
                    group("Management-Reports ")
                    {
                        Caption = 'Management Reports';

                        action("Board Payslips ")
                        {
                            Image = NewBank;
                            RunObject = report "Trustee Payslipx";
                            ToolTip = 'Executes the Board Payslips  action';
                            Caption = 'Board Payslips ';
                        }
                        action("Earnings -Report")
                        {
                            Caption = 'Earnings Report';
                            Image = "Report";
                            RunObject = report "Trustee Earnings";
                            ToolTip = 'Executes the Earnings Report action';
                        }
                        action("Deduction-Report")
                        {
                            Caption = 'Deductions Report';
                            Image = "Report";
                            RunObject = report TrusteeDeductions;
                            ToolTip = 'Executes the Deductions Report action';
                        }
                        action("Net- Pay Report")
                        {
                            Caption = 'Net Pay report';
                            Image = "Report";
                            RunObject = report "Trustee Net Pay Bank Transfer";
                            ToolTip = 'Executes the Net Pay report action';
                        }

                        action("Board Below Pay")
                        {
                            Image = "Report";
                            RunObject = report "Trustee Below Pay";
                            ToolTip = 'Executes the Board Below Pay action';
                            Caption = 'Board Below Pay';
                        }
                        action("Board List ")
                        {
                            Image = "Report";
                            RunObject = report "Trustee - List";
                            ToolTip = 'Executes the Board List  action';
                            Caption = 'Board List ';
                        }
                        action("SACCO Reports")
                        {
                            Image = "Report";
                            RunObject = report "Trustee Sacco Report";
                            ToolTip = 'Executes the SACCO Reports action';
                            Caption = 'SACCO Reports';
                        }
                    }
                    group("Statutory-Reports")
                    {
                        Caption = 'Statutory Reports';
                        action("Monthly Payee - Report ")
                        {
                            Caption = 'Montly payee report';
                            Image = "Report";
                            RunObject = report "Trustee Monthly PAYE Report";
                            ToolTip = 'Executes the Montly payee report action';
                        }
                        action("NSSF-Reporting ")
                        {
                            Caption = 'NSSF reporting';
                            Image = "Report";
                            RunObject = report "Trustee NSSF Reporting";
                            ToolTip = 'Executes the NSSF reporting action';
                        }
                        action(NHIF)
                        {
                            Image = Migration;
                            RunObject = report TrusteeNHIF;
                            ToolTip = 'Executes the NHIF action';
                            Caption = 'NHIF';
                        }
                        action("NITA-Report")
                        {
                            Caption = 'NITA Report';
                            Image = "Report";
                            RunObject = report TrusteeNITA;
                            ToolTip = 'Executes the NITA Report action';
                        }
                        action("HELB Report")
                        {
                            Caption = 'HELB Report';
                            Image = "Report";
                            RunObject = report TrusteeHELB;
                            ToolTip = 'Executes the HELB Report action';
                        }
                        action("Pension-Report")
                        {
                            Caption = 'Pension Report';
                            Image = "Report";
                            RunObject = report "Trustee Pension Report";
                            ToolTip = 'Executes the Pension Report action';
                        }
                    }
                    group("Annual-Statutory Reports")
                    {
                        Caption = 'Annual Statutory Reports';
                        action("P9A-Report ")
                        {
                            Caption = 'P9A Report';
                            Image = ResourcePlanning;
                            RunObject = report "P9A Report-Trustees";
                            ToolTip = 'Executes the P9A Report action';
                        }
                        action("P10-Report")
                        {
                            Caption = 'P10 Report';
                            Image = "Report";
                            RunObject = report TrusteeP10;
                            ToolTip = 'Executes the P10 Report action';
                        }
                    }
                    group("Reconciliation-Reports")
                    {
                        Caption = 'Reconciliation Reports';
                        action("Monthly-Difference Report")
                        {
                            RunObject = report "Trustee Payroll Reconciliation";
                            ToolTip = 'Executes the Monthly-Difference Report action';
                            Caption = 'Monthly-Difference Report';
                        }
                        action("Board-Removed ")
                        {
                            Caption = 'Board members removed';
                            Image = ChangeCustomer;
                            RunObject = report "Trustees Removed";
                            ToolTip = 'Executes the Board members removed action';
                        }
                        action("Summary-By Centre")
                        {
                            Caption = 'Summary By Centre';
                            RunObject = report "Trustee Summary By Center_1";
                            ToolTip = 'Executes the Summary By Centre action';
                        }
                        action("Payroll- Reconciliation Summary")
                        {
                            Caption = 'Payroll Reconciliation Summary';
                            Image = Reconcile;
                            RunObject = report "Trustee Payroll Rec Summary";
                            ToolTip = 'Executes the Payroll Reconciliation Summary action';
                        }
                        action("Master-Roll Report-Old")
                        {
                            Caption = 'Master Roll Report';
                            RunObject = report "Master Roll Report-Trustees";
                            Visible = false;
                            ToolTip = 'Executes the Master Roll Report action';
                        }
                        action("Master Roll-Board")
                        {
                            Caption = 'Master Roll Report';
                            RunObject = report "Master Roll-Board Members";
                            ToolTip = 'Executes the Master Roll Report action';
                        }
                    }

                    action("PAYE Report-Trustees")
                    {
                        Caption = 'PAYE Report - Board Members';
                        RunObject = report "PAYE Report - Primary";
                        ToolTip = 'Executes the PAYE Report - Board Members action';
                    }

                }
            }
            group("Company Information ")
            {
                Image = Departments;
                Caption = 'Company Information ';
                action("Company Activities ")
                {
                    RunObject = page "Company Activities";
                    ToolTip = 'Executes the Company Activities  action';
                    Caption = 'Company Activities ';
                }
                action("Base Calender List")
                {
                    RunObject = page "Base Calendar List";
                    ToolTip = 'Executes the Base Calender List action';
                    Caption = 'Base Calender List';
                }
                action("Board of Director ")
                {
                    Visible = false;
                    RunObject = page "Board of Directors";
                    ToolTip = 'Executes the Board of Director  action';
                    Caption = 'Board of Director ';
                }
            }
            group(ContractsMGT)
            {
                Caption = 'Contracts Management';
                action(Contracts)
                {
                    RunObject = page "Employee Contracts";
                    ToolTip = 'Executes the Contracts action';
                    Caption = 'Contracts';
                }
                action("Updated Contracts")
                {
                    RunObject = page "Updated Employee Contracts";
                    ToolTip = 'Executes the Updated Contracts action';
                    Caption = 'Updated Contracts';
                }
            }
            group("Disciplinary Management")
            {
                Caption = 'Disciplinary Management';
                action("Employee Disciplinary")
                {
                    RunObject = page "Employee Disciplinary List";
                    RunPageLink = Posted = filter(false);
                    ToolTip = 'Executes the Employee Disciplinary action';
                    Caption = 'Employee Disciplinary';
                }

                action("Disciplinary Incidences")
                {
                    RunObject = page "Disciplinary Cases";
                    ToolTip = 'Executes the Disciplinary Incidences action';
                    Caption = 'Disciplinary Incidences';
                }

                action("Closed Disciplinary Cases")
                {
                    RunObject = page "Closed Disciplinary Cases";
                    ToolTip = 'Executes the Closed Disciplinary Cases action';
                    Caption = 'Closed Disciplinary Cases';
                }

                action("Disciplinary Actions")
                {
                    RunObject = page "Disciplinary Actions";
                    ToolTip = 'Executes the Disciplinary Actions action';
                    Caption = 'Disciplinary Actions';
                }
                action("Disciplinary Cases Report")
                {
                    RunObject = report "Disciplinary Cases";
                    ToolTip = 'Executes the Disciplinary Cases Report action';
                    Caption = 'Disciplinary Cases Report';
                }
            }
            group("Employee Benefits")
            {
                Caption = 'Employee Benefits';
                group("Medical Scheme")
                {
                    Caption = 'Medical Scheme';
                    action("Medical Covers")
                    {
                        RunObject = page "Medical Cover List";
                        ToolTip = 'Executes the Medical Covers action';
                        Caption = 'Medical Covers';
                    }

                    action("Medical Claims")
                    {
                        RunObject = page "Medical Claims List";
                        ToolTip = 'Executes the Medical Claims action';
                        Caption = 'Medical Claims';
                    }

                    action("Medical Ceiling Setup")
                    {
                        RunObject = page "Medical Ceiling Setup";
                        ToolTip = 'Executes the Medical Ceiling Setup action';
                        Caption = 'Medical Ceiling Setup';
                    }
                }
            }
            group("Employee Manager")
            {
                Caption = 'Employee Manager';
                action("Employee List - Active")
                {
                    RunObject = page "Employee List-Filtered";
                    ToolTip = 'Executes the Employee List - Active action';
                    Caption = 'Employee List - Active';
                }

                action("Employee List - Inactive")
                {
                    RunObject = page "Employee List Modified";
                    ToolTip = 'Executes the Employee List - Inactive action';
                    Caption = 'Employee List - Inactive';
                }

                action("Employee Contracts")
                {
                    RunObject = page "Employee Contracts";
                    ToolTip = 'Executes the Employee Contracts action';
                    Caption = 'Employee Contracts';
                }

                action("Updated Employee Contracts")
                {
                    RunObject = page "Updated Employee Contracts";
                    ToolTip = 'Executes the Updated Employee Contracts action';
                    Caption = 'Updated Employee Contracts';
                }

                action("Absence Registration")
                {
                    RunObject = page "Absence Registration";
                    ToolTip = 'Executes the Absence Registration action';
                    Caption = 'Absence Registration';
                }

                group("Employee Separation")
                {
                    action("Employee Sep")
                    {
                        RunObject = page "Employee Separation List";
                        Caption = 'Employee Separation';
                        RunPageLink = Posted = const(false);
                    }
                    action("Employee Sep Posted")
                    {
                        RunObject = page "Employee Separation List";
                        Caption = 'Employee Separation - Posted';
                        RunPageLink = Posted = const(true);
                    }
                    action("Employee Separation Report")
                    {
                        RunObject = report "Employee Separation";
                        Caption = 'Employee Separation Report';
                    }
                }

                group("Employee Reports")
                {
                    Caption = 'Employee Reports';
                    group("General")
                    {
                        Caption = 'Employee General Reports';
                        action("Employee Data")
                        {
                            Image = "Report";
                            RunObject = report "Employee Data";
                            ToolTip = 'Executes the Employee Bio Data action';
                            Caption = 'Employee Data';
                        }
                        action("Employee List")
                        {
                            Image = "Report";
                            RunObject = report "Employee - List";
                            Caption = 'Employee List';
                        }
                        action("Employee Unions")
                        {
                            Image = "Report";
                            RunObject = report "Employee - Unions";
                            Caption = 'Employee Unions';
                        }
                        action("Employee Addresses")
                        {
                            Image = "Report";
                            RunObject = report "Employee - Addresses";
                            Caption = 'Employee Addresses';
                        }
                        action("Employee Birthdays")
                        {
                            Image = "Report";
                            RunObject = report "Employee - Birthdays";
                            Caption = 'Employee Birthdays';
                        }
                        action("Employee Relatives")
                        {
                            Image = "Report";
                            RunObject = report "Employee - Relatives";
                            Caption = 'Employee Next of Kin';
                        }
                        action("Employee Qualifications")
                        {
                            Image = "Report";
                            RunObject = report "Employee - Qualifications";
                            Caption = 'Employee Qualifications';
                        }
                        action("Employee Absences by Causes")
                        {
                            Image = "Report";
                            RunObject = report "Employee - Absences by Causes";
                            Caption = 'Employee Absences by Causes';
                        }
                        action("Staff Absences")
                        {
                            Image = "Report";
                            RunObject = report "Staff Absence";
                            Caption = 'Staff Absences';
                        }

                    }
                    group("Leave -Reports")
                    {
                        Caption = 'Leave Reports';
                        action("leave balance")
                        {
                            Caption = 'Leave Balances';
                            RunObject = report "Leave Balance";
                            ToolTip = 'Executes the Leave Balances action';
                        }
                        action("leave-Statement")
                        {
                            Caption = 'Leave Statements';
                            RunObject = report "HR Staff Leave Statement";
                            ToolTip = 'Executes the Leave Statements action';
                        }
                    }
                }
                group("Employee Manager Setups")
                {
                    action("Induction Checklist Setup")
                    {
                        RunObject = page "Appointment Checklist Setup";
                        ToolTip = 'Executes the Imprest Deduction action';
                        Caption = 'Induction Checklist Setup';
                    }
                }

            }
            group("Health & Safety")
            {
                Caption = 'Health & Safety';
                action(Incidents)
                {
                    Caption = 'Incidences';
                    RunObject = page "Incident Reports";
                    RunPageLink = Sent = filter(false);
                }
                action(PendingInc)
                {
                    Caption = 'Pending Incidences';
                    RunObject = page "Incident Reports - Pending";
                    RunPageLink = Sent = filter(true);
                }
                action(SolvedInc)
                {
                    Caption = 'Incidences under review';
                    RunObject = page "Incident Reports - Solved";
                    RunPageLink = Sent = filter(true);
                }
                action(EscalatedInc)
                {
                    Caption = 'Escalated Incidences';
                    RunObject = page "Incident Reports - Escalated";
                    RunPageLink = Sent = filter(true);
                }
                action(ClosedInc)
                {
                    Caption = 'Closed Incidences';
                    RunObject = page "Incident Reports - Closed";
                    RunPageLink = Sent = filter(true);
                }
                action(ReportedInc)
                {
                    Caption = 'Reported Incidences';
                    RunObject = page "Incident Reports";
                    RunPageLink = Sent = filter(true);
                }
                action(HazardReg)
                {
                    Caption = 'Hazard Register';
                    RunObject = page "Hazard Register List";
                }
                action("User Competences")
                {
                    Caption = 'User Competence Levels';
                    RunObject = page "User Competences";
                }

                group("Incident Reports")
                {
                    Caption = 'Incident Reports';
                    action(ReportedIncident)
                    {
                        Caption = 'Reported Incidents Report';
                        RunObject = report "Incident Register";
                    }
                }
            }
            group("Job Rotation")
            {
                Caption = 'Job Rotation';
                action("Employee Transfer ")
                {
                    Caption = 'Job Rotation';
                    RunObject = page "Employee Transfer List";
                }
            }
            group("Jobs ")
            {
                Image = Job;
                Caption = 'Jobs ';
                action("Staff Establishment")
                {
                    Caption = 'Company Jobs';
                    RunObject = page "Company Job List";
                    ToolTip = 'Executes the Company Jobs action';
                }
                action("Vacant Jobs")
                {
                    RunObject = page "Vacant Positions";
                    ToolTip = 'Executes the Vacant Jobs action';
                    Caption = 'Vacant Jobs';
                }
                action("Job Specification List")
                {
                    RunObject = page "Job Specification List";
                    Visible = false;
                    ToolTip = 'Executes the Job Specification List action';
                    Caption = 'Job Specification List';
                }
                action("Job Industries")
                {
                    Caption = 'Employment Industries';
                    RunObject = page "Company Job Industries";
                    Image = Setup;
                    ToolTip = 'Executes the Employment Industries action';
                }
                action("Fields of Study")
                {
                    RunObject = page "Fields of Study";
                    Image = Setup;
                    ToolTip = 'Executes the Fields of Study action';
                    Caption = 'Fields of Study';
                }
                action("Academic Qualifications")
                {
                    RunObject = page "Academic Qualifications";
                    image = SetPriorities;
                    ToolTip = 'Executes the Academic Qualifications action';
                    Caption = 'Academic Qualifications';
                }
                action("Professional Memberships")
                {
                    RunObject = page "Prof Membership";
                    Image = Setup;
                    ToolTip = 'Executes the Professional Memberships action';
                    Caption = 'Professional Memberships';
                }

            }
            group("Leave Management")
            {
                Image = Administration;
                Caption = 'Leave Management';
                group("Leave")
                {
                    Caption = 'Leave Applications';
                    action("Leave Applications-Open")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const(Open);
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Open';
                    }
                    action("Leave Applications-Pending Approval")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const("Pending Approval");
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Pending';
                    }
                    action("Leave Applications-Approved")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const(Released);
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Approved';
                    }
                    action("Leave Applications-Rejected")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const(Rejected);
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Rejected';
                    }
                }
                group("Leave Adjustments ")
                {
                    action("Leave Adjustments")
                    {
                        RunObject = page "Leave Adjustment List";
                        RunPageLink = Posted = filter(false);
                        ToolTip = 'Executes the Leave Adjustments action';
                        Caption = 'Leave Adjustments';
                    }
                    action("Posted Leave Adjustments")
                    {
                        RunObject = page "Leave Adjustment List";
                        RunPageLink = Posted = filter(true);
                        ToolTip = 'Executes the Posted Leave Adjustments action';
                        Caption = 'Posted Leave Adjustments';
                    }
                }
                group("Leave Recalls")
                {
                    action("Leave Recall")
                    {
                        RunObject = page "Leave Recall List";
                        RunPageLink = Completed = filter(false);
                        ToolTip = 'Executes the Leave Recall action';
                        Caption = 'Leave Recall';
                    }
                    action("Completed Leave Recalls")
                    {
                        RunObject = page "Leave Recall List";
                        RunPageLink = Completed = filter(true);
                        ToolTip = 'Executes the Completed Leave Recalls action';
                        Caption = 'Completed Leave Recalls';
                    }
                }
                group("Leave Planner ")
                {
                    Caption = 'Leave Planner ';
                    action("Leave Planner")
                    {
                        RunObject = page "Leave Planner List";
                        ToolTip = 'Executes the Assign Leave Days action';
                        Caption = 'Leave Planner';
                    }
                }
                group("Leave Reports")
                {
                    Caption = 'Leave Reports';
                    action("Leave Applications Report")
                    {
                        RunObject = report "Leave Applications";
                        ToolTip = 'Executes the Leave Balances action';
                        Caption = 'Leave Applications';
                    }
                    action("Leave Balances")
                    {
                        RunObject = report "Leave Balance";
                        ToolTip = 'Executes the Leave Balances action';
                        Caption = 'Leave Balances';
                    }
                    action("Leave Statement")
                    {
                        RunObject = report "HR Staff Leave Statement";
                        ToolTip = 'Executes the Leave Statement action';
                        Caption = 'Leave Statement';
                    }
                }
                group("Leave Setups")
                {
                    Caption = 'Leave Setups';
                    action("Leave Types")
                    {
                        RunObject = page "Leave Types Setup";
                        ToolTip = 'Executes the Leave Types action';
                        Caption = 'Leave Types';
                    }
                    action("Leave Period")
                    {
                        RunObject = page "Leave Periods";
                        ToolTip = 'Executes the Leave Period action';
                        Caption = 'Leave Period';
                    }
                    action("Base Calendar")
                    {
                        RunObject = page "Base Calendar List";
                        ToolTip = 'Executes the Base Calendar List action';
                        Caption = 'Base Calendar';
                    }
                }
                group("Leave Archive")
                {
                    action("Leave Ledger")
                    {
                        RunObject = page "HR Leave Ledger Entries";
                        Caption = 'Leave Ledger Entries';
                    }
                }
            }
            group("Payroll Management")
            {
                action("Employees List - Active")
                {
                    RunObject = page "Employee List-Filtered";
                    ToolTip = 'Executes the Employee List - Active action';
                    Caption = 'Employee List - Active';
                }

                action("Employees List - Inactive")
                {
                    RunObject = page "Employee List Modified";
                    ToolTip = 'Executes the Employee List - Inactive action';
                    Caption = 'Employee List - Inactive';
                }
                group("Payroll Setups")
                {
                    Caption = 'Payroll Setups';

                    action("HR Setup")
                    {
                        RunObject = page "Human Resources Setup";
                        ToolTip = 'Executes the HR Setup action';
                        Caption = 'HR Setup';
                    }
                    action("Payroll Period")
                    {
                        RunObject = page "Pay Period";
                        ToolTip = 'Executes the Payroll Period action';
                        Caption = 'Payroll Period';
                    }
                    action(Earnings)
                    {
                        RunObject = page "Earnings";
                        ToolTip = 'Executes the Earnings action';
                        Caption = 'Earnings';
                    }
                    action(Deductions)
                    {
                        RunObject = page "Deductions";
                        ToolTip = 'Executes the Deductions action';
                        Caption = 'Deductions';
                    }
                    action("Bracket Tables")
                    {
                        RunObject = page "Bracket Table";
                        ToolTip = 'Executes the Bracket Tables action';
                        Caption = 'Bracket Tables';
                    }
                    action(Stations)
                    {
                        RunObject = page Dimensions;
                        ToolTip = 'Executes the Stations action';
                        Caption = 'Stations';
                    }
                    action("Salary Scale")
                    {
                        RunObject = page "Salary Scale";
                        ToolTip = 'Executes the Salary Scale action';
                        Caption = 'Salary Grades';
                    }
                    action("Salary Pointers")
                    {
                        RunObject = page "Salary pointer";
                        Visible = false;
                        ToolTip = 'Executes the Salary Pointers action';
                        Caption = 'Salary Steps';
                    }
                    action("Employee Posting Groups")
                    {
                        RunObject = page "Emp Posting Group";
                        ToolTip = 'Executes the Employee Posting Groups action';
                        Caption = 'Employee Posting Groups';
                    }
                    action("Employee Payment Types")
                    {
                        RunObject = page "Employee Pay Modes";
                        ToolTip = 'Executes the Employee Payment Types action';
                        Caption = 'Employee Payment Types';
                    }
                    action("Casual Pay Periods")
                    {
                        RunObject = page "Casual Pay Period";
                        Visible = false;
                        ToolTip = 'Executes the Casual Pay Periods action';
                        Caption = 'Casual Pay Periods';
                    }
                    action("Loan Product Types")
                    {
                        RunObject = page "Loan Product Types-Payroll";
                        ToolTip = 'Executes the Loan Product Types action';
                        Caption = 'Loan Product Types';
                    }
                    action(Banks)
                    {
                        Caption = 'Banks';
                        RunObject = page Banks;
                        ToolTip = 'Executes the Banks action';
                    }
                    action("Bank Branches")
                    {
                        RunObject = page "Bank Branches List";
                        ToolTip = 'Executes the Bank Branches action';
                        Caption = 'Bank Branches';
                    }
                    action(Destinations)
                    {
                        Image = Holiday;
                        RunObject = page "Destination Code";
                        ToolTip = 'Executes the Destinations action';
                        Caption = 'Destinations';
                    }
                }
                group("Payroll Approval")
                {
                    Caption = 'Payroll Approval';
                    action("Payroll Approval-Staff")
                    {
                        Image = List;
                        RunObject = page "Payroll Approval List-Staff";
                        ToolTip = 'Executes the Payroll Approval-Staff action';
                        Caption = 'Payroll Approval';
                        RunPageLink = Status = const(Open);
                    }
                    action("Payroll Approval-Pending")
                    {
                        Image = List;
                        RunObject = page "Payroll Approval List-Staff";
                        ToolTip = 'Executes the Payroll Approval-Staff action';
                        Caption = 'Payroll Approval - Pending Approval';
                        RunPageLink = Status = const("Pending Approval");
                    }
                    action("Payroll Approval-Approved")
                    {
                        Image = List;
                        RunObject = page "Payroll Approval List-Staff";
                        ToolTip = 'Executes the Payroll Approval-Staff action';
                        Caption = 'Payroll Approval - Approved';
                        RunPageLink = Status = const(Approved);
                    }
                    action("Payroll Approval- Board")
                    {
                        Image = List;
                        RunObject = page "Payroll Approval List-Board";
                        ToolTip = 'Executes the Payroll Approval- Board action';
                        Caption = 'Payroll Approval- Board';
                        Visible = false;
                    }
                }
                group("Allowance Register")
                {
                    action("Allowance Register ")
                    {
                        RunObject = page "Allowance Register List";
                        RunPageLink = Status = filter(Open);
                        ToolTip = 'Executes the Allowances Register action';
                        Caption = 'Allowance Register - New';
                    }
                    action("Allowance Register-Pending")
                    {
                        RunObject = page "Allowance Register List";
                        RunPageLink = Status = filter("Pending Approval");
                        ToolTip = 'Executes the Allowances Register action';
                        Caption = 'Allowance Register - Pending Approval';
                    }
                    action("Allowance Register-Approved")
                    {
                        RunObject = page "Allowance Register List";
                        RunPageLink = Status = filter(Approved);
                        ToolTip = 'Executes the Allowances Register action';
                        Caption = 'Allowance Register - Approved';
                    }
                    action("Allowance Register-Posted")
                    {
                        RunObject = page "Allowance Register List";
                        RunPageLink = Status = filter(Posted);
                        ToolTip = 'Executes the Allowances Register action';
                        Caption = 'Allowance Register - Posted';
                    }
                    action("Allowance Register Report")
                    {
                        RunObject = report "Allowance Register";
                        Caption = 'Allowance Register Report';
                    }
                }
                group("Pay Requests")
                {
                    Caption = 'Payroll Requests';
                    action("Payroll Requests")
                    {
                        Image = Reuse;
                        RunObject = page "Payroll Requests";
                        ToolTip = 'Executes the Payroll Requests action';
                        Caption = 'Payroll Requests';
                        RunPageView = where(Status = const(Open));
                    }
                    action("Payroll Requests-Pending")
                    {
                        Image = Reuse;
                        RunObject = page "Payroll Requests-Approved";
                        ToolTip = 'Executes the Payroll Requests action';
                        Caption = 'Payroll Requests-Pending';
                        RunPageView = where(Status = const("Pending Approval"));
                    }
                    action("Payroll Requests-Approved")
                    {
                        Image = Reuse;
                        RunObject = page "Payroll Requests-Approved";
                        ToolTip = 'Executes the Payroll Requests action';
                        Caption = 'Payroll Requests-Approved';
                        RunPageView = where(Status = const(Approved));
                    }
                    action("Payroll Requests-Posted")
                    {
                        Image = Reuse;
                        RunObject = page "Payroll Requests-Approved";
                        ToolTip = 'Executes the Payroll Requests action';
                        Caption = 'Payroll Requests-Posted';
                        RunPageView = where(Status = const(Posted));
                    }
                    action("Payroll Requests-Rejected")
                    {
                        Image = Reuse;
                        RunObject = page "Payroll Requests-Approved";
                        ToolTip = 'Executes the Payroll Requests action';
                        Caption = 'Payroll Requests-Rejected';
                        RunPageView = where(Status = const(Rejected));
                    }
                }
                group("Periodic Activities ")
                {
                    Caption = 'Periodic Activities ';
                    action("Payroll Run ")
                    {
                        Image = Column;
                        RunObject = report "Payroll Run";
                        ToolTip = 'Executes the Payroll Run  action';
                        Caption = 'Payroll Run ';
                    }
                    action("Mail Bulk Payslips")
                    {
                        Image = Column;
                        RunObject = report "Mail Bulk Payslips";
                        ToolTip = 'Sends payslips to employees in bulk';
                        Caption = 'Mail Bulk Payslips';
                    }
                    action("Transfer To Journal-Employees")
                    {
                        Caption = 'Transfer Payroll Entries To Journal';
                        RunObject = report "Transfer Journal to GL-New";
                        ToolTip = 'Executes the Transfer To Journal - Employees action';
                    }
                    action("Generate Payroll EFT")
                    {
                        RunObject = report "Generate Payroll EFT";
                        ToolTip = 'Executes the "Generate Payroll EFT action';
                        Caption = 'Generate Payroll EFT';
                    }
                }
                group("Import Earnings & Deductions ")
                {
                    Caption = 'Import Earnings & Deductions';
                    action("Import Earnings & Deductions")
                    {
                        RunObject = page "Import Earnings & Deductions";
                        ToolTip = 'Executes the Import Earnings & Deductions action';
                        Caption = 'Import Earnings & Deductions';
                    }
                    action("Imported Earnings & Deductions")
                    {
                        RunObject = page "Imported Earnings & Deductions";
                        ToolTip = 'Executes the Imported Earnings & Deductions action';
                        Caption = 'Imported Earnings & Deductions';
                    }
                }
                group("Payroll Reports")
                {
                    Caption = 'Payroll Reports';
                    group("Bank Details")
                    {
                        Caption = 'Bank Details';
                        action("Employee Bank Details")
                        {
                            Image = "Report";
                            RunObject = report "Employee Bank Details";
                            ToolTip = 'Executes the Employee Bank Details action';
                            Caption = 'Employee Bank Details';
                        }

                    }
                    group("Management Reports ")
                    {
                        Caption = 'Management Reports';
                        action("Master Roll Reports")
                        {
                            RunObject = report "Master Roll Report";
                            ToolTip = 'Executes the Master Roll Report action';
                            Caption = 'Master Roll Report';
                        }

                        action("New Payslips ")
                        {
                            Image = NewBank;
                            RunObject = report "New Payslipx";
                            ToolTip = 'Executes the New Payslips  action';
                            Caption = 'New Payslips ';
                        }
                        action("Earnings Report")
                        {
                            Image = "Report";
                            RunObject = report Earnings;
                            ToolTip = 'Executes the Earnings Report action';
                            Caption = 'Earnings Report';
                        }
                        action("Deduction Report")
                        {
                            Caption = 'Deductions Report';
                            Image = "Report";
                            RunObject = report Deductions;
                            ToolTip = 'Executes the Deductions Report action';
                        }
                        action("Net Pay Report")
                        {
                            Image = "Report";
                            RunObject = report "Net Pay Bank Transfer";
                            ToolTip = 'Executes the Net Pay Report action';
                            Caption = 'Net Pay Report';
                        }
                        action("Employee Pay Modes Summary")
                        {
                            Image = "Report";
                            RunObject = report "Employee Pay Modes";
                            ToolTip = 'Executes the Net Pay Report action';
                            Caption = 'Employee Pay Modes Summary';
                        }

                        action("Employee Below Pay")
                        {
                            Image = "Report";
                            RunObject = report "Employee Below Pay";
                            ToolTip = 'Executes the Employee Below Pay action';
                            Caption = 'Employee Below Pay';
                        }
                        action("Employee List - all")
                        {
                            Caption = 'Employee List';
                            Image = "Report";
                            RunObject = report "Employee - List";
                            ToolTip = 'Executes the Employee List action';
                        }
                        action("SACCO  Reports")
                        {
                            Image = "Report";
                            RunObject = report "Sacco Report";
                            ToolTip = 'Executes the SACCO  Reports action';
                            Caption = 'SACCO  Reports';
                        }
                    }
                    group("Statutory Reports")
                    {
                        Caption = 'Statutory Reports';
                        action("Monthly PAYE Report ")
                        {
                            Image = "Report";
                            RunObject = report "Monthly PAYE Reportx";
                            ToolTip = 'Executes the Monthly Paye Report  action';
                            Caption = 'Monthly PAYE Report ';
                        }
                        action("NSSF Reporting ")
                        {
                            Image = "Report";
                            RunObject = report "NSSF Reporting";
                            ToolTip = 'Executes the NSSF Reporting  action';
                            Caption = 'NSSF Reporting ';
                        }
                        action("NHIF ")
                        {
                            Image = Migration;
                            RunObject = report NHIF;
                            ToolTip = 'Executes the NHIF  action';
                            Caption = 'NHIF ';
                        }
                        action(HELBReport)
                        {
                            Caption = 'HELB Report';
                            Image = "Report";
                            RunObject = report HELB;
                            ToolTip = 'Executes the HELB Report action';
                        }
                        action(NITAReport)
                        {
                            Caption = 'NITA Report';
                            Image = "Report";
                            RunObject = report NITA;
                            ToolTip = 'Executes the NITA Report action';
                        }
                        action("Pension Report")
                        {
                            Image = "Report";
                            RunObject = report "Pension Report";
                            ToolTip = 'Executes the Pension Report action';
                            Caption = 'Pension Report';
                        }
                    }
                    group("Annual Statutory Reports")
                    {
                        Caption = 'Annual Statutory Reports';
                        action("P9A Report ")
                        {
                            Image = ResourcePlanning;
                            RunObject = report "P9A Report";
                            ToolTip = 'Executes the P9A Report  action';
                            Caption = 'P9A Report ';
                        }
                        action(P10Report)
                        {
                            Caption = 'P10 Report';
                            Image = "Report";
                            RunObject = report P10;
                            ToolTip = 'Executes the P10 Report action';
                        }
                    }
                    group("Reconciliation Reports")
                    {
                        Caption = 'Reconciliation Reports';
                        action("Monthly Difference Report")
                        {
                            RunObject = report "Payroll Reconciliation";
                            ToolTip = 'Executes the Monthly Difference Report action';
                            Caption = 'Monthly Difference Report';
                        }
                        action("Employees Removed ")
                        {
                            Image = ChangeCustomer;
                            RunObject = report "Employees Removed";
                            ToolTip = 'Executes the Employees Removed  action';
                            Caption = 'Employees Removed ';
                        }
                        action("Summary By Centre")
                        {
                            RunObject = report "Summary By Center_1";
                            ToolTip = 'Executes the Summary By Centre action';
                            Caption = 'Summary By Centre';
                        }
                        action("Payroll Reconciliation Summary")
                        {
                            Image = Reconcile;
                            RunObject = report "Payroll Reconciliation Summary";
                            ToolTip = 'Executes the Payroll Reconciliation Summary action';
                            Caption = 'Payroll Reconciliation Summary';
                        }
                        action("Master Roll Report")
                        {
                            RunObject = report "Master Roll Report";
                            ToolTip = 'Executes the Master Roll Report action';
                            Caption = 'Master Roll Report';
                        }
                    }
                }
            }
            group("Performance Appraisal Management")
            {
                Caption = 'Performance Management';
                action("Appraisal List")
                {
                    RunObject = page "Appraisal List";
                    ToolTip = 'Executes the Appraisal List - Objectives action';
                    Caption = 'Appraisal List';
                }

                action("Appraisal List - Pending Approval")
                {
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = Status = const("Pending Approval");
                    ToolTip = 'Executes the Appraisal List - Objectives Pending Approval action';
                    Caption = 'Appraisal List - Pending Approval';
                }
                action("Appraisal List - Further review")
                {
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = "Appraisal Status" = filter("Further review");
                    ToolTip = 'Executes the Appraisal List - Further review action';
                    Caption = 'Appraisal List - Further review';
                }
                group("Appraisals List Under Review")
                {
                    Caption = 'Appraisals List Under Review';
                    action("Appraisal List Under Review - MidYear")
                    {
                        RunObject = page "Appraisals UnderReview MidYear";
                        ToolTip = 'Executes the Appraisal List Under Review - MidYear action';
                        Caption = 'Appraisal List Under Review - MidYear';
                    }
                    action("Appraisal List Under Review - FinalYear")
                    {
                        RunObject = page "Appraisals UnderReview FY";
                        ToolTip = 'Executes the Appraisal List Under Review - FinalYear action';
                        Caption = 'Appraisal List Under Review - FinalYear';
                    }

                }
                action("Appraisal List - Completed")
                {
                    RunObject = page "Appraisal List - Completed";
                    ToolTip = 'Executes the Appraisal List - Completed action';
                    Caption = 'Appraisal List - Completed';
                }
                group("Appriasal Reports")
                {
                    Caption = 'Appriasal Reports';
                    action("Employee Appraisals")
                    {
                        RunObject = report "Employee Appraisals";
                        Caption = 'Employee Appraisals';
                    }
                }
                group("Appraisal Setup")
                {
                    Caption = 'Appraisal Setup';
                    action("Appraisal Periods")
                    {
                        RunObject = page "Appraisal Periods";
                        ToolTip = 'Executes the Appraisal Periods action';
                        Caption = 'Appraisal Periods';
                    }
                    action("Workplan Codes")
                    {
                        RunObject = page "Appraisal Workplan Codes";
                        Caption = 'Workplan Codes';
                    }
                    action("Strategic Implementation Frequency")
                    {
                        RunObject = page "Strategic Impl Frequency";
                        ToolTip = 'Executes the Strategic Implementation Frequency action';
                        Visible = false;
                        Caption = 'Strategic Implementation Frequency';
                    }
                    action("Strategic Implementation Objectives")
                    {
                        RunObject = page "Strategic Impl Objectives";
                        ToolTip = 'Executes the Strategic Implementation Objectives action';
                        Visible = false;
                        Caption = 'Strategic Implementation Objectives';
                    }
                    action("Perfomance rating matrix")
                    {
                        RunObject = page "Perfomance rating matrix";
                        ToolTip = 'Executes the Perfomance rating matrix action';
                        Visible = false;
                        Caption = 'Perfomance rating matrix';
                    }
                    action("Work related attributes")
                    {
                        RunObject = page "Work related attributes";
                        ToolTip = 'Executes the Work related attributes action';
                        Caption = 'Work related attributes';
                    }
                    action("Training Area")
                    {
                        RunObject = page "Training Areas";
                        ToolTip = 'Executes the Training Area action';
                        Caption = 'Training Area';
                    }
                    action("Skill Codes")
                    {
                        RunObject = page "Skill Codes";
                        ToolTip = 'Executes the Skill Codes action';
                        Caption = 'Skill Codes';
                    }
                    action("Developmental Actions Setup")
                    {
                        RunObject = page "Appraisal Dev Needs Setup";
                        ToolTip = 'Executes the Developmental Actions Setup action';
                        Caption = 'Developmental Actions Setup';
                    }
                }
            }
            group("Recruitment ")
            {
                Image = HRSetup;
                Caption = 'Recruitment ';
                group("Recruitment Request")
                {
                    action("Recruitment Request List")
                    {
                        RunObject = page "Recruitment Request List";
                        ToolTip = 'Executes the Recruitment Request List action';
                        Caption = 'Recruitment Requests';
                    }
                    action("Approved Recruitment Requests")
                    {
                        RunObject = page "Approved Recruitment Requests";
                        ToolTip = 'Executes the Approved Recruitment Requests action';
                        Caption = 'Approved Recruitment Requests';
                    }
                    action("Archived Recruitment Requests")
                    {
                        RunObject = page "Archived Recruitment Requests";
                        ToolTip = 'Executes the Archived Recruitment Requests action';
                        Caption = 'Archived Recruitment Requests';
                    }
                }
                group("Applicants")
                {
                    action("Applicants List")
                    {
                        RunObject = page "Applicants List";
                        RunPageLink = Submitted = const(false);
                        ToolTip = 'Executes the Applicants List action';
                        Caption = 'Applicants List';
                    }
                    action("Submitted Applications")
                    {
                        RunObject = page "Submitted Applicants";
                        RunPageLink = Submitted = const(true);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Received Application';
                    }
                }
                group("Job Applications")
                {
                    action("Job Applications ")
                    {
                        RunObject = page "Job Application List";
                        RunPageLink = "Application Status" = const(New);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - New';
                    }
                    action("Job Applications-Submitted")
                    {
                        RunObject = page "Job Application List";
                        RunPageLink = "Application Status" = const(Submitted);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Application Received';
                    }
                    // action("Job Applications- Under Shortlisting")
                    // {
                    //     RunObject = page "Job Application List";
                    //     RunPageLink = "Application Status" = const(Shortlisting);
                    //     ToolTip = 'Executes the Submitted Applications action';
                    //     Caption = 'Job Applications - Under Shortlisting';
                    // }
                    // action("Job Applications- Qualified Interview")
                    // {
                    //     RunObject = page "Job Application List";
                    //     RunPageLink = "Application Status" = const("Qualified for Interview");
                    //     ToolTip = 'Executes the Submitted Applications action';
                    //     Caption = 'Job Applications - Qualified Interview';
                    // }
                    // action("Job Applications- Non-Qualified Interview")
                    // {
                    //     RunObject = page "Job Application List";
                    //     RunPageLink = "Application Status" = const("Non-Qualified for Interview");
                    //     ToolTip = 'Executes the Submitted Applications action';
                    //     Caption = 'Job Applications - Non-Qualified Interview';
                    // }
                    // action("Job Applications- Interviewed")
                    // {
                    //     RunObject = page "Job Application List";
                    //     RunPageLink = "Application Status" = const(Interviewed);
                    //     ToolTip = 'Executes the Submitted Applications action';
                    //     Caption = 'Job Applications -Interviewed';
                    // }
                    // action("Job Applications- Hired")
                    // {
                    //     RunObject = page "Job Application List";
                    //     RunPageLink = "Application Status" = const(Hired);
                    //     ToolTip = 'Executes the Submitted Applications action';
                    //     Caption = 'Job Applications -Hired';
                    // }
                }
                group("listing")
                {
                    Caption = 'Recruitment Listing';

                    action("Recruitment Longlist ")
                    {
                        RunObject = page "Recruitment Longlist";
                        RunPageLink = "Longlisting Closed" = const(false), "Shortlisting Started" = const(true);
                        ToolTip = 'Executes the Recruitment Shortlist  action';
                        Caption = 'Recruitment Longlist';
                    }
                    action("Recruitment Shortlist ")
                    {
                        RunObject = page "Recruitment Shortlist";
                        RunPageLink = "Shortlisting Closed" = const(false), "Shortlisting Started" = const(true);
                        ToolTip = 'Executes the Recruitment Shortlist  action';
                        Caption = 'Recruitment Shortlist';
                    }
                    action("Closed Recruitment Shortlist ")
                    {
                        RunObject = page "Recruitment Shortlist";
                        RunPageLink = "Shortlisting Closed" = const(true);
                        ToolTip = 'Executes the Closed Recruitment Shortlist  action';
                        Caption = 'Closed Recruitment Shortlist';
                    }
                }
                group("Interview")
                {
                    action("Interview List ")
                    {
                        RunObject = page "Interview List";
                        ToolTip = 'Executes the Interview List  action';
                        Caption = 'Interview List';
                    }
                    action("Completed Interviews")
                    {
                        RunObject = page "Completed Interviews";
                        ToolTip = 'Executes the Completed Interviews action';
                        Caption = 'Completed Interviews';
                    }
                }
                group("Hiring Process")
                {
                    Caption = 'Onboarding Process';
                    action("Hire Qualified Interviewees")
                    {
                        RunObject = page "Qualified Interviewees";
                        ToolTip = 'Executes the Completed Interviews action';
                        Caption = 'Onboarding Process - Qualified Interviewees';
                    }
                    action("Hired Qualified Interviewees")
                    {
                        RunObject = page "Qualified Interviewees Archive";
                        ToolTip = 'Executes the Completed Interviews action';
                        Caption = 'Onboarding Process - Archive';
                    }
                }

                group("Recruitment Setups")
                {
                    Caption = 'Recruitment Setups';
                    action("Education Institutions")
                    {
                        RunObject = page "Education Intitutions";
                        ToolTip = 'Executes the Education Institutions action';
                        Caption = 'Education Institutions';
                    }
                    action("Qualification Setup")
                    {
                        RunObject = page "Qualifications Setup";
                        ToolTip = 'Executes the Qualification Setup action';
                        Caption = 'Qualification Setup';
                    }
                    action("Recruitment Stages ")
                    {
                        RunObject = page "Recruitment Stages";
                        ToolTip = 'Executes the Recruitment Stages  action';
                        Caption = 'Recruitment Stages ';
                    }
                    action("Interview Panel Members")
                    {
                        RunObject = page "Interview Panel Members";
                        ToolTip = 'Executes the Interview Panel Members action';
                        Caption = 'Interview Panel Members';
                    }
                    action("Test Parameters ")
                    {
                        RunObject = page "Test Parameters";
                        ToolTip = 'Executes the Test Parameters  action';
                        Caption = 'Test Parameters ';
                    }
                    action("Score Setup ")
                    {
                        RunObject = page "Score Setup";
                        ToolTip = 'Executes the Score Setup  action';
                        Caption = 'Score Setup ';
                        Visible = false;
                    }
                    action("Interview Setup")
                    {
                        RunObject = page "Interview Setup";
                        ToolTip = 'Executes the Interview Setup action';
                        Caption = 'Interview Setup';
                    }
                    action("Induction Checklist Setup ")
                    {
                        RunObject = page "Appointment Checklist Setup";
                        ToolTip = 'Executes the Imprest Deduction action';
                        Caption = 'Induction Checklist Setup';
                    }
                }
                group("Recruitment Reports")
                {
                    Caption = 'Recruitment Reports';

                    action("Job Applications Report")
                    {
                        RunObject = report "Job Applications";
                        Caption = 'Job Applications Report';
                    }
                    action("Job Applications Report1111")
                    {
                        RunObject = report "Appl. Submit J list";
                        Caption = 'Job Applications Reporttest';
                    }
                }
            }
            group("Staff Loans")
            {
                Image = Calculator;
                Caption = 'Staff Loans';
                group("Loan Applications")
                {
                    Caption = 'Loan Applications';

                    action("Loan Applications - New")
                    {
                        RunObject = page "Loan Application List-Payroll";
                        ToolTip = 'Executes the Loan Applications - New action';
                        Caption = 'Loan Applications - New';
                    }
                    action("Loan Applciations - Issued")
                    {
                        RunObject = page "Posted Loan List-Payroll";
                        ToolTip = 'Executes the Loan Applciations - Issued action';
                        Caption = 'Loan Applciations - Issued';
                    }
                }
                group("Loan Interest Processing")
                {
                    Caption = 'Loan Interest Processing';
                    action("Interest Processing")
                    {
                        RunObject = page "Loan Interest List-Payroll";
                        ToolTip = 'Executes the Interest Processing action';
                        Caption = 'Interest Processing';
                    }
                    action("Posted Loan Interest")
                    {
                        RunObject = page "Posted Loan Interests-Payroll";
                        ToolTip = 'Executes the Posted Loan Interest action';
                        Caption = 'Posted Loan Interest';
                    }
                    action("Reversed Loan Interest")
                    {
                        RunObject = page "Reversed Loan Interests-Payrol";
                        ToolTip = 'Executes the Reversed Loan Interest action';
                        Caption = 'Reversed Loan Interest';
                    }
                }
                group("Loan Setups")
                {
                    Caption = 'Loan Setups';
                    action("Loan Product Types ")
                    {
                        RunObject = page "Loan Product Types-Payroll";
                        ToolTip = 'Executes the Loan Product Types  action';
                        Caption = 'Loan Product Types ';
                    }
                }
            }
            group("Training Management")
            {
                Image = Capacities;
                Caption = 'Training Management';

                group("Training Budget ")
                {
                    Caption = 'Training Budget';
                    action("Training Budget")
                    {
                        RunObject = page "Training Plan";
                        ToolTip = 'Executes the Training Budget action';
                        Caption = 'Training Budget';
                    }
                }
                group("Training Needs")
                {
                    Caption = 'Training Needs';

                    action("New Training Needs")
                    {
                        RunObject = page "Training Needs Open";
                        ToolTip = 'Executes the New Training Needs action';
                        Caption = 'New Training Needs';
                    }

                    action("On-Going Training Needs")
                    {
                        RunObject = page "Training Needs Application";
                        RunPageLink = Status = filter(Application);
                        ToolTip = 'Executes the On-Going Training Needs action';
                        Caption = 'On-Going Training Needs';
                    }
                    action("Closed Training Needs")
                    {
                        RunObject = page "Training Needs Application";
                        RunPageLink = Status = filter(Closed);
                        ToolTip = 'Executes the Closed Training Needs action';
                        Caption = 'Closed Training Needs';
                    }
                    action("Cancelled Training Needs")
                    {
                        RunObject = page "Training Needs Application";
                        RunPageLink = Status = filter(Cancelled);
                        ToolTip = 'Executes the Closed Training Needs action';
                        Caption = 'Cancelled Training Needs';
                    }
                }
                group("Training Needs Requisitions")
                {
                    action("Open Training Needs Requisitions")
                    {
                        RunObject = page "Training Needs Requisitions";
                        RunPageLink = Status = filter(New);
                        ToolTip = 'Executes the Open Training Needs Requisitions action';
                        Caption = 'Open Training Needs Requisitions';
                    }
                    action("Applied Training Needs Requisitions")
                    {
                        RunObject = page "Training Needs Requisitions";
                        RunPageLink = Status = filter(Created);
                        ToolTip = 'Executes the Applied Training Needs Requisitions action';
                        Caption = 'Applied Training Needs Requisitions';
                    }
                    action("Rejected Training Needs Requisitions")
                    {
                        RunObject = page "Training Needs Requisitions";
                        RunPageLink = Status = filter(Rejected);
                        ToolTip = 'Executes the Rejected Training Needs Requisitions action';
                        Caption = 'Rejected Training Needs Requisitions';
                    }
                }
                group("Training Applications")
                {
                    Caption = 'Training Applications';
                    action("Training Request List ")
                    {
                        RunObject = page "Training Request List";
                        ToolTip = 'Executes the Training Request List  action';
                        Caption = 'Training Request List ';
                    }
                    action("Approved Training Request List ")
                    {
                        RunObject = page "Approved Training Request List";
                        ToolTip = 'Executes the Approved Training Request List  action';
                        Caption = 'Approved Training Request List ';
                    }
                }
                group("Training Evaluation")
                {
                    Caption = 'Training Evaluation';
                    action("Training Evaluations")
                    {
                        RunObject = page "Training Evaluation List";
                        ToolTip = 'Executes the Training Evaluations action';
                        Caption = 'Training Evaluations';
                    }
                }
                group("Training Reports")
                {
                    Caption = 'Training Reports';
                    action("Training Needs ")
                    {
                        RunObject = report "Training Need";
                        Caption = 'Training Needs ';
                    }
                    action("Approved Training Requests")
                    {
                        RunObject = report "Approved Training Requests";
                        Caption = 'Approved Training Requests';
                    }
                    action("Training Evaluation Report")
                    {
                        RunObject = report "Training Evaluation Report";
                        Caption = 'Training Evaluation Report';
                    }
                }
            }

        }
        area(reporting)
        {
            action("Employee Contracts ")
            {
                Image = Documents;
                RunObject = report "Employee - Contracts";
                ToolTip = 'Executes the Employee Contracts  action';
                Caption = 'Employee Contracts ';
            }
            action("Employee List ")
            {
                RunObject = report "Employee - List";
                ToolTip = 'Executes the Employee List  action';
                Caption = 'Employee List ';
            }
            action("Employee Qualifications ")
            {
                RunObject = report "Employee - Qualifications";
                ToolTip = 'Executes the Employee Qualifications  action';
                Caption = 'Employee Qualifications ';
            }
            action("Employee Relatives ")
            {
                RunObject = report "Employee - Relatives";
                ToolTip = 'Executes the Employee Relatives  action';
                Caption = 'Employee Next of Kin ';
            }
            group(Disciplinary)
            {
                Caption = 'Disciplinary';
                action("Disciplinary Cases ")
                {
                    Image = Cancel;
                    ToolTip = 'Executes the Disciplinary Cases  action';
                    Caption = 'Disciplinary Cases ';
                }
            }
            group("Transport Management Reports")
            {
                Caption = 'Transport Management Reports';
                action("Vehicle Trips ")
                {
                    RunObject = report "Vehicle Trips";
                    ToolTip = 'Executes the Vehicle Trips  action';
                    Caption = 'Vehicle Trips ';
                }
                action("Transport Requests")
                {
                    RunObject = report "Transport Requests";
                    ToolTip = 'Executes the Transport Requests action';
                    Caption = 'Transport Requests';
                }
                action("Vehicle Conditions")
                {
                    RunObject = report "Vehicle Conditions";
                    ToolTip = 'Executes the Vehicle Conditions action';
                    Caption = 'Vehicle Conditions';
                }
            }
        }
        area(creation)
        {
            action("Change password")
            {
                ToolTip = 'Executes the Change password action';
                Caption = 'Change password';
            }
        }
    }
}
















