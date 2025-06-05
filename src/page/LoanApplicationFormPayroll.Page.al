page 52242 "Loan Application Form-Payroll"
{
    ApplicationArea = All;
    Caption = 'Loan Application Form';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Loan No field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Loan Product Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan Product Name field';
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Loan Status field';
                }
                field(Installments; Rec.Instalment)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Instalment field';
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                    ToolTip = 'Specifies the value of the Amount Requested field';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ToolTip = 'Specifies the value of the Issued Date field';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Visible = Rec."Loan Status" <> Rec."Loan Status"::Application;
                    ToolTip = 'Specifies the value of the Approved Amount field';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Interest Calculation Method field';
                }
                field(Repayment; Rec.Repayment)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Repayment field';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field';
                }
                field("Stop Loan"; Rec."Stop Loan")
                {
                    Visible = Rec."Loan Status" = Rec."Loan Status"::Issued;
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
                group("Loan Disbursement Details")
                {
                    Visible = Rec."Loan Status" = Rec."Loan Status"::Approved;

                    field("Paying Bank"; Rec."Paying Bank")
                    {
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Paying Bank field';
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Bank Name field';
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Payment Date field';
                    }
                }
                group(Dimensions)
                {
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
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
                    Editable = false;
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
                    Caption = 'Principle Deduction Code';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Principle Deduction Code field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Schedule")
            {
                Caption = 'Create Schedule';
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
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

                        case Rec."Interest Calculation Method"::"Reducing Balance" of
                            Rec."Interest Calculation Method"::"Reducing Balance":
                                Rec.CreateAnnuityLoan();
                            Rec."Interest Calculation Method"::"Flat Rate",
                            Rec."Interest Calculation Method"::"No Interest":
                                Rec.CreateFlatRateSchedule();
                            Rec."Interest Calculation Method"::"Sacco Reducing Balance":
                                Rec.CreateSaccoReducing();
                            Rec."Interest Calculation Method"::Amortised:
                                Rec.CreateAmortizedLoan();
                        end;
                    end;
                end;
            }
            separator(Action1000000028)
            {
            }
            action("Issue Loan")
            {
                Caption = 'Issue Loan';
                Image = CalculateSalesTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
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
                ToolTip = 'Executes the Non Payroll Receipts action';
            }
            action(SendApproval)
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the SendApproval action';

                trigger OnAction()
                begin
                    Rec."Loan Status" := Rec."Loan Status"::Approved;
                    Rec.Modify();

                    /* if ApprovalsMngt.CheckLoanApplicationWorkflowEnabled(Rec) then
                        ApprovalsMngt.OnSendLoanApplicationRequestforApproval(Rec); */
                end;
            }
            action(CancelApproval)
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the CancelApproval action';

                trigger OnAction()
                begin
                    ApprovalsMngt.OnCancelLoanApplicationRequestApproval(Rec);
                end;
            }
            action(Approval)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approval action';

                trigger OnAction()
                begin
                    AppEntry.Reset();
                    AppEntry.SetRange("Table ID", Database::"Payroll Loan Application");
                    AppEntry.SetRange("Document No.", Rec."Loan No");
                    ApprovalEntries.SetTableView(AppEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
        }
        area(Reporting)
        {
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
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Loan Application";
        Rec."Loan Customer Type" := Rec."Loan Customer Type"::Staff;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Loan Application";
        Rec."Loan Customer Type" := Rec."Loan Customer Type"::Staff;
    end;

    var
        AppEntry: Record "Approval Entry";
        AssMatrix: Record "Assignment Matrix";
        PayPeriod: Record "Payroll Period";
        PreviewShedule: Record "Payroll Repayment Schedule";
        ApprovalsMngt: Codeunit "Approval Mgt HR Ext";
        Payroll: Codeunit Payroll;
        ApprovalEntries: Page "Approval Entries";
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





