pageextension 52001 "EmployeeCardPageExt" extends "Employee Card"
{
    PromotedActionCategories = 'New,Process,Report,Employee,Navigate,Payroll';

    layout
    {
        modify("Employment Date")
        {
            Visible = false;
        }
        modify("Birth Date")
        {
            ShowMandatory = true;
        }
        modify("User ID")
        {
            ShowMandatory = false;
        }
        modify("Job Title")
        {
            Visible = false;
        }
        modify("Bank Branch No.")
        {
            Visible = false;
        }
        modify("Bank Account No.")
        {
            Visible = false;
        }
        modify("Employee Posting Group")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify(IBAN)
        {
            Visible = false;
        }
        modify("SWIFT Code")
        {
            Visible = false;
        }
        modify("Emplymt. Contract Code")
        {
            Visible = false;
        }
        modify("Alt. Address Code")
        {
            Visible = false;
        }
        modify("Alt. Address End Date")
        {
            Visible = false;
        }
        modify("Alt. Address Start Date")
        {
            Visible = false;
        }

        modify("Termination Date")
        {
            Visible = EmployerCodeVisible;
        }
        modify("Grounds for Term. Code")
        {
            Visible = false;

        }
        modify("Union Code")
        {
            Visible = false;
        }
        modify("Union Membership No.")
        {
            Visible = false;
        }
        modify("Statistics Group Code")
        {
            Visible = false;
        }
        modify("Resource No.")
        {
            Visible = EmployerCodeVisible;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify(Pager)
        {
            Visible = false;
        }
        modify(Extension)
        {
            Visible = false;
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                EmployerCodeVisible := false;
                if (Rec.Status = Rec.Status::Inactive) or (Rec.Status = Rec.Status::Terminated) then
                    EmployerCodeVisible := true;
                if Rec.Status = Rec.Status::Active then
                    EmployerCodeVisible := false;
            end;
        }
        modify("Inactive Date")
        {
            Visible = EmployerCodeVisible;
        }
        modify("Cause of Inactivity Code")
        {
            Editable = Rec.Status = Rec.Status::Inactive;
            //  Visible = Rec.Status = Rec.Status::Inactive;
            Visible = EmployerCodeVisible;
            trigger OnAfterValidate()
            var
                InactivityRec: Record "Cause of Inactivity";
            begin
                if InactivityRec.Get(Rec."Cause of Inactivity Code") then
                    InactiveDescription := InactivityRec.Description;
            end;
        }

        addafter("Last Name")
        {
            field("Other Name"; Rec."Other Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Other Name field.';
            }
        }
        addafter("Cause of Inactivity Code")
        {
            field(InactiveDescription; InactiveDescription)
            {
                ApplicationArea = All;
                Caption = 'Cause of Inactivity Description';
                Editable = false;
                Visible = EmployerCodeVisible;
            }
        }

        addafter("Privacy Blocked")
        {
            field("Manager/Supervisor"; Rec."Manager/Supervisor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Manager/Supervisor field.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                ApplicationArea = All;
            }
            // field("Currency Code"; Rec."Currency Code")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Currency Code field.';
            // }
            field("Base Calendar"; Rec."Base Calendar")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Base Calendar field.';
            }
        }

        addlast(Personal)
        {
            field(Disabled; Rec.Disabled)
            {
                ToolTip = 'Specifies the value of the Disabled field';
                ApplicationArea = All;

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

                field(Disability; Rec.Disability)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Disability field';
                    ApplicationArea = All;
                }
                field("Disability Certificate"; Rec."Disability Certificate")
                {
                    Caption = 'Disability Certificate No.';
                    ToolTip = 'Specifies the value of the Disability Certificate No. field';
                    ApplicationArea = All;
                }
            }
            field("Date of Birth"; Rec."Birth Date")
            {
                ApplicationArea = BasicHR;
                Caption = 'Date of Birth';
                Importance = Standard;
                ToolTip = 'Specifies the employee''s date of birth.';
                Visible = false;
            }
            field("Date of Birth - Age"; Rec."Date of Birth - Age")
            {
                Caption = ' Age';
                Importance = Standard;
                ToolTip = 'Specifies the value of the  Age field';
                ApplicationArea = All;
            }
            field("ID No."; Rec."ID No.")
            {
                ToolTip = 'Specifies the value of the ID No. field';
                ApplicationArea = All;
                Caption = 'Staff ID No';
            }
            field("Personal Email"; Rec."Personal Email")
            {
                ToolTip = 'Specifies the value of the Personal Email field';
                ApplicationArea = All;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ToolTip = 'Specifies the value of the Marital Status field';
                ApplicationArea = All;
            }
            field(Religion; Rec.Religion)
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Religion field';
                ApplicationArea = All;
            }
            field("Ethnic Origin"; Rec."Ethnic Origin")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Ethnic Origin field';
                ApplicationArea = All;
            }
            field("Ethnic Community"; Rec."Ethnic Community")
            {
                Caption = 'Ethnic Code';
                Visible = false;
                ToolTip = 'Specifies the value of the Ethnic Code field';
                ApplicationArea = All;
            }
            field("Ethnic Name"; Rec."Ethnic Name")
            {
                Caption = 'Ethnic Community';
                Visible = false;
                ToolTip = 'Specifies the value of the Ethnic Community field';
                ApplicationArea = All;
            }
            field("Home District"; Rec."Home District")
            {
                ToolTip = 'Specifies the value of the Home District field';
                ApplicationArea = All;
                Caption = 'country of Origin';
            }
            field("First Language"; Rec."First Language")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the First Language field';
                ApplicationArea = All;
            }
            field("Second Language"; Rec."Second Language")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Second Language field';
                ApplicationArea = All;
            }
            field("Other Language"; Rec."Other Language")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Other Language field';
                ApplicationArea = All;
            }
        }
        addafter("Address & Contact")
        {
            group("Employment Information")
            {
                Caption = 'Employment Information';

                field("Job Position"; Rec."Job Position")
                {
                    Caption = 'Job Position';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Position field';
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    Caption = 'Job Title';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Line Manager"; Rec."Line Manager")
                {
                    ToolTip = 'Specifies the value of the Line Manager field';
                    ApplicationArea = All;
                }
                field("Secondary Job Position"; Rec."Secondary Job Position")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Secondary Job Position field.';
                    Visible = false;
                }
                field("Secondary Job Position Title"; Rec."Secondary Job Position Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Secondary Job Position Title field.';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';
                    ToolTip = 'Specifies the value of the Employment Type field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = true;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                        ToolTip = 'Specifies the value of the Contract Type field';
                        ApplicationArea = All;
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                        ToolTip = 'Specifies the value of the Contract Number field';
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                        ToolTip = 'Specifies the value of the Contract Length field';
                        ApplicationArea = All;
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                        ToolTip = 'Specifies the value of the Contract Start Date field';
                        ApplicationArea = All;
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                        ToolTip = 'Specifies the value of the Contract End Date field';
                        ApplicationArea = All;
                    }
                    field("Contract Extension"; Rec."Contract Extension")
                    {
                        ToolTip = 'Specifies the value of the Contract Extension field';
                        ApplicationArea = All;
                    }
                    field("Contract Renewal Date"; Rec."Contract Renewal Date")
                    {
                        ToolTip = 'Specifies the value of the Contract Renewal Date field';
                        ApplicationArea = All;
                        Editable = Rec."Contract Extension" = true;
                    }
                    field("Contract Renewal Period"; Rec."Contract Renewal Period")
                    {
                        ToolTip = 'Specifies the value of the Contract Renewal Period field';
                        ApplicationArea = All;
                        Editable = Rec."Contract Extension" = true;
                    }
                }
            }
        }
        addafter("Employment Information")
        {
            group("Acting Position")
            {
                Caption = 'Acting Position';
                Editable = false;

                field("Acting No"; Rec."Acting No")
                {
                    ToolTip = 'Specifies the value of the Acting No field';
                    ApplicationArea = All;
                }
                field(Control58; Rec."Acting Position")
                {
                    ToolTip = 'Specifies the value of the Acting Position field';
                    ApplicationArea = All;
                }
                field("Acting Description"; Rec."Acting Description")
                {
                    ToolTip = 'Specifies the value of the Acting Description field';
                    ApplicationArea = All;
                }
                label("Details:")
                {
                    Style = Strong;
                    StyleExpr = true;
                    ApplicationArea = All;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                    ToolTip = 'Specifies the value of the Relieved Employee field';
                    ApplicationArea = All;
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    ToolTip = 'Specifies the value of the Relieved Name field';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                    ApplicationArea = All;
                }
                field("Reason for Acting"; Rec."Reason for Acting")
                {
                    ToolTip = 'Specifies the value of the Reason for Acting field';
                    ApplicationArea = All;
                }
            }
        }
        addlast(Payments)
        {
            field("PIN Number"; Rec."PIN Number")
            {
                ShowMandatory = true;
                Caption = 'TIN No.';
                ToolTip = 'Specifies the value of the TIN No. field';
                ApplicationArea = All;
            }
            field("NHIF No."; Rec."NHIF No")
            {
                Caption = 'NHIF No.';
                ToolTip = 'Specifies the value of the NHIF No. field';
                ApplicationArea = All;
                Visible = false;
            }
            field("SSF No."; Rec."Social Security No.")
            {
                ToolTip = 'Specifies the value of the Social Security No. field';
                ApplicationArea = All;
                Caption = 'SSF';
            }
            field("Pay Mode"; Rec."Pay Mode")
            {
                ToolTip = 'Specifies the value of the Pay Mode field';
                ApplicationArea = All;
            }
            field("Employee's Bank"; Rec."Employee's Bank")
            {
                Caption = 'Bank';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank field';
            }
            field("Employee Bank Name"; Rec."Employee Bank Name")
            {
                Caption = 'Bank Name';
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Bank Name field';
            }
            field("Bank Branch"; Rec."Bank Branch")
            {
                Caption = 'Branch';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Branch field';
            }
            field("Employee Branch Name"; Rec."Employee Branch Name")
            {
                Caption = 'Branch Name';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Branch Name field';
            }
            field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
            {
                Caption = 'Sort Code';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sort Code field';
            }
            field("Bank Account Number"; Rec."Bank Account Number")
            {
                Caption = 'Bank Account Number';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Account Number field';
            }
            field("Posting Group"; Rec."Posting Group")
            {
                Caption = 'HR Posting Group';
                ToolTip = 'Specifies the value of the HR Posting Group field';
                ApplicationArea = All;
            }
            field("Gratuity Vendor No."; Rec."Gratuity Vendor No.")
            {
                ToolTip = 'Specifies the value of the Gratuity Vendor No. field. This is used for Employees being paid Gratuity';
                ApplicationArea = All;
            }
            field("Debtor Code"; Rec."Debtor Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debtor Code field for Payroll Loan purposes';
            }
            field("Salary Advance Debtors"; Rec."Salary Advance Debtors")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salary Advance Debtors field for Payroll Loan purposes';
            }
            field("Employee Type"; Rec."Employee Type")
            {
                ToolTip = 'Specifies the value of the Employee Type field';
                ApplicationArea = All;
            }
            field("Salary Scale"; Rec."Salary Scale")
            {
                ToolTip = 'Specifies the value of the Salary Scale field';
                ApplicationArea = All;
            }
            field(Present; Rec."Present Pointer")
            {
                Caption = 'Present Step';
                ToolTip = 'Specifies the value of the Present Step field';
                ApplicationArea = All;
            }
            field("Previous Salary Scale"; Rec."Previous Salary Scale")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Previous Salary Grade field.';
                //Editable = false;
            }
            field(Previous; Rec.Previous)
            {
                Caption = 'Previous Step';
                ToolTip = 'Specifies the value of the Previous Step field';
                ApplicationArea = All;
                //Editable = false;
            }
            field(Halt; Rec.Halt)
            {
                Caption = 'Halt Step';
                Editable = false;
                ToolTip = 'Specifies the value of the Halt Step field';
                ApplicationArea = All;
            }
            field("Pays tax?"; Rec."Pays tax?")
            {
                ToolTip = 'Specifies the value of the Pays tax? field';
                ApplicationArea = All;
            }
            field("Exempt from one third rule"; Rec."Exempt from third rule")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exempt from third rule field.';
            }
            field("Secondary Employee"; Rec."Secondary Employee")
            {
                ToolTip = 'Specifies the value of the Secondary Employee field';
                ApplicationArea = All;
            }
            field("Insurance Relief"; Rec."Insurance Relief")
            {
                ToolTip = 'Specifies the value of the Insurance Relief field';
                ApplicationArea = All;
            }
            field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Pro-Rata Calculated field';
                ApplicationArea = All;
            }
            field(CurrBasicPay; CurrBasicPay)
            {
                Caption = 'Current Basic Pay';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Current Basic Pay field';
            }
            field("Basic Pay"; Rec."Basic Pay")
            {
                ToolTip = 'Specifies the value of the Basic Pay field';
                ApplicationArea = All;
            }
            field("House Allowance"; Rec."House Allowance")
            {
                ToolTip = 'Specifies the value of the House Allowance field';
                ApplicationArea = All;
            }
            field("Insurance Premium"; Rec."Insurance Premium")
            {
                Editable = false;
                ToolTip = 'Specifies the value of the Insurance Premium field';
                ApplicationArea = All;
            }
            field("Total Allowances"; Rec."Total Allowances")
            {
                ToolTip = 'Specifies the value of the Total Allowances field';
                ApplicationArea = All;
            }
            field("Total Deductions"; Rec."Total Deductions")
            {
                ToolTip = 'Specifies the value of the Total Deductions field';
                ApplicationArea = All;
            }
            field("Taxable Allowance"; Rec."Taxable Allowance")
            {
                ToolTip = 'Specifies the value of the Taxable Allowance field';
                ApplicationArea = All;
            }
            field("Cumm. PAYE"; Rec."Cumm. PAYE")
            {
                ToolTip = 'Specifies the value of the Cumm. PAYE field';
                ApplicationArea = All;
            }
        }
        addafter(Payments)
        {
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Date Of Join"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field';
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin

                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Employment Date - Age"; Rec."Employment Date - Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employment Date - Age field.';
                    Editable = false;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the ProbationPeriod field';
                    ApplicationArea = All;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    //Editable = false;
                    ToolTip = 'Specifies the value of the Probation End Date field';
                    ApplicationArea = All;
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme Join field';
                    ApplicationArea = All;
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Medical Scheme Join field';
                    ApplicationArea = All;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    //Editable = false;
                    ToolTip = 'Specifies the value of the Retirement Date field';
                    ApplicationArea = All;
                }
            }
        }
        addafter("Important Dates")
        {
        }
        addafter("Important Dates")
        {
            group(Separation)
            {
                Caption = 'Separation';

                field("Notice Period"; Rec."Notice Period")
                {
                    ToolTip = 'Specifies the value of the Notice Period field';
                    ApplicationArea = All;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ToolTip = 'Specifies the value of the Send Alert to field';
                    ApplicationArea = All;
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ToolTip = 'Specifies the value of the Served Notice Period field';
                    ApplicationArea = All;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field';
                    ApplicationArea = All;
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    ToolTip = 'Specifies the value of the Termination Category field';
                    ApplicationArea = All;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ToolTip = 'Specifies the value of the Exit Interview Date field';
                    ApplicationArea = All;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ToolTip = 'Specifies the value of the Exit Interview Done by field';
                    ApplicationArea = All;
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                    ToolTip = 'Specifies the value of the Allow Re-Employment In Future field';
                    ApplicationArea = All;
                }
            }

            group(Anniversary)
            {
                //Editable = false;
                Caption = 'Anniversary Details';
                field("Starting Period"; Rec."Starting Period")
                {
                    ToolTip = 'Specifies the value of the Starting Period field';
                    ApplicationArea = All;

                }
                field("Year Serviced"; Rec."Year Serviced")
                {
                    ToolTip = 'Specifies the value of the Year Serviced field';
                    ApplicationArea = All;
                }
                field("Incremental Month"; Rec."Incremental Month")
                {
                    ToolTip = 'Specifies the value of the Incremental Month field';
                    ApplicationArea = All;
                    Caption = '';
                    Visible = false;
                }

                field("Last Increment Date"; Rec."Last Increment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Increment Date field.';
                    Visible = false;
                }
                field("Next Increment Date"; Rec."Next Increment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Increment Date field.';
                    Visible = false;
                }
                field("Last Date Increment"; Rec."Last Date Increment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Date Increment field.';
                    Caption = 'Last Increment Date Details';
                    Visible = false;
                }
                field("Next Date Increment"; Rec."Next Date Increment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Date Increment field.';
                    Caption = 'Next Increment Date Details';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        modify(PayEmployee)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }

        addafter(History)
        {
            group(Approvals)
            {
                action("Approve")
                {
                    ApplicationArea = All;
                    Caption = 'Approve Employee';
                    Image = Action;
                    Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";
                    trigger OnAction()
                    var
                    begin
                        if Rec.Status = Rec.Status::Active then begin
                            if ApprovalMgt.CheckNewEmployeeWorkflowEnabled(Rec) then
                                ApprovalMgt.OnSendNewEmployeeApprovalRequest(Rec);
                        end;
                        // Rec.Modify();
                    end;
                }
                action("Cancel Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval';
                    Image = Action;
                    Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";
                    trigger OnAction()
                    begin
                        if ApprovalMgt.CheckNewEmployeeWorkflowEnabled(Rec) then
                            ApprovalMgt.OnCancelNewEmployeeApprovalRequest(Rec);
                    end;
                }
            }
        }
        addafter(Attachments)
        {
            action("Certificate of Service")
            {
                ApplicationArea = All;
                Image = Certificate;
                Caption = 'Certificate of Service';

                trigger OnAction()
                var
                    EmpRec: Record Employee;
                    CertOfService: Report "Employee Certificate of Servic";
                begin
                    EmpRec.Reset();
                    EmpRec.SetRange("No.", Rec."No.");
                    CertOfService.SetTableView(EmpRec);
                    CertOfService.Run();
                end;
            }
        }

        addlast(History)
        {
            action("Previous Changes")
            {
                ApplicationArea = All;
                RunObject = page "Employee Change List";
                RunPageLink = "No." = field("No.");
                RunPageMode = View;
                Image = ChangeLog;
                Caption = 'Employee Previous Changes';
            }
        }

        addlast("E&mployee")
        {
            action("Activate Employee")
            {
                ApplicationArea = All;
                Caption = 'Activate Employee';
                Image = Action;
                ToolTip = 'Open the list of relatives that are registered for the employee.';
                Enabled = Rec.Status = Rec.Status::Inactive;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Active;
                    Rec.Modify();
                end;
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
            action(Disciplinary)
            {
                Image = DeleteAllBreakpoints;
                RunObject = page "Other Incidencts";
                RunPageLink = "Employee No" = field("No.");
                ToolTip = 'Executes the Disciplinary action';
                ApplicationArea = All;
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
                ApplicationArea = All;
            }
            action("Employee Appointment Checklist")
            {
                Caption = 'Induction Checklist';
                Image = CheckList;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = page "Appointment Checklist ListPart";
                ToolTip = 'Executes the Appointment Checklist action';
                ApplicationArea = All;
            }
            // action("Employee Leaves")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Employee Leaves';
            //     Image = Alerts;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Employee Leaves Card";
            //     RunPageLink = "No." = FIELD("No.");
            // }
            action("Leave Aplications")
            {
                Image = JobResponsibility;
                Promoted = false;

                RunObject = page "Leave Application List";
                RunPageLink = "Employee No" = field("No.");
                ToolTip = 'Executes the Leave Aplications action';
                ApplicationArea = All;
            }
            action("Professional Membership")
            {
                Image = Agreement;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = page "Professional Membership";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Executes the Professional Membership action';
                ApplicationArea = All;
            }
            action(Union)
            {
                Image = Union;
                ToolTip = 'Executes the Union action';
                ApplicationArea = All;
            }
            action("Acting Positions")
            {
                Image = EditCustomer;
                RunObject = page "Acting Duties List";
                RunPageLink = "Acting Employee No." = field("No.");
                ToolTip = 'Executes the Acting Positions action';
                ApplicationArea = All;
            }
            action(Beneficiaries)
            {
                Image = Employee;
                RunObject = page "Employee Beneficiaries";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Executes the Beneficiaries action';
                ApplicationArea = All;
            }
            action("Internal Job Applications")
            {
                Image = EmployeeAgreement;
                RunObject = page "Jobs Applied";
                RunPageLink = "Applicant No." = field("No.");
                ApplicationArea = All;
            }
        }
        addlast(Processing)
        {
            group(Assign)
            {
                action("Assign Earnings")
                {
                    Caption = 'Assign Earnings';
                    RunObject = page "Payments & Deductions";
                    RunPageLink = "Employee No" = field("No."),
                              Type = const(Earning),
                              Closed = const(false);
                    ToolTip = 'Executes the Assign Earnings action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Image = CashFlow;
                }
                action("Assign Deductions")
                {
                    Caption = 'Assign Deductions';
                    RunObject = page "Payments & Deductions";
                    RunPageLink = "Employee No" = field("No."),
                              Type = const(Deduction),
                              Closed = const(false);
                    ToolTip = 'Executes the Assign Deductions action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Image = Payment;
                }
            }
            group(OpeningBalances)
            {
                Caption = 'Opening Balances';

                action("Opening Balances")
                {
                    RunObject = page "Deductions Balances";
                    RunPageLink = "Employee No" = field("No.");
                    ToolTip = 'Executes the Opening Balances action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Image = Balance;
                    Caption = 'Opening Balances and Special Amounts';
                }
            }
            group(PointerIncrementDetails)
            {
                action(SalaryPointer)
                {
                    Caption = 'Salary Increment Details';
                    RunObject = page "Salary Increment Details";
                    RunPageLink = "Employee No." = field("No.");
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Image = Costs;
                }
            }
            group(Recurring)
            {
                Visible = false;

                action("Deductions List")
                {
                    RunObject = page "Deductions";
                    ToolTip = 'Executes the Deductions List action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
                }
                action("Dispay Reccuring Earnings")
                {
                    RunObject = page "Payments & Deductions";
                    RunPageLink = "Employee No" = field("No."),
                              Type = const(Earning),
                              Frequency = const(Recurring),
                              Closed = const(false);
                    ToolTip = 'Executes the Dispay Reccuring Earnings action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
                }
                action("Display Non-reccuring Earnings")
                {
                    RunObject = page "Payments & Deductions";
                    RunPageLink = "Employee No" = field("No."),
                              Type = const(Earning),
                              Frequency = const("Non-recurring"),
                              Closed = const(false);
                    ToolTip = 'Executes the Display Non-reccuring Earnings action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
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
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
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
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
                }
            }
            group(Loans)
            {
                action("Deduction Loan")
                {
                    RunObject = page "Payments & Deductions";
                    RunPageLink = "Employee No" = field("No."),
                              Type = const(Loan),
                              Closed = const(false);
                    ToolTip = 'Executes the Deduction Loan action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
                }
                action("Savings Withdrawals")
                {
                    RunObject = page "Payments & Deductions";
                    RunPageLink = "Employee No" = field("No."),
                              Closed = const(false),
                              Type = const("Saving Scheme");
                    ToolTip = 'Executes the Savings Withdrawals action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
                }
            }
            group(DefaultAssignment)
            {
                action("Assign Default Ded/Earnings")
                {
                    Caption = 'Assign Default Earnings/Deductions';
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Executes the Assign Default Ded/Earnings action';
                    ApplicationArea = All;
                    Image = Refresh;

                    trigger OnAction()
                    var
                        AssignConfirmMsg: Label 'Are you sure you want to assign default earnings/deductions?';
                    begin
                        if confirm(AssignConfirmMsg, false) then begin
                            Payroll.DefaultEarningsDeductionsAssignment(Rec);
                            Message('Updated Successfully');
                        end;
                    end;
                }
                action("Cash Payment")
                {
                    Caption = 'Cash Payment Allocation';
                    RunObject = page "Cash Payment";
                    RunPageLink = "Employee No" = field("No.");
                    ToolTip = 'Executes the Assign Deductions action';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Image = Payment;
                }
            }
            group(Payslips)
            {
                action(Payslip)
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Payslip action';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PayPeriod.Reset();
                        PayPeriod.SetRange(Closed, false);
                        if PayPeriod.Find('-') then
                            CurrentMonth := PayPeriod."Starting Date";

                        Employee.SetRange("No.", Rec."No.");
                        Employee.SetRange("Pay Period Filter", CurrentMonth);
                        Report.Run(Report::"Payslipx New", true, false, Employee);
                    end;
                }
                action("Payroll Run")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Payroll Run action';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PayPeriod.Reset();
                        PayPeriod.SetRange(Closed, false);
                        if PayPeriod.FindLast() then begin
                            CurrentMonth := PayPeriod."Starting Date";

                            //Check to prevent calculation when under approval
                            //Commented Temporarily-Carol23032023
                            Payroll.CheckIfPayrollPeriodUnderApproval(CurrentMonth);
                            Employee.SETRANGE("No.", Employee."No.");
                            Employee.SetRange("Pay Period Filter", CurrentMonth);
                            Report.Run(Report::"Payroll Run", true, false, Employee);
                        end else
                            Error('You cannot run payroll for a closed period')
                    end;
                }
                action("Mail Payslip")
                {
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Mail Payslip action';
                    ApplicationArea = All;

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
            }
            action("Import Data")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Import Data action';
                ApplicationArea = All;

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
                ApplicationArea = All;
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

    trigger OnOpenPage()
    begin
        //   CurrPage.Editable := Rec.EnforcePayrollPermissions();

        SetNoFieldVisible();
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");

        SetContractView();
        DisabilityView := false;
        EmployerCodeVisible := false;
        if (Rec.Status = Rec.Status::Inactive) or (Rec.Status = Rec.Status::Terminated) then
            EmployerCodeVisible := true;
        if Rec.Status = Rec.Status::Active then
            EmployerCodeVisible := false;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        // if not Confirm('To update the employee details, you must use Change Request. Do you want to proceed?', true) then
        //     exit(false); // Exit without making changes if the user declines.

        // // Check if workflow is enabled
        // if ApprovalMgt.CheckNewEmployeeWorkflowEnabled(Rec) then
        //     ApprovalMgt.OnSendNewEmployeeApprovalRequest(Rec)
        // else
        //     Error('Approval Workflow is not enabled.');

        // // If everything is okay, allow the modification
        // exit(true);
        EmployerCodeVisible := false;
        if (Rec.Status = Rec.Status::Inactive) or (Rec.Status = Rec.Status::Terminated) then
            EmployerCodeVisible := true;
        if Rec.Status = Rec.Status::Active then
            EmployerCodeVisible := false;
    end;


    trigger OnAfterGetRecord()
    var
        Inactive: Boolean;

    begin
        PayPeriod.Reset();
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.FindFirst() then begin
            Employee.Copy(Rec);
            Employee.SetRange("Pay Period Filter", PayPeriod."Starting Date");
            Employee.CalcFields("Basic Pay");
            CurrBasicPay := Employee."Basic Pay";
        end;

        if Rec.Status in [Rec.Status::Inactive, Rec.Status::Terminated] then
            Inactive := true
        else
            Inactive := false;

        EmployerCodeVisible := false;
        if (Rec.Status = Rec.Status::Inactive) or (Rec.Status = Rec.Status::Terminated) then
            EmployerCodeVisible := true;
        if Rec.Status = Rec.Status::Active then
            EmployerCodeVisible := false;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        if GuiAllowed then begin
            if Rec."Birth Date" <> 0D then begin
                Rec."Date of Birth - Age" := HRDates.DetermineAge(Rec."Birth Date", Today);
                Rec.Modify();
            end;

            if Rec."Date Of Join" <> 0D then begin
                Rec."Employment Date - Age" := HRDates.DetermineAge(Rec."Date Of Join", Today);
                Rec.Modify();
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        NoDeleteEmployeeErr: Label 'You are not allowed to delete an employee';
    begin
        Error(NoDeleteEmployeeErr);
    end;

    var
        Employee: Record Employee;
        EmployeeChange: Record "Employee Change Request";
        PayPeriod: Record "Payroll Period";
        HRDates: Codeunit "Dates Management";
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
        CurrBasicPay: Decimal;
        Text0001: Label 'Do you want to send the payslip?';
        InactiveDescription: Text;
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        EmployerCodeVisible: Boolean;


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


