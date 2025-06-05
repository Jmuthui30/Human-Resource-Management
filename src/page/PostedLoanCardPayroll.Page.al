page 52260 "Posted Loan Card-Payroll"
{
    ApplicationArea = All;
    Caption = 'Loan Application Form';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Payroll Loan Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan No"; Rec."Loan No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan No field';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan Product Type field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan Status field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field(Instalment; Rec.Instalment)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Instalment field';
                }
                group(Control12)
                {
                    Editable = false;
                    ShowCaption = false;

                    field("Amount Requested"; Rec."Amount Requested")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Amount Requested field';
                    }
                    field("Issued Date"; Rec."Issued Date")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Issued Date field';
                    }
                    field("Approved Amount"; Rec."Approved Amount")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Approved Amount field';
                    }
                    field("Interest Calculation Method"; Rec."Interest Calculation Method")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Interest Calculation Method field';
                    }
                    field(Repayment; Rec.Repayment)
                    {
                        Caption = 'Repayment';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Repayment field';
                    }
                    field("Interest Rate"; Rec."Interest Rate")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Interest Rate field';
                    }
                    field("Stop Loan"; Rec."Stop Loan")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Stop Loan field';

                        trigger OnValidate()
                        begin
                            if Rec."Stop Loan" = true then begin
                                AssMatrix.SetRange(AssMatrix."Employee No", Rec."Employee No");
                                AssMatrix.SetRange(Type, AssMatrix.Type::Deduction);
                                AssMatrix.SetRange("Reference No", Rec."Loan No");
                                AssMatrix.SetRange(AssMatrix.Closed, false);
                                AssMatrix.DeleteAll();
                                Message('Loan Stopped');
                            end;

                            /*if xRec."Stop Loan" then
                            begin
                            GetPayPeriod;
                            if  "Stop Loan"=false then
                            begin
                            AssMatrix.Init();
                            AssMatrix."Employee No":="Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix."Reference No":="Loan No";
                            if "Deduction Code"='' then
                            Error('Loan %1 must be associated with a deduction',"Loan Product Type")
                            else
                            AssMatrix.Code:="Deduction Code";
                            AssMatrix."Payroll Period":=BeginDate;
                            
                            AssMatrix.Description:=Description;
                            AssMatrix."Payroll Group":=Emp."Posting Group";
                            AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Repayment;
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix.Insert();
                            
                            
                            
                             Message('Loan Reactivated');
                             end else begin
                            
                            Emp.Get("Employee No");
                            AssMatrix.Init();
                            AssMatrix."Employee No":="Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix.Code:="Deduction Code";
                            AssMatrix."Payroll Period":=BeginDate;
                            AssMatrix."Reference No":="Loan No";
                            AssMatrix.Description:=Description;
                            AssMatrix."Payroll Group":=Emp."Posting Group";
                            AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Repayment;
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Insert();
                            
                            
                             Modify();
                             Message('Loan re-activated');
                            
                             end;
                            
                            
                            
                            end; */

                        end;
                    }
                    group(Control10)
                    {
                        ShowCaption = false;
                        Visible = Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate";

                        field("Flat Rate Principal"; Rec."Flat Rate Principal")
                        {
                            ToolTip = 'Specifies the value of the Flat Rate Principal field';
                        }
                        field("Flat Rate Interest"; Rec."Flat Rate Interest")
                        {
                            ToolTip = 'Specifies the value of the Flat Rate Interest field';
                        }
                    }
                    field("Paying Bank"; Rec."Paying Bank")
                    {
                        ToolTip = 'Specifies the value of the Paying Bank field';
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        ToolTip = 'Specifies the value of the Bank Name field';
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                        ToolTip = 'Specifies the value of the Payment Date field';
                    }
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
                    field("Payroll Group"; Rec."Payroll Group")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Payroll Group field';
                    }
                    field("Opening Loan"; Rec."Opening Loan")
                    {
                        ToolTip = 'Specifies the value of the Opening Loan field';
                    }
                    field("Total Repayment"; Rec."Total Repayment")
                    {
                        ToolTip = 'Specifies the value of the Total Repayment field';
                    }
                    field("Period Repayment"; Rec."Period Repayment")
                    {
                        ToolTip = 'Specifies the value of the Period Repayment field';
                    }
                    field("Debtors Code"; Rec."Debtors Code")
                    {
                        ToolTip = 'Specifies the value of the Debtors Code field';
                    }
                    field(Receipts; Rec.Receipts)
                    {
                        Visible = true;
                        ToolTip = 'Specifies the value of the Receipts field';
                    }
                    field("External Document No"; Rec."External Document No")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the External Document No field';
                    }
                    field("HELB No."; Rec."HELB No.")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the HELB No. field';
                    }
                    field("University Name"; Rec."University Name")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the University Name field';
                    }
                    field("Interest Deduction Code"; Rec."Interest Deduction Code")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Interest Deduction Code field';
                    }
                    field("Deduction Code"; Rec."Deduction Code")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Deduction Code field';
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Issue)
            {
                Caption = 'Issue';

                action("Create Schedule")
                {
                    Caption = 'Create Schedule';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Create Schedule action';

                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            //if loan has already been issued don't create new schedule
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange("Loan Category", Rec."Loan Product Type");
                            PreviewShedule.SetRange("Loan No", Rec."Loan No");
                            PreviewShedule.DeleteAll();

                            if Rec."Issued Date" = 0D then
                                Error('You must Issue date');
                            if Rec."Loan Status" = Rec."Loan Status"::Issued then
                                RunningDate := Rec."Issued Date";
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance" then
                                Rec.CreateAnnuityLoan();
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate" then
                                Rec.CreateFlatRateSchedule();
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Sacco Reducing Balance" then
                                Rec.CreateSaccoReducing();
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then
                                Rec.CreateAmortizedLoan();
                        end;
                    end;
                }
                separator(Action1000000028)
                {
                }
                action("Preview Schedule")
                {
                    Caption = 'Preview Schedule';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Preview Schedule action';

                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange(PreviewShedule."Loan Category", Rec."Loan Product Type");
                            PreviewShedule.SetRange(PreviewShedule."Loan No", Rec."Loan No");
                            Report.Run(Report::"Loan Repayment Schedule-HR", true, false, PreviewShedule);
                        end else
                            Error('Loan is Part of opening balance no schedule');
                    end;
                }
                separator(Action1000000036)
                {
                }
                action("Issue Loan")
                {
                    Caption = 'Issue Loan';
                    Image = CalculateSalesTax;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Issue Loan action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to issue Loan %1', false, Rec."Loan No") = true then
                            Payroll.PostInternalLoan(Rec);
                    end;
                }
                action("Non Payroll Receipts")
                {
                    Caption = 'Non Payroll Receipts';
                    Image = WageLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Non Payroll Receipts action';
                }
                action(SendApproval)
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    Visible = false;
                    ToolTip = 'Executes the SendApproval action';

                    trigger OnAction()
                    begin
                        if ApprovalsMngt.CheckLoanApplicationWorkflowEnabled(Rec) then
                            ApprovalsMngt.OnSendLoanApplicationRequestforApproval(Rec);
                    end;
                }
                action(CancelApproval)
                {
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the CancelApproval action';

                    trigger OnAction()
                    begin
                        ApprovalsMngt.OnCancelLoanApplicationRequestApproval(Rec);
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Approvals action';

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetCurrentKey("Document No.");
                        ApprovalEntry.SetRange("Document No.", Rec."Loan No");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.Run();
                    end;
                }
                action(UpdateSchedule)
                {
                    Image = UpdateDescription;
                    ToolTip = 'Executes the UpdateSchedule action';

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            //if loan has already been issued don't create new schedule
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange("Loan Category", Rec."Loan Product Type");
                            PreviewShedule.SetRange("Loan No", Rec."Loan No");
                            PreviewShedule.DeleteAll();

                            if Rec."Issued Date" = 0D then
                                Error('You must Issue date');
                            if Rec."Loan Status" = Rec."Loan Status"::Issued then
                                RunningDate := Rec."Issued Date";
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance" then
                                Rec.CreateAnnuityLoan();
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate" then
                                Rec.CreateFlatRateSchedule();
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Sacco Reducing Balance" then
                                Rec.CreateSaccoReducing();
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then
                                Rec.CreateAmortizedLoan();
                        end;

                        //Update Payroll Period
                        AssMatrix.Reset();
                        AssMatrix.SetRange(AssMatrix.Code, Rec."Deduction Code");
                        AssMatrix.SetRange(AssMatrix."Employee No", Rec."Employee No");
                        if AssMatrix.Find('-') then
                            repeat
                                PreviewShedule.Reset();
                                PreviewShedule.SetRange(PreviewShedule."Loan No", Rec."Loan No");
                                PreviewShedule.SetRange(PreviewShedule."Repayment Date", AssMatrix."Payroll Period");
                                if PreviewShedule.FindFirst() then begin
                                    AssMatrix.Amount := -PreviewShedule."Principal Repayment";
                                    AssMatrix."Loan Interest" := -PreviewShedule."Monthly Interest";
                                    AssMatrix.Modify();
                                end;
                            until AssMatrix.Next() = 0;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if LoanProduct.Get(Rec."Loan Product Type") then begin
            Rec.Instalment := LoanProduct."No of Instalment";
            Rec."Interest Rate" := LoanProduct."Interest Rate";
            Rec."Interest Calculation Method" := LoanProduct."Interest Calculation Method";
            Rec.Description := LoanProduct.Description;
        end;
    end;

    var
        AssMatrix: Record "Assignment Matrix";
        LoanProduct: Record "Loan Product Type-Payroll";
        PayPeriod: Record "Payroll Period";
        PreviewShedule: Record "Payroll Repayment Schedule";
        ApprovalsMngt: Codeunit "Approval Mgt HR Ext";
        Payroll: Codeunit Payroll;
        BeginDate: Date;
        RunningDate: Date;
        PayPeriodtext: Text[30];

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            PayPeriodtext := PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
        end;
    end;
}





