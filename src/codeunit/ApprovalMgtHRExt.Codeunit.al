codeunit 52005 "Approval Mgt HR Ext"

{
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle HR Ext";
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        AllowanceRegister: Record "Allowance Register";
        EmpActing: Record "Employee Acting Position";
        NewEmployeeAppraisal: Record "Employee Appraisal";
        LeaveRecall: Record "Employee Off/Holiday";
        EmployeeTransfer: Record "Employee Transfers";
        LeaveRequest: Record "Leave Application";
        LeaveAdj: Record "Leave Bal Adjustment Header";
        PayrollApproval: Record "Payroll Approval";
        PayrollChange: Record "Payroll Change Header";
        LoanApplication: Record "Payroll Loan Application";
        PayrollRequest: Record "Payroll Requests";
        RecruitmentRequest: Record "Recruitment Needs";
        TrainingReq: Record "Training Request";
        TransportRequests: Record "Travel Requests";
        Employee: Record Employee;
        StaffAppraisalApprovalLbl: Label 'Staff Appraisal-%1 for the Period between %2 - %3', Comment = '%1 = Employee Name, %2 = Period Start, %3 = Period End';
    begin
        case RecRef.Number of
            //Travel Requests
            Database::"Travel Requests":
                begin
                    RecRef.SetTable(TransportRequests);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Travel Requests";
                    ApprovalEntryArgument."Document No." := CopyStr(TransportRequests."Request No.", 1, MaxStrLen(ApprovalEntryArgument."Document No."));
                    ApprovalEntryArgument.Amount := TransportRequests."No. of Personnel";
                    ApprovalEntryArgument."Amount (LCY)" := TransportRequests."No. of Personnel";
                end;
            //Leave Application
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveApplication;
                    ApprovalEntryArgument."Document No." := LeaveRequest."Application No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Recruitment
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Recruitment;
                    ApprovalEntryArgument."Document No." := RecruitmentRequest."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //TrainingRequest
            Database::"Training Request":
                begin
                    RecRef.SetTable(TrainingReq);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::TrainingRequest;
                    ApprovalEntryArgument."Document No." := TrainingReq."Request No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Employee Transfer
            Database::"Employee Transfers":
                begin
                    RecRef.SetTable(EmployeeTransfer);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Transfer";
                    ApprovalEntryArgument."Document No." := CopyStr(EmployeeTransfer."Transfer No", 1, MaxStrLen(ApprovalEntryArgument."Document No."));
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    RecRef.SetTable(LeaveRecall);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Leave Recall";
                    ApprovalEntryArgument."Document No." := LeaveRecall."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Payroll Change
            Database::"Payroll Change Header":
                begin
                    RecRef.SetTable(PayrollChange);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Payroll Change";
                    ApprovalEntryArgument."Document No." := PayrollChange.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Payroll Request
            Database::"Payroll Requests":
                begin
                    RecRef.SetTable(PayrollRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Payroll Request";
                    ApprovalEntryArgument."Document No." := PayrollRequest."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := PayrollRequest."Code Descripton";
                    ApprovalEntryArgument.Amount := PayrollRequest.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := PayrollRequest.Amount;
                end;
            //Loan Application
            Database::"Payroll Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Payroll Loan Application";
                    ApprovalEntryArgument."Document No." := LoanApplication."Loan No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Acting and  Promotion
            Database::"Employee Acting Position":
                begin
                    RecRef.SetTable(EmpActing);

                    case EmpActing."Document Type" of
                        EmpActing."Document Type"::Acting:
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Acting";
                        EmpActing."Document Type"::Promotion:
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Promotion";
                    end;
                    ApprovalEntryArgument."Document No." := EmpActing.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdj);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveAdjustment;
                    ApprovalEntryArgument."Document No." := LeaveAdj.Code;
                    ApprovalEntryArgument.Description := 'Leave Adjustment';
                end;

            //New Emp Appraisal
            Database::"Employee Appraisal":
                begin
                    RecRef.SetTable(NewEmployeeAppraisal);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Appraisal";
                    ApprovalEntryArgument."Document No." := NewEmployeeAppraisal."Appraisal No";
                    ApprovalEntryArgument.Description := StrSubstNo(StaffAppraisalApprovalLbl, NewEmployeeAppraisal."Appraisee Name", NewEmployeeAppraisal."Period Start", NewEmployeeAppraisal."Period End");
                end;
            //Payroll Approval
            Database::"Payroll Approval":
                begin
                    RecRef.SetTable(PayrollApproval);
                    PayrollApproval.CalcFields("Total Earnings");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Staff Payroll Approval";
                    ApprovalEntryArgument."Document No." := CopyStr(PayrollApproval.Code, 1, MaxStrLen(ApprovalEntryArgument."Document No."));
                    ApprovalEntryArgument.Description := PayrollApproval."Period Description";
                    ApprovalEntryArgument.Amount := PayrollApproval."Total Earnings";
                    ApprovalEntryArgument."Amount (LCY)" := PayrollApproval."Total Earnings";
                end;
            //Allowance Register
            Database::"Allowance Register":
                begin
                    RecRef.SetTable(AllowanceRegister);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Allowance Register";
                    ApprovalEntryArgument."Document No." := AllowanceRegister."No.";
                    ApprovalEntryArgument.Description := format(AllowanceRegister."Employee Type") + ' Allowances';
                    AllowanceRegister.CalcFields("Total Amount");
                    ApprovalEntryArgument.Amount := AllowanceRegister."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := AllowanceRegister."Total Amount";
                end;
            // New Employee Approval
            Database::Employee:
                begin
                    RecRef.SetTable(Employee);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"New Employee Application";
                    ApprovalEntryArgument."Document No." := Employee."No.";
                    ApprovalEntryArgument.Description := Employee.Name;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        AllowanceRegister: Record "Allowance Register";
        EmpActing: Record "Employee Acting Position";
        NewEmployeeAppraisal: Record "Employee Appraisal";
        LeaveRecall: Record "Employee Off/Holiday";
        LeaveRequest: Record "Leave Application";
        LeaveAdj: Record "Leave Bal Adjustment Header";
        PayrollApproval: Record "Payroll Approval";
        LoanApplication: Record "Payroll Loan Application";
        PayrollRequest: Record "Payroll Requests";
        RecruitmentRequest: Record "Recruitment Needs";
        TrainingReq: Record "Training Request";
        TransportRequest: Record "Travel Requests";
        Employee: Record Employee;
    begin
        case RecRef.Number of

            //Travel Requests
            Database::"Travel Requests":
                begin
                    RecRef.SetTable(TransportRequest);
                    TransportRequest.Validate(Status, TransportRequest.Status::"Pending Approval");
                    TransportRequest.Modify(true);
                    Variant := TransportRequest;
                    IsHandled := true;
                end;
            //Leave Application
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveRequest);
                    LeaveRequest.Validate(Status, LeaveRequest.Status::"Pending Approval");
                    LeaveRequest.Modify(true);
                    Variant := LeaveRequest;
                    IsHandled := true;
                end;
            //Recruitment Needs
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentRequest);
                    RecruitmentRequest.Validate(Status, RecruitmentRequest.Status::"Pending Approval");
                    RecruitmentRequest.Modify(true);
                    Variant := RecruitmentRequest;
                    IsHandled := true;
                end;
            //TrainingRequest
            Database::"Training Request":
                begin
                    RecRef.SetTable(TrainingReq);
                    TrainingReq.Validate(Status, TrainingReq.Status::"Pending Approval");
                    TrainingReq.Modify(true);
                    Variant := TrainingReq;
                    IsHandled := true;
                end;
            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    RecRef.SetTable(LeaveRecall);
                    LeaveRecall.Validate(Status, LeaveRecall.Status::"Pending Approval");
                    LeaveRecall.Modify(true);
                    Variant := LeaveRecall;
                    IsHandled := true;
                end;
            //Loan Application
            Database::"Payroll Loan Application":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."Loan Status"::"Being Processed");
                    LoanApplication.Modify(true);
                    Variant := LoanApplication;
                    IsHandled := true;
                end;
            //EmpActing
            Database::"Employee Acting Position":
                begin
                    RecRef.SetTable(EmpActing);
                    EmpActing.Validate(Status, EmpActing.Status::"Pending Approval");
                    EmpActing.Modify(true);
                    Variant := EmpActing;
                    IsHandled := true;
                end;
            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdj);
                    LeaveAdj.Validate(Status, LeaveAdj.Status::"Pending Approval");
                    LeaveAdj.Modify(true);
                    Variant := LeaveAdj;
                    IsHandled := true;
                end;
            //New Employee Appraisal
            Database::"Employee Appraisal":
                begin
                    RecRef.SetTable(NewEmployeeAppraisal);
                    if NewEmployeeAppraisal.Status = NewEmployeeAppraisal.Status::Open then
                        NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Pending Approval")
                    else
                        NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Mid-Year Approved");
                    NewEmployeeAppraisal.Validate("Appraisal Status", NewEmployeeAppraisal."Appraisal Status"::Set);
                    NewEmployeeAppraisal.Modify(true);
                    Variant := NewEmployeeAppraisal;
                    IsHandled := true;
                end;
            //Payroll Approval
            Database::"Payroll Approval":
                begin
                    RecRef.SetTable(PayrollApproval);
                    PayrollApproval.Validate(Status, PayrollApproval.Status::"Pending Approval");
                    PayrollApproval.Modify(true);
                    Variant := PayrollApproval;
                    IsHandled := true;
                end;
            //Payroll Requests
            Database::"Payroll Requests":
                begin
                    RecRef.SetTable(PayrollRequest);
                    PayrollRequest.Validate(Status, PayrollRequest.Status::"Pending Approval");
                    PayrollRequest.Modify(true);
                    Variant := PayrollRequest;
                    IsHandled := true;
                end;
            //Allowance Register
            Database::"Allowance Register":
                begin
                    RecRef.SetTable(AllowanceRegister);
                    AllowanceRegister.Validate(Status, AllowanceRegister.Status::"Pending Approval");
                    AllowanceRegister.Modify(true);
                    Variant := AllowanceRegister;
                    IsHandled := true;
                end;
            // New Employee Approval
            Database::Employee:
                begin
                    RecRef.SetTable(Employee);
                    Employee.Validate("Approval Status", Employee."Approval Status"::"Pending Approval");
                    Employee.Modify(true);
                    Variant := Employee;
                    IsHandled := true;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure PerformActionsOnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        EmpActing: Record "Employee Acting Position";
        Leave: Record "Leave Application";
        HRMgt: Codeunit "HR Management";
    // Employee: Record Employee;
    begin
        //Employee Acting
        if EmpActing.Get(ApprovalEntry."Document No.") then begin
            EmpActing.Validate(Status, EmpActing.Status::Rejected);
            EmpActing.Modify();
        end;

        //Leave
        if Leave.Get(ApprovalEntry."Document No.") then begin
            if Confirm('Do you want to notify Leave Applicant that you have rejected their leave?', false) then
                HRMgt.NotifyLeaveApplicantOnRejection(Leave);
        end;
        // New Employee Approval
        // if Employee.Get(Employee."No.") then begin
        //     Employee.Validate("Approval Status", Employee."Approval Status"::Rejected);
        //     Employee.Modify();
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure InsertCustomApprovalEntryFields(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    var
        LeaveApp: Record "Leave Application";
        RecRef: RecordRef;
        LeaveApprovalLbl: Label 'Leave Application %1 - %2 Day(s) applied', Comment = '%1 = Employee Name, %2 = Days Applied';
    begin
        //Insert Descriptions
        case ApprovalEntry."Table ID" of
            Database::"Leave Application":
                begin
                    RecRef.Get(ApprovalEntryArgument."Record ID to Approve");
                    RecRef.SetTable(LeaveApp);
                    ApprovalEntryArgument.Description := StrSubstNo(LeaveApprovalLbl, LeaveApp."Employee Name", LeaveApp."Days Applied");
                end;

        end;
    end;


    procedure CheckTransportWorkflowEnabled(var TransportReq: Record "Travel Requests"): Boolean
    begin
        if not IsTransportWorkflowEnabled(TransportReq) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTransportWorkflowEnabled(var TransportReq: Record "Travel Requests"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TransportReq, WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode()));
    end;

    procedure CheckLeaveRequestWorkflowEnabled(var LeaveRequest: Record "Leave Application"): Boolean
    begin
        if not IsLeaveRequestWorkflowEnabled(LeaveRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveRequestWorkflowEnabled(var LeaveRequest: Record "Leave Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveRequest, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode()));
    end;

    procedure CheckRecruitmentRequestWorkflowEnabled(var RecruitmentRequest: Record "Recruitment Needs"): Boolean
    begin
        if not IsRecruitmentRequestWorkflowEnabled(RecruitmentRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsRecruitmentRequestWorkflowEnabled(var RecruitmentRequest: Record "Recruitment Needs"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(RecruitmentRequest, WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode()));
    end;

    procedure CheckTrainingRequestWorkflowEnabled(var TrainingReq: Record "Training Request"): Boolean
    begin
        if not IsTrainingRequestWorkflowEnabled(TrainingReq) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTrainingRequestWorkflowEnabled(var TrainingReq: Record "Training Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TrainingReq, WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode()));
    end;

    procedure CheckEmployeeAppraisalWorkflowEnabled(var EmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        if not IsEmployeeAppraisalWorkflowEnabled(EmployeeAppraisal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsEmployeeAppraisalWorkflowEnabled(var EmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EmployeeAppraisal, WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode()));
    end;

    procedure CheckLeaveRecallWorkflowEnabled(var LeaveRecall: Record "Employee Off/Holiday"): Boolean
    begin
        if not IsLeaveRecallWorkflowEnabled(LeaveRecall) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveRecallWorkflowEnabled(var LeaveRecall: Record "Employee Off/Holiday"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveRecall, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode()));
    end;

    procedure CheckEmployeeTransfersWorkflowEnabled(var EmployeeTransfers: Record "Employee Transfers"): Boolean
    begin
        if not IsEmployeeTransfersWorkflowEnabled(EmployeeTransfers) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsEmployeeTransfersWorkflowEnabled(var EmployeeTransfers: Record "Employee Transfers"): Boolean
    begin
        //EXIT(WorkflowManagement.CanExecuteWorkflow(EmployeeTransfers, WorkflowEventHandling.);
    end;

    procedure CheckPayrollChangeWorkflowEnabled(var "Payroll Change": Record "Payroll Change Header"): Boolean
    begin
        if not IsPayrollChangeWorkflowEnabled("Payroll Change") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPayrollChangeWorkflowEnabled(var "Payroll Change": Record "Payroll Change Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow("Payroll Change", WorkflowEventHandling.RunworkflowOnSendPayrollChangeRequestforApprovalCode()));
    end;

    procedure CheckLoanApplicationWorkflowEnabled(var LoanApplication: Record "Payroll Loan Application"): Boolean
    begin
        if not IsLoanApplicationWorkflowEnabled(LoanApplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLoanApplicationWorkflowEnabled(var LoanApplication: Record "Payroll Loan Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanApplication, WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode()));
    end;

    procedure CheckEmpActingAndPromotionWorkflowEnabled(var EmpActing: Record "Employee Acting Position"): Boolean
    begin
        if not IsEmpActingAndPromotionWorkflowEnabled(EmpActing) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsEmpActingAndPromotionWorkflowEnabled(var EmpActing: Record "Employee Acting Position"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EmpActing, WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode()));
    end;

    procedure CheckLeaveAdjWorkflowEnabled(var LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean
    begin
        if not IsLeaveAdjWorkflowEnabled(LeaveAdj) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveAdjWorkflowEnabled(var LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveAdj, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode()));
    end;

    procedure CheckNewEmpAppraisalWorkflowEnabled(var NewEmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        if not IsNewEmpAppraisalWorkflowEnabled(NewEmployeeAppraisal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsNewEmpAppraisalWorkflowEnabled(var NewEmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(NewEmployeeAppraisal, WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode()));
    end;

    //Payroll Approval
    procedure CheckPayrollApprovalWorkflowEnabled(var PayApproval: Record "Payroll Approval"): Boolean
    begin
        if not IsPayrollApprovalWorkflowEnabled(PayApproval) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPayrollApprovalWorkflowEnabled(var PayApproval: Record "Payroll Approval"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PayApproval, WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode()));
    end;

    //Payroll Rquests
    procedure CheckPayrollRequestWorkflowEnabled(var PayrollRequest: Record "Payroll Requests"): Boolean
    begin
        if not IsPayrollRequestWorkflowEnabled(PayrollRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPayrollRequestWorkflowEnabled(var PayrollRequest: Record "Payroll Requests"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PayrollRequest, WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode()));
    end;


    //Allowance Register
    procedure CheckAllowanceRegisterWorkflowEnabled(var AllowanceRegister: Record "Allowance Register"): Boolean
    begin
        if not IsAllowanceRegisterWorkflowEnabled(AllowanceRegister) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsAllowanceRegisterWorkflowEnabled(var AllowanceRegister: Record "Allowance Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(AllowanceRegister, WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode()));
    end;
    // New Employee Approval
    procedure CheckNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        if not IsNewEmployeeWorkflowEnabled(Emp) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Emp, WorkflowEventHandling.RunworkflowOnSendNewEmployeeforApprovalCode()));
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendTransportApprovalRequest(var TransportReq: Record "Travel Requests")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTransportApprovalRequest(var TransportReq: Record "Travel Requests")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRequestApproval(var LeaveRequest: Record "Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRequestApproval(var LeaveRequest: Record "Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendRecruitmentApprovalRequest(var RecruitmentRequest: Record "Recruitment Needs")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentApprovalRequest(var RecruitmentRequest: Record "Recruitment Needs")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTrainingRequestforApproval(var TrainingReq: Record "Training Request")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTrainingRequestApproval(var TrainingReq: Record "Training Request")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeAppraisalRequestforApproval(var EmployeeAppraisal: Record "Employee Appraisal")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeAppraisalApprovalRequest(var EmployeeAppraisal: Record "Employee Appraisal")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRecallRequestforApproval(var LeaveRecall: Record "Employee Off/Holiday")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRecallApprovalRequest(var LeaveRecall: Record "Employee Off/Holiday")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeTransfersRequestforApproval(var EmployeeTransfers: Record "Employee Transfers")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeTransfersApprovalRequest(var EmployeeTransfers: Record "Employee Transfers")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPayrollChangeforApproval(var "Payroll Change": Record "Payroll Change Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollChangeApproval(var "Payroll Change": Record "Payroll Change Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLoanApplicationRequestforApproval(var LoanApplication: Record "Payroll Loan Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLoanApplicationRequestApproval(var LoanApplication: Record "Payroll Loan Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendEmpActingAndPromotionRequestForApproval(var EmpActing: Record "Employee Acting Position")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmpActingAndPromotionRequestApproval(var EmpActing: Record "Employee Acting Position")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveAdjApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveAdjApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendNewEmpAppraisalRequestforApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmpAppraisalRequestApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPayrollApprovalRequest(var PayApproval: Record "Payroll Approval")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollApprovalRequest(var PayApproval: Record "Payroll Approval")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPayrollRequestForApproval(var PayrollRequest: Record "Payroll Requests")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollRequestApprovalRequest(var PayrollRequest: Record "Payroll Requests")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendAllowanceRegisterForApproval(var AllowanceRegister: Record "Allowance Register")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelAllowanceRegisterRequest(var AllowanceRegister: Record "Allowance Register")
    begin

    end;
    // New Employee Approval
    [IntegrationEvent(false, false)]
    procedure OnSendNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;
}





