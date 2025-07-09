page 52108 "Payroll Role Centre"
{
    ApplicationArea = All;
    Extensible = true;
    PageType = RoleCenter;
    Caption = 'Payroll Role Centre';
    layout
    {
        area(rolecenter)
        {
            part("Payroll Cues"; "Employee Payroll Cue")
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
        }
        area(sections)
        {
            group("Employee Management")
            {
                action("Employees List - Active")
                {
                    RunObject = page "Employee List-Filtered";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Employee List - Active action';
                    Caption = 'Employee List - Active';
                }

                action("Employees List - Inactive")
                {
                    RunObject = page "Employee List Modified";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Employee List - Inactive action';
                    Caption = 'Employee List - Inactive';
                }
            }
            group("Payroll Setups")
            {
                Caption = 'Payroll Setups';

                action("HR Setup")
                {
                    RunObject = page "Human Resources Setup";
                    ApplicationArea = All;
                    ToolTip = 'Executes the HR Setup action';
                    Caption = 'HR Setup';
                }
                action("Payroll Period")
                {
                    RunObject = page "Pay Period";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Period action';
                    Caption = 'Payroll Period';
                }
                action(Earnings)
                {
                    RunObject = page "Earnings";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Earnings action';
                    Caption = 'Earnings';
                }
                action(Deductions)
                {
                    RunObject = page "Deductions";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Deductions action';
                    Caption = 'Deductions';
                }
                action("Bracket Tables")
                {
                    RunObject = page "Bracket Table";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Bracket Tables action';
                    Caption = 'Bracket Tables';
                }
                action(Stations)
                {
                    RunObject = page Dimensions;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Stations action';
                    Caption = 'Stations';
                }
                action("Salary Scale")
                {
                    RunObject = page "Salary Scale";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Salary Scale action';
                    Caption = 'Salary Grades';
                }
                action("Salary Pointers")
                {
                    RunObject = page "Salary pointer";
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Salary Pointers action';
                    Caption = 'Salary Steps';
                }
                action("Employee Posting Groups")
                {
                    RunObject = page "Emp Posting Group";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Employee Posting Groups action';
                    Caption = 'Employee Posting Groups';
                }
                action("Employee Payment Types")
                {
                    RunObject = page "Employee Pay Modes";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Employee Payment Types action';
                    Caption = 'Employee Payment Types';
                }
                action("Casual Pay Periods")
                {
                    RunObject = page "Casual Pay Period";
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Casual Pay Periods action';
                    Caption = 'Casual Pay Periods';
                }
                action("Loan Product Types")
                {
                    RunObject = page "Loan Product Types-Payroll";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Loan Product Types action';
                    Caption = 'Loan Product Types';
                }
                action(Banks)
                {
                    Caption = 'Banks';
                    ApplicationArea = All;
                    RunObject = page Banks;
                    ToolTip = 'Executes the Banks action';
                }
                action("Bank Branches")
                {
                    RunObject = page "Bank Branches List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Bank Branches action';
                    Caption = 'Bank Branches';
                }
                action(Destinations)
                {
                    Image = Holiday;
                    RunObject = page "Destination Code";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Destinations action';
                    Caption = 'Destinations';
                }
            }
            group("Payroll Approval")
            {
                Caption = 'Payroll Approval';
                //  Visible = false;
                action("Payroll Approval-Staff")
                {
                    Image = List;
                    RunObject = page "Payroll Approval List-Staff";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Approval-Staff action';
                    Caption = 'Payroll Approval';
                    RunPageLink = Status = filter(Created | open);
                    //Visible = false;
                }
                action("Payroll Approval-Pending")
                {
                    Image = List;
                    RunObject = page "Payroll Approval List-Staff";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Approval-Staff action';
                    Caption = 'Payroll Approval - Pending Approval';
                    RunPageLink = Status = const("Pending Approval");
                    //  Visible = false;
                }
                action("Payroll Approval-Approved")
                {
                    Image = List;
                    RunObject = page "Payroll Approval List-Staff";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Approval-Staff action';
                    Caption = 'Payroll Approval - Approved';
                    RunPageLink = Status = const(Approved);
                    // Visible = false;
                }
                action("Payroll Approval- Board")
                {
                    Image = List;
                    RunObject = page "Payroll Approval List-Board";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Approval- Board action';
                    Caption = 'Payroll Approval- Board';
                    //Visible = false;
                }
            }
            group("Allowance Register")
            {
                action("Allowance Register ")
                {
                    RunObject = page "Allowance Register List";
                    RunPageLink = Status = filter(Open);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Allowances Register action';
                    Caption = 'Allowance Register - New';
                }
                action("Allowance Register-Pending")
                {
                    RunObject = page "Allowance Register List";
                    RunPageLink = Status = filter("Pending Approval");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Allowances Register action';
                    Caption = 'Allowance Register - Pending Approval';
                }
                action("Allowance Register-Approved")
                {
                    RunObject = page "Allowance Register List";
                    RunPageLink = Status = filter(Approved);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Allowances Register action';
                    Caption = 'Allowance Register - Approved';
                }
                action("Allowance Register-Posted")
                {
                    RunObject = page "Allowance Register List";
                    RunPageLink = Status = filter(Posted);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Allowances Register action';
                    Caption = 'Allowance Register - Posted';
                }
                action("Allowance Register Report")
                {
                    RunObject = report "Allowance Register";
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Requests action';
                    Caption = 'Payroll Requests';
                    RunPageView = where(Status = const(Open));
                }
                action("Payroll Requests-Pending")
                {
                    Image = Reuse;
                    RunObject = page "Payroll Requests-Approved";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Requests action';
                    Caption = 'Payroll Requests-Pending';
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Payroll Requests-Approved")
                {
                    Image = Reuse;
                    RunObject = page "Payroll Requests-Approved";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Requests action';
                    Caption = 'Payroll Requests-Approved';
                    RunPageView = where(Status = const(Approved));
                }
                action("Payroll Requests-Posted")
                {
                    Image = Reuse;
                    RunObject = page "Payroll Requests-Approved";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Requests action';
                    Caption = 'Payroll Requests-Posted';
                    RunPageView = where(Status = const(Posted));
                }
                action("Payroll Requests-Rejected")
                {
                    Image = Reuse;
                    RunObject = page "Payroll Requests-Approved";
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Run  action';
                    Caption = 'Payroll Run ';
                }
                action("Mail Bulk Payslips")
                {
                    Image = Column;
                    RunObject = report "Mail Bulk Payslips";
                    ApplicationArea = All;
                    ToolTip = 'Sends payslips to employees in bulk';
                    Caption = 'Mail Bulk Payslips';
                }
                action("Transfer To Journal-Employees")
                {
                    Caption = 'Transfer Payroll Entries To Journal';
                    RunObject = report "Transfer Journal to GL-New";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Transfer To Journal - Employees action';
                }
                //"Transfer to Journal"
                action("Transfer To Journal-single")
                {
                    Caption = 'Transfer single Payroll ';
                    RunObject = report "Transfer to Journal";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Transfer To Journal - Employees action';
                }
                action("Generate Payroll EFT")
                {
                    RunObject = report "Generate Payroll EFT";
                    ApplicationArea = All;
                    ToolTip = 'Executes the "Generate Payroll EFT action';
                    Caption = 'Generate Payroll EFT';
                }

                action("Employee Timesheet")
                {
                    RunObject = page "Employee Timesheet";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Employee Timesheet action';
                    Caption = 'Employee Timesheet';
                }
            }
            group("Import Earnings & Deductions ")
            {
                Caption = 'Import Earnings & Deductions';
                action("Import Earnings & Deductions")
                {
                    RunObject = page "Import Earnings & Deductions";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Import Earnings & Deductions action';
                    Caption = 'Import Earnings & Deductions';
                }
                action("Imported Earnings & Deductions")
                {
                    RunObject = page "Imported Earnings & Deductions";
                    ApplicationArea = All;
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
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        ToolTip = 'Executes the Master Roll Report action';
                        Caption = 'Master Roll Report';
                        Visible = false;
                    }

                    action("Master Roll Reports New")
                    {
                        RunObject = report "Master Roll Report new";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Master Roll Report action';
                        Caption = 'Master Roll Report';
                    }
                    action("New Payslips ")
                    {
                        Image = NewBank;
                        RunObject = report "New Payslipx";
                        ApplicationArea = All;
                        ToolTip = 'Executes the New Payslips  action';
                        Caption = 'New Payslips ';
                    }
                    action("Earnings Report")
                    {
                        Image = "Report";
                        RunObject = report Earnings;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Earnings Report action';
                        Caption = 'Earnings Report';
                    }
                    action("Deduction Report")
                    {
                        Caption = 'Deductions Report';
                        Image = "Report";
                        RunObject = report Deductions;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Deductions Report action';
                    }
                    action("Net Pay Report")
                    {
                        Image = "Report";
                        RunObject = report "Net Pay Bank Transfer";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Net Pay Report action';
                        Caption = 'Net Pay Report';
                    }
                    action("Net Pay cash Report")
                    {
                        Image = "Report";
                        RunObject = report "Net Pay Cash Payment";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Net Pay Report action';
                        Caption = 'Net Pay Cash Report';
                        Visible = false;
                    }
                    action("Pay cash Report")
                    {
                        Image = "Report";
                        RunObject = report "Cash payment Report";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Net Pay Report action';
                        Caption = 'Net Pay Cash Payment';
                    }
                    action("Employee Pay Modes Summary")
                    {
                        Image = "Report";
                        RunObject = report "Employee Pay Modes";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Net Pay Report action';
                        Caption = 'Employee Pay Modes Summary';
                    }

                    action("Employee Below Pay")
                    {
                        Image = "Report";
                        RunObject = report "Employee Below Pay";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Employee Below Pay action';
                        Caption = 'Employee Below Pay';
                    }
                    action("Employee List - all")
                    {
                        Caption = 'Employee List';
                        Image = "Report";
                        RunObject = report "Employee - List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Employee List action';
                    }
                    action("SACCO  Reports")
                    {
                        Image = "Report";
                        RunObject = report "Sacco Report";
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        ToolTip = 'Executes the Monthly Paye Report  action';
                        Caption = 'Monthly PAYE Report ';
                    }
                    action("NSSF Reporting ")
                    {
                        Image = "Report";
                        RunObject = report "NSSF Reporting";
                        ApplicationArea = All;
                        ToolTip = 'Executes the NSSF Reporting  action';
                        Caption = 'NSSF Reporting ';
                    }
                    action("NHIF ")
                    {
                        Image = Migration;
                        RunObject = report NHIF;
                        ApplicationArea = All;
                        ToolTip = 'Executes the NHIF  action';
                        Caption = 'NHIF ';
                    }
                    action(HELBReport)
                    {
                        Caption = 'HELB Report';
                        Image = "Report";
                        ApplicationArea = All;
                        RunObject = report HELB;
                        ToolTip = 'Executes the HELB Report action';
                    }
                    action(NITAReport)
                    {
                        Caption = 'NITA Report';
                        Image = "Report";
                        ApplicationArea = All;
                        RunObject = report NITA;
                        ToolTip = 'Executes the NITA Report action';
                    }
                    action("Pension Report")
                    {
                        Image = "Report";
                        RunObject = report "Pension Report";
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        ToolTip = 'Executes the P9A Report  action';
                        Caption = 'P9A Report ';
                    }
                    action(P10Report)
                    {
                        Caption = 'P10 Report';
                        Image = "Report";
                        RunObject = report P10;
                        ApplicationArea = All;
                        ToolTip = 'Executes the P10 Report action';
                    }
                }
                group("Reconciliation Reports")
                {
                    Caption = 'Reconciliation Reports';
                    action("Monthly Difference Report")
                    {
                        RunObject = report "Payroll Reconciliation";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Monthly Difference Report action';
                        Caption = 'Monthly Difference Report';
                    }
                    action("Employees Removed ")
                    {
                        Image = ChangeCustomer;
                        RunObject = report "Employees Removed";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Employees Removed  action';
                        Caption = 'Employees Removed ';
                    }
                    action("Summary By Centre")
                    {
                        RunObject = report "Summary By Center_1";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Summary By Centre action';
                        Caption = 'Summary By Centre';
                    }
                    action("Payroll Reconciliation Summary")
                    {
                        Image = Reconcile;
                        RunObject = report "Payroll Reconciliation Summary";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Payroll Reconciliation Summary action';
                        Caption = 'Payroll Reconciliation Summary';
                    }
                    action("Master Roll Report")
                    {
                        RunObject = report "Master Roll Report";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Master Roll Report action';
                        Caption = 'Master Roll Report';
                    }
                }
            }
            group("Loan ")
            {
                Image = Calculator;

                group("Loan Applications")
                {
                    action("Loan Applications - New")
                    {
                        RunObject = page "Loan Application List-Payroll";
                        ToolTip = 'Executes the Loan Applications - New action';
                    }
                    action("Loan Applciations - Issued")
                    {
                        RunObject = page "Posted Loan List-Payroll";
                        ToolTip = 'Executes the Loan Applciations - Issued action';
                    }
                }
                group("Loan Interest Processing")
                {
                    action("Interest Processing")
                    {
                        RunObject = page "Loan Interest List-Payroll";
                        ToolTip = 'Executes the Interest Processing action';
                    }
                    action("Posted Loan Interest")
                    {
                        RunObject = page "Posted Loan Interests-Payroll";
                        ToolTip = 'Executes the Posted Loan Interest action';
                    }
                    action("Reversed Loan Interest")
                    {
                        RunObject = page "Reversed Loan Interests-Payrol";
                        ToolTip = 'Executes the Reversed Loan Interest action';
                    }
                }
                group("Loan Setups")
                {
                    action("Loan Product Types ")
                    {
                        RunObject = page "Loan Product Types-Payroll";
                        ToolTip = 'Executes the Loan Product Types  action';
                    }
                }
            }
        }
        area(processing)
        {
            action("Human Resources Setup")
            {
                RunObject = page "Human Resources Setup";
                ToolTip = 'Executes the Human Resources Setup action';
            }
        }
    }
}





