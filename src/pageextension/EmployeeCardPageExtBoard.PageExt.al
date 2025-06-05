// pageextension 52041 "EmployeeCard Ext Board" extends "Employee Card"
// {
//     PromotedActionCategories = 'New,Process,Report,Employee,Navigate,Payroll';

//     layout
//     {
//         modify("Employment Date")
//         {
//             Visible = false;
//         }
//         modify("Birth Date")
//         {
//             ShowMandatory = true;
//         }
//         modify("User ID")
//         {
//             ShowMandatory = false;
//         }
//         modify("Job Title")
//         {
//             Visible = false;
//         }
//         modify("Bank Branch No.")
//         {
//             Visible = false;
//         }
//         modify("Bank Account No.")
//         {
//             Visible = false;
//         }
//         modify("Employee Posting Group")
//         {
//             Visible = false;
//         }
//         modify("Application Method")
//         {
//             Visible = false;
//         }
//         modify(IBAN)
//         {
//             Visible = false;
//         }
//         modify("SWIFT Code")
//         {
//             Visible = false;
//         }
//         modify("Emplymt. Contract Code")
//         {
//             Visible = false;
//         }
//         modify("Cause of Inactivity Code")
//         {
//             Editable = Rec.Status = Rec.Status::Inactive;

//             trigger OnAfterValidate()
//             var
//                 InactivityRec: Record "Cause of Inactivity";
//             begin
//                 if InactivityRec.Get(Rec."Cause of Inactivity Code") then
//                     InactiveDescription := InactivityRec.Description;
//             end;
//         }
//         addafter("Last Name")
//         {
//             field( Name; Rec."Other Name")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Other Name field.';
//             }
//         }
//         addafter("Cause of Inactivity Code")
//         {
//             field(InactiveDescriptions; InactiveDescription)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Cause of Inactivity Description';
//                 Editable = false;
//                 Visible = false;
//             }
//         }

//         addafter("Privacy Blocked")
//         {

//             field("Global Dimension 1 Code1"; Rec."Global Dimension 1 Code")
//             {
//                 ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
//                 ApplicationArea = All;
//             }
//             field("Global Dimension 2 Code2"; Rec."Global Dimension 2 Code")
//             {
//                 ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
//                 ApplicationArea = All;
//             }

//             field("Base Calendar Date"; Rec."Base Calendar")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Base Calendar field.';
//             }
//         }

//         addlast(Personal)
//         {




//         }
//         addafter("Address & Contact")
//         {


//             }
//         }


//         addafter(Payments)
//         {
//             group("Important Dates")
//             {
//                 Caption = 'Important Dates';

//                 field("Date Of Join"; Rec."Date Of Join")
//                 {
//                     ToolTip = 'Specifies the value of the Date Of Join field';
//                     ApplicationArea = All;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin

//                         //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
//                     end;
//                 }
//                 field("Employment Date - Age"; Rec."Employment Date - Age")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Employment Date - Age field.';
//                     Editable = false;
//                 }
//                 field("Probation Period"; ProbationPeriod)
//                 {
//                     Visible = false;
//                     ToolTip = 'Specifies the value of the ProbationPeriod field';
//                     ApplicationArea = All;
//                 }
//                 field("End Of Probation Date"; Rec."End Of Probation Date")
//                 {
//                     Caption = 'Probation End Date';
//                     //Editable = false;
//                     ToolTip = 'Specifies the value of the Probation End Date field';
//                     ApplicationArea = All;
//                 }
//                 field("Pension Scheme Join"; Rec."Pension Scheme Join")
//                 {
//                     ToolTip = 'Specifies the value of the Pension Scheme Join field';
//                     ApplicationArea = All;
//                 }
//                 field("Medical Scheme Join"; Rec."Medical Scheme Join")
//                 {
//                     ToolTip = 'Specifies the value of the Medical Scheme Join field';
//                     ApplicationArea = All;
//                 }
//                 field("Retirement Date"; Rec."Retirement Date")
//                 {
//                     //Editable = false;
//                     ToolTip = 'Specifies the value of the Retirement Date field';
//                     ApplicationArea = All;
//                 }
//             }
//         }
//         addafter("Important Dates")
//         {
//         }
//         addafter("Important Dates")
//         {
//             group(Separation)
//             {
//                 Caption = 'Separation';

//                 field("Notice Period"; Rec."Notice Period")
//                 {
//                     ToolTip = 'Specifies the value of the Notice Period field';
//                     ApplicationArea = All;
//                 }
//                 field("Send Alert to"; Rec."Send Alert to")
//                 {
//                     ToolTip = 'Specifies the value of the Send Alert to field';
//                     ApplicationArea = All;
//                 }
//                 field("Served Notice Period"; Rec."Served Notice Period")
//                 {
//                     ToolTip = 'Specifies the value of the Served Notice Period field';
//                     ApplicationArea = All;
//                 }
//                 field("Date Of Leaving"; Rec."Date Of Leaving")
//                 {
//                     ToolTip = 'Specifies the value of the Date Of Leaving field';
//                     ApplicationArea = All;
//                 }
//                 field("Termination Category"; Rec."Termination Category")
//                 {
//                     ToolTip = 'Specifies the value of the Termination Category field';
//                     ApplicationArea = All;
//                 }
//                 field("Exit Interview Date"; Rec."Exit Interview Date")
//                 {
//                     ToolTip = 'Specifies the value of the Exit Interview Date field';
//                     ApplicationArea = All;
//                 }
//                 field("Exit Interview Done by"; Rec."Exit Interview Done by")
//                 {
//                     ToolTip = 'Specifies the value of the Exit Interview Done by field';
//                     ApplicationArea = All;
//                 }
//                 field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
//                 {
//                     ToolTip = 'Specifies the value of the Allow Re-Employment In Future field';
//                     ApplicationArea = All;
//                 }
//             }

//             group(Anniversary)
//             {
//                 //Editable = false;
//                 Caption = 'Anniversary Details';

//                 field("Incremental Month"; Rec."Incremental Month")
//                 {
//                     ToolTip = 'Specifies the value of the Incremental Month field';
//                     ApplicationArea = All;
//                 }

//                 field("Last Increment Date"; Rec."Last Increment Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Last Increment Date field.';
//                 }
//                 field("Next Increment Date"; Rec."Next Increment Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Next Increment Date field.';
//                 }
//                 field("Last Date Increment"; Rec."Last Date Increment")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Last Date Increment field.';
//                     Caption = 'Last Increment Date Details';
//                 }
//                 field("Next Date Increment"; Rec."Next Date Increment")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Next Date Increment field.';
//                     Caption = 'Next Increment Date Details';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         modify(PayEmployee)
//         {
//             Visible = false;
//         }
//         modify("Ledger E&ntries")
//         {
//             Visible = false;
//         }

//         addafter(History)
//         {
//             group(Approvals)
//             {
//                 action("Approve")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Approve Employee';
//                     Image = Action;
//                     Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";
//                     trigger OnAction()
//                     var
//                     begin
//                         if Rec.Status = Rec.Status::Active then begin
//                             if ApprovalMgt.CheckNewEmployeeWorkflowEnabled(Rec) then
//                                 ApprovalMgt.OnSendNewEmployeeApprovalRequest(Rec);
//                         end;
//                         // Rec.Modify();
//                     end;
//                 }
//                 action("Cancel Approval")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Cancel Approval';
//                     Image = Action;
//                     Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";
//                     trigger OnAction()
//                     begin
//                         if ApprovalMgt.CheckNewEmployeeWorkflowEnabled(Rec) then
//                             ApprovalMgt.OnCancelNewEmployeeApprovalRequest(Rec);
//                     end;
//                 }
//             }
//         }
//         addafter(Attachments)
//         {
//             action("Certificate of Service")
//             {
//                 ApplicationArea = All;
//                 Image = Certificate;
//                 Caption = 'Certificate of Service';

//                 trigger OnAction()
//                 var
//                     EmpRec: Record Employee;
//                     CertOfService: Report "Employee Certificate of Servic";
//                 begin
//                     EmpRec.Reset();
//                     EmpRec.SetRange("No.", Rec."No.");
//                     CertOfService.SetTableView(EmpRec);
//                     CertOfService.Run();
//                 end;
//             }
//         }

//         addlast(History)
//         {

//         }

//         addlast("E&mployee")
//         {
//             action("Activate Employee")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Activate Employee';
//                 Image = Action;
//                 ToolTip = 'Open the list of relatives that are registered for the employee.';
//                 Enabled = Rec.Status = Rec.Status::Inactive;
//                 trigger OnAction()
//                 begin
//                     Rec.Status := Rec.Status::Active;
//                     Rec.Modify();
//                 end;
//             }









//         }
//         addlast(Processing)
//         {
//             group(Assign)
//             {
//                 // action("Assign Earnings")
//                 // {
//                 //     Caption = 'Assign Earnings';
//                 //     RunObject = page "Payments & Deductions";
//                 //     RunPageLink = "Employee No" = field("No."),
//                 //               Type = const(Earning),
//                 //               Closed = const(false);
//                 //     ToolTip = 'Executes the Assign Earnings action';
//                 //     ApplicationArea = All;
//                 //     Promoted = true;
//                 //     PromotedCategory = Category6;
//                 //     PromotedIsBig = true;
//                 //     Image = CashFlow;
//                 // }
//                 // action("Assign Deductions")
//                 // {
//                 //     Caption = 'Assign Deductions';
//                 //     RunObject = page "Payments & Deductions";
//                 //     RunPageLink = "Employee No" = field("No."),
//                 //               Type = const(Deduction),
//                 //               Closed = const(false);
//                 //     ToolTip = 'Executes the Assign Deductions action';
//                 //     ApplicationArea = All;
//                 //     Promoted = true;
//                 //     PromotedCategory = Category6;
//                 //     PromotedIsBig = true;
//                 //     Image = Payment;
//                 // }
//             }
//             group(OpeningBalances)
//             {
//                 Caption = 'Opening Balances';

//                 // action("Opening Balances")
//                 // {
//                 //     RunObject = page "Deductions Balances";
//                 //     RunPageLink = "Employee No" = field("No.");
//                 //     ToolTip = 'Executes the Opening Balances action';
//                 //     ApplicationArea = All;
//                 //     Promoted = true;
//                 //     PromotedCategory = Category6;
//                 //     Image = Balance;
//                 //     Caption = 'Opening Balances and Special Amounts';
//                 // }
//             }
//             group(PointerIncrementDetails)
//             {
//                 // action(SalaryPointer)
//                 // {
//                 //     Caption = 'Salary Increment Details';
//                 //     RunObject = page "Salary Increment Details";
//                 //     RunPageLink = "Employee No." = field("No.");
//                 //     ApplicationArea = All;
//                 //     Promoted = true;
//                 //     PromotedCategory = Category6;
//                 //     Image = Costs;
//                 // }
//             }
//             // group(Recurring)
//             // {
//             //     Visible = false;

//             //     action("Deductions List")
//             //     {
//             //         RunObject = page "Deductions";
//             //         ToolTip = 'Executes the Deductions List action';
//             //         ApplicationArea = All;
//             //         Promoted = true;
//             //         PromotedCategory = Category6;
//             //         Visible = false;
//             //     }
//             //     action("Dispay Reccuring Earnings")
//             //     {
//             //         RunObject = page "Payments & Deductions";
//             //         RunPageLink = "Employee No" = field("No."),
//             //                   Type = const(Earning),
//             //                   Frequency = const(Recurring),
//             //                   Closed = const(false);
//             //         ToolTip = 'Executes the Dispay Reccuring Earnings action';
//             //         ApplicationArea = All;
//             //         Promoted = true;
//             //         PromotedCategory = Category6;
//             //         Visible = false;
//             //     }
//             //     action("Display Non-reccuring Earnings")
//             //     {
//             //         RunObject = page "Payments & Deductions";
//             //         RunPageLink = "Employee No" = field("No."),
//             //                   Type = const(Earning),
//             //                   Frequency = const("Non-recurring"),
//             //                   Closed = const(false);
//             //         ToolTip = 'Executes the Display Non-reccuring Earnings action';
//             //         ApplicationArea = All;
//             //         Promoted = true;
//             //         PromotedCategory = Category6;
//             //         Visible = false;
//             //     }
//             //     action("Display Reccuring Deductions")
//             //     {
//             //         Caption = 'Display Reccuring Deductions';
//             //         RunObject = page "Payments & Deductions";
//             //         RunPageLink = "Employee No" = field("No."),
//             //                   Type = const(Deduction),
//             //                   Frequency = const(Recurring),
//             //                   Closed = const(false);
//             //         ToolTip = 'Executes the Display Reccuring Deductions action';
//             //         ApplicationArea = All;
//             //         Promoted = true;
//             //         PromotedCategory = Category6;
//             //         Visible = false;
//             //     }
//             //     action("Display Non-reccuring Deductions")
//             //     {
//             //         Caption = 'Display Non-reccuring Deductions';
//             //         RunObject = page "Payments & Deductions";
//             //         RunPageLink = "Employee No" = field("No."),
//             //                   Type = const(Deduction),
//             //                   Frequency = const("Non-recurring"),
//             //                   Closed = const(false);
//             //         ToolTip = 'Executes the Display Non-reccuring Deductions action';
//             //         ApplicationArea = All;
//             //         Promoted = true;
//             //         PromotedCategory = Category6;
//             //         Visible = false;
//             //     }
//             // }

//             group(DefaultAssignment)
//             {
//                 action("Assign Default Ded/Earnings")
//                 {
//                     Caption = 'Assign Default Earnings/Deductions';
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     ToolTip = 'Executes the Assign Default Ded/Earnings action';
//                     ApplicationArea = All;
//                     Image = Refresh;

//                     trigger OnAction()
//                     var
//                         AssignConfirmMsg: Label 'Are you sure you want to assign default earnings/deductions?';
//                     begin
//                         if confirm(AssignConfirmMsg, false) then begin
//                             Payroll.DefaultEarningsDeductionsAssignment(Rec);
//                             Message('Updated Successfully');
//                         end;
//                     end;
//                 }
//             }
//             group(Payslips)
//             {
//                 action(Payslip)
//                 {
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     ToolTip = 'Executes the Payslip action';
//                     ApplicationArea = All;

//                     trigger OnAction()
//                     begin
//                         PayPeriod.Reset();
//                         PayPeriod.SetRange(Closed, false);
//                         if PayPeriod.Find('-') then
//                             CurrentMonth := PayPeriod."Starting Date";

//                         Employee.SetRange("No.", Rec."No.");
//                         Employee.SetRange("Pay Period Filter", CurrentMonth);
//                        // Report.Run(Report::"New Payslipx", true, false, Employee);
//                     end;
//                 }
//                 action("Payroll Run")
//                 {
//                     Image = Calculate;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     ToolTip = 'Executes the Payroll Run action';
//                     ApplicationArea = All;

//                     trigger OnAction()
//                     begin
//                         PayPeriod.Reset();
//                         PayPeriod.SetRange(Closed, false);
//                         if PayPeriod.FindLast() then begin
//                             CurrentMonth := PayPeriod."Starting Date";

//                             //Check to prevent calculation when under approval
//                             //Commented Temporarily-Carol23032023
//                             Payroll.CheckIfPayrollPeriodUnderApproval(CurrentMonth);
//                             Employee.SETRANGE("No.", Employee."No.");
//                             Employee.SetRange("Pay Period Filter", CurrentMonth);
//                           //  Report.Run(Report::"Payroll Run", true, false, Employee);
//                         end else
//                             Error('You cannot run payroll for a closed period')
//                     end;
//                 }
//                 // action("Mail Payslip")
//                 // {
//                 //     Image = SendMail;
//                 //     Promoted = true;
//                 //     PromotedCategory = Category6;
//                 //     PromotedIsBig = true;
//                 //     ToolTip = 'Executes the Mail Payslip action';
//                 //     ApplicationArea = All;

//                 //     trigger OnAction()
//                 //     var
//                 //         MailBulkPayslips: Report "Mail Bulk Payslips";
//                 //     begin
//                 //         if Confirm(Text0001, false) = true then begin
//                 //             //Mail single
//                 //             Employee.Reset();
//                 //             Employee.SetRange("No.", Rec."No.");
//                 //             if Employee.FindFirst() then begin
//                 //                 MailBulkPayslips.SetTableView(Employee);
//                 //                 MailBulkPayslips.Run();
//                 //             end;
//                 //         end else
//                 //             exit;
//                 //     end;
//                 // }
//             }
//             action("Import Data")
//             {
//                 Image = Import;
//                 Promoted = true;
//                 PromotedCategory = Category6;
//                 PromotedIsBig = true;
//                 Visible = false;
//                 ToolTip = 'Executes the Import Data action';
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin
//                     Clear(EmployeeXML);
//                     EmployeeXML.Run();
//                 end;
//             }
//             action("Change Request")
//             {
//                 Image = Change;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 ToolTip = 'Executes the Change Request action';
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 begin
//                     Numb := HRMgt.EmployeeChangeReq(Rec);
//                     EmployeeChange.SetRange(Number, Numb);
//                     HRMgt.EmployeeChangeReq(Rec);
//                     Page.Run(Page::"Employee Change Card", EmployeeChange);
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         //   CurrPage.Editable := Rec.EnforcePayrollPermissions();

//         SetNoFieldVisible();
//         IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");

//         SetContractView();
//         DisabilityView := false;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         if not Confirm('To update the employee details, you must use Change Request. Do you want to proceed?', true) then
//             exit(false); // Exit without making changes if the user declines.

//         // Check if workflow is enabled
//         if ApprovalMgt.CheckNewEmployeeWorkflowEnabled(Rec) then
//             ApprovalMgt.OnSendNewEmployeeApprovalRequest(Rec)
//         else
//             Error('Approval Workflow is not enabled.');

//         // If everything is okay, allow the modification
//         exit(true);
//     end;


//     trigger OnAfterGetRecord()
//     var
//         Inactive: Boolean;
//     begin
//         PayPeriod.Reset();
//         PayPeriod.SetRange(PayPeriod."Close Pay", false);
//         if PayPeriod.FindFirst() then begin
//             Employee.Copy(Rec);
//             Employee.SetRange("Pay Period Filter", PayPeriod."Starting Date");
//             Employee.CalcFields("Basic Pay");
//             CurrBasicPay := Employee."Basic Pay";
//         end;

//         if Rec.Status in [Rec.Status::Inactive, Rec.Status::Terminated] then
//             Inactive := true
//         else
//             Inactive := false;
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         if GuiAllowed then begin
//             if Rec."Birth Date" <> 0D then begin
//                 Rec."Date of Birth - Age" := HRDates.DetermineAge(Rec."Birth Date", Today);
//                 Rec.Modify();
//             end;

//             if Rec."Date Of Join" <> 0D then begin
//                 Rec."Employment Date - Age" := HRDates.DetermineAge(Rec."Date Of Join", Today);
//                 Rec.Modify();
//             end;
//         end;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     var
//         NoDeleteEmployeeErr: Label 'You are not allowed to delete an employee';
//     begin
//         Error(NoDeleteEmployeeErr);
//     end;

//     var
//         Employee: Record Employee;
//         EmployeeChange: Record "Employee Change Request";
//         PayPeriod: Record "Payroll Period";
//         HRDates: Codeunit "Dates Management";
//         FormatAddress: Codeunit "Format Address";
//         HRMgt: Codeunit "HR Management";
//         Payroll: Codeunit Payroll;
//         EmployeeXML: XMLport "Employee Change";
//         ProbationPeriod: DateFormula;
//         ContractView: Boolean;
//         DisabilityView: Boolean;
//         IsCountyVisible: Boolean;
//         NoFieldVisible: Boolean;
//         Numb: Code[20];
//         CurrentMonth: Date;
//         CurrBasicPay: Decimal;
//         Text0001: Label 'Do you want to send the payslip?';
//         InactiveDescription: Text;
//         ApprovalMgt: Codeunit "Approval Mgt HR Ext";


//     local procedure ContractFields()
//     begin
//         /*//"Contract Type":='';
//         "Contract Number":=0;
//         "Contract Start Date":=0D;
//         "Contract End Date":=0D;
//         "Send Alert to":='';
//         Modify();
//         */

//     end;

//     local procedure Disability()
//     begin
//         if Rec."No." <> '' then
//             if Rec.Disabled = Rec.Disabled::No then
//                 DisabilityView := false
//             else
//                 DisabilityView := true;
//     end;

//     local procedure DisabilityField()
//     begin
//         Rec.Disability := '';
//     end;

//     local procedure GetCurrentPayPeriod(): Date
//     begin
//         PayPeriod.Reset();
//         PayPeriod.SetRange(Closed, false);
//         if PayPeriod.FindFirst() then
//             exit(PayPeriod."Starting Date");
//     end;

//     local procedure SetContractView()
//     begin
//         if Rec."No." <> '' then
//             if Rec."Nature of Employment" <> 'CONTRACT' then
//                 ContractView := false
//             else
//                 ContractView := true;
//     end;

//     local procedure SetNoFieldVisible()
//     var
//         DocumentNoVisibility: Codeunit DocumentNoVisibility;
//     begin
//         NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
//     end;
// }


