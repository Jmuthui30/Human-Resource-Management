codeunit 52006 "Wkfl Event Handle HR Ext"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        AllowanceRegisterCancelApprovalRequestDescTxt: Label 'An approval request for a Allowance Register is cancelled ';
        AllowanceRegisterSendforApprovalDescTxt: Label 'An approval for a Allowance Register is requested';
        EmpActingPromotionCancelApprovalTxt: Label 'An Approval for Employee acting and promotion is cancelled';
        EmpActingPromotionSendForApprovalTxt: Label 'An Approval for Employee acting and promotion is requested';
        EmployeeAppraisalCancelApprovalRequestDescTxt: Label 'An approval request for Employee Appraisal is cancelled';
        EmployeeAppraisalRequestSendforApprovalDescTxt: Label 'An approval request for Employee Appraisal is requested';
        LeaveAdjCancelApprovalTxt: Label 'An approval request for Leave Adjustment is cancelled';
        LeaveAdjSendApprovalTxt: Label 'An approval request for Leave Adjustment is requested';
        LeaveRecallApprovalRequestDescTxt: Label 'An approval for Leave Recall is requested';
        LeaveRecallCancelApprovalRequestDescTxt: Label 'An approval request for Leave Recall is cancelled';
        LeaveRequestCancelApprovalRequestDescTxt: Label 'An approval for Leave Application is cancelled ';
        LeaveRequestSendforApprovalDescTxt: Label 'An approval for Leave Application is requested';
        NewEmpAppraisalApprovalDescTxt: Label 'An approval for a new Employee Appraisal Request is requested ';
        NewEmpAppraisalCancelApprovalDescTxt: Label 'An approval for a new Employee Appraisal Request is cancelled';
        PayrollApprovalSendForApprovalEventDescTxt: Label 'Approval for a Payroll Approval is requested';
        PayrollApprReqCancelledEventDescTxt: Label 'An approval request for a Payroll Approval has been canceled.';
        PayrollChangeCancelApprovalRequestDescTxt: Label 'An approval for Payroll Change is cancelled ';
        PayrollChangeRequestforApprovalDescTxt: Label 'An approval for Payroll Change is requested ';
        PayrollLoanApplicationApprovalDescTxt: Label 'An approval for Payroll Loan Application is requested ';
        PayrollLoanApplicationCancelApprovalDescTxt: Label 'An approval for Payroll Loan application is cancelled';
        PayrollRequestCancelApprovalRequestDescTxt: Label 'An approval request for Payroll Request is cancelled ';
        PayrollRequestSendforApprovalDescTxt: Label 'An approval for Payroll Request is requested';
        RecruitmentRequestCancelApprovalRequestDescTxt: Label 'An approval request for Recruitment is cancelled';
        RecruitmentRequestSendforApprovalDescTxt: Label 'An approval for Recruitment is requested';
        TrainingRequestCancelApprovalRequestDescTxt: Label 'An approval request for Training Request is cancelled ';
        TrainingRequestSendforApprovalDescTxt: Label 'An approval request for Training is requested';
        TransportRequestCancelApprovalRequestDescTxt: Label 'An approval request for Transport Request is cancelled ';
        TransportRequestSendforApprovalDescTxt: Label 'An approval for Transport Request is requested';
        NewEmployeeSendforApprovalDescTxt: Label 'An approval for a new Employee is requested';
        NewEmployeeCancelApprovalRequestDescTxt: Label 'An approval request for a new Employee has been cancelled';




    procedure RunWorkflowOnSendTransportForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTransportForApproval'));
    end;

    procedure RunWorkflowOnCancelTransportApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTransportApprovalRequest'));
    end;

    procedure RunworkflowOnSendLeaveApplicationforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendLeaveApplicationforApproval'));
    end;

    procedure RunworkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelLeaveApplicationApprovalRequest'));
    end;

    procedure RunworkflowOnSendRecruitmentRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendRecruitmentRequestforApprovalCode'));
    end;

    procedure RunworkflowOnCancelRecruitmentRequestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelRecruitmentRequestApprovalCode'));
    end;

    procedure RunworkflowOnSendTrainingRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendTrainingRequestforApproval'));
    end;

    procedure RunworkflowOnCancelTrainingRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelTrainingRequestApprovalRequest'));
    end;

    procedure RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendEmployeeAppraisalRequestforApproval'));
    end;

    procedure RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelEmployeeAppraisalApprovalRequest'));
    end;

    procedure RunworkflowOnSendLeaveRecallRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendLeaveRecallRequestforApproval'));
    end;

    procedure RunworkflowOnCancelLeaveRecallApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelLeaveRecallApprovalRequest'));
    end;

    procedure RunworkflowOnSendEmployeeTransferRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendEmployeeAppraisalRequestforApproval'));
    end;

    procedure RunworkflowOnCancelEmployeeTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelEmployeeAppraisalApprovalRequest'));
    end;

    procedure RunworkflowOnSendPayrollChangeRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendPayrollChangeRequestforApproval'));
    end;

    procedure RunworkflowOnCancelPayrollChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelPayrollChangeApprovalRequest'));
    end;

    procedure RunworkflowOnSendLoanApplicationforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendLoanApplicationforApproval'));
    end;

    procedure RunworkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelLoanApplicationApprovalRequest'));
    end;

    procedure RunWorkflowOnSendEmpActingPromotionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendEmpActingPromotionForApproval'));
    end;

    procedure RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelEmpActingPromotionApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectEmpActingPromotionCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectEmpActingPromotionApprovalRequest'));
    end;

    procedure RunWorkflowOnSendLeaveAdjForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveAdjForApproval'));
    end;

    procedure RunWorkflowOnCancelLeaveAdjForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveAdjForApproval'));
    end;

    procedure RunworkflowOnSendNewEmpAppraisalforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendNewEmpAppraisalforApproval'));
    end;

    procedure RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelNewEmpAppraisalApprovalRequest'));
    end;

    procedure RunWorkflowOnSendPayrollApprovalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPayrollApprovalForApproval'));
    end;

    procedure RunWorkflowOnCancelPayrollApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPayrollApprovalRequest'));
    end;

    procedure RunWorkflowOnSendPayrollRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPayrollRequestForApproval'));
    end;

    procedure RunWorkflowOnCancelPayrollRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPayrollRequestApprovalRequest'));
    end;

    procedure RunWorkflowOnSendAllowanceRegisterForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendAllowanceRegisterForApproval'));
    end;

    procedure RunWorkflowOnCancelAllowanceRegisterApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelAllowanceRegisterApprovalRequest'));
    end;
    // New Employee
    procedure RunWorkflowOnSendNewEmployeeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendNewEmployeeForApproval'));
    end;
    procedure RunWorkflowOnCancelNewEmployeeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelNewEmployeeApprovalRequest'));
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //Leave Application
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLeaveApplicationforApprovalCode(), Database::"Leave Application",
        LeaveRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLeaveApplicationApprovalRequestCode(), Database::"Leave Application",
        LeaveRequestCancelApprovalRequestDescTxt, 0, false);
        //Recruitment
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendRecruitmentRequestforApprovalCode(), Database::"Recruitment Needs",
        RecruitmentRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelRecruitmentRequestApprovalCode(), Database::"Recruitment Needs",
        RecruitmentRequestCancelApprovalRequestDescTxt, 0, false);
        //Training Request
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendTrainingRequestforApprovalCode(), Database::"Training Request",
        TrainingRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelTrainingRequestApprovalRequestCode(), Database::"Training Request",
        TrainingRequestCancelApprovalRequestDescTxt, 0, false);
        //Transport Request
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTransportForApprovalCode(), Database::"Travel Requests",
        TransportRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTransportApprovalRequestCode(), Database::"Travel Requests",
        TransportRequestCancelApprovalRequestDescTxt, 0, false);
        //Employee Appraisal
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode(), Database::"Employee Appraisal",
        EmployeeAppraisalRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode(), Database::"Employee Appraisal",
        EmployeeAppraisalCancelApprovalRequestDescTxt, 0, false);
        //New Emp Appraisal
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendNewEmpAppraisalforApprovalCode(), Database::"Employee Appraisal",
        NewEmpAppraisalApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(), Database::"Employee Appraisal",
        NewEmpAppraisalCancelApprovalDescTxt, 0, false);
        //Leave Recall
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLeaveRecallRequestforApprovalCode(), Database::"Employee Off/Holiday",
        LeaveRecallApprovalRequestDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLeaveRecallApprovalRequestCode(), Database::"Employee Off/Holiday",
        LeaveRecallCancelApprovalRequestDescTxt, 0, false);
        //Payroll Change
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendPayrollChangeRequestforApprovalCode(), Database::"Payroll Change Header",
        PayrollChangeRequestforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelPayrollChangeApprovalRequestCode(), Database::"Payroll Change Header",
        PayrollChangeCancelApprovalRequestDescTxt, 0, false);
        //Loan Application
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLoanApplicationApprovalRequestCode(), Database::"Payroll Loan Application",
        PayrollLoanApplicationCancelApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLoanApplicationforApprovalCode(), Database::"Payroll Loan Application",
        PayrollLoanApplicationApprovalDescTxt, 0, false);
        //EmpActing and Promotion
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(), Database::"Employee Acting Position",
        EmpActingPromotionCancelApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendEmpActingPromotionForApprovalCode(), Database::"Employee Acting Position",
        EmpActingPromotionSendForApprovalTxt, 0, false);
        //Leave Adj
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendLeaveAdjForApprovalCode(), Database::"Leave Bal Adjustment Header",
        LeaveAdjSendApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelLeaveAdjForApprovalCode(), Database::"Leave Bal Adjustment Header",
        LeaveAdjCancelApprovalTxt, 0, false);
        //Payroll Approval
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendPayrollApprovalForApprovalCode(), Database::"Payroll Approval",
        PayrollApprovalSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelPayrollApprovalRequestCode(), Database::"Payroll Approval",
        PayrollApprReqCancelledEventDescTxt, 0, false);
        //Payroll Request
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendPayrollRequestForApprovalCode(), Database::"Payroll Requests",
        PayrollRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelPayrollRequestApprovalRequestCode(), Database::"Payroll Requests",
        PayrollRequestCancelApprovalRequestDescTxt, 0, false);
        //Allowance Register
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendAllowanceRegisterForApprovalCode(), Database::"Allowance Register",
        AllowanceRegisterSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelAllowanceRegisterApprovalRequestCode(), Database::"Allowance Register",
        AllowanceRegisterCancelApprovalRequestDescTxt, 0, false);
        // New Employee
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendNewEmployeeForApprovalCode(), Database::"Employee",
        NewEmployeeSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), Database::"Employee",
        NewEmployeeCancelApprovalRequestDescTxt, 0, false); 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            //Leave Application
            RunworkflowOnCancelLeaveApplicationApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLeaveApplicationApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
            //Recruitment
            RunworkflowOnCancelRecruitmentRequestApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelRecruitmentRequestApprovalCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
            //Training Request
            RunworkflowOnCancelTrainingRequestApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTrainingRequestApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
            //Transport Requests
            RunWorkflowOnCancelTransportApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelTransportApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
            //Leave Recall
            RunworkflowOnCancelLeaveRecallApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLeaveRecallApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
            //Payroll Change
            RunworkflowOnCancelPayrollChangeApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollChangeApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
            //Loan Application
            RunworkflowOnCancelLoanApplicationApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLoanApplicationApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
            //Emp acting and Promotion
            RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
            //Leave Adj
            RunWorkflowOnSendLeaveAdjForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelLeaveAdjForApprovalCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
            //New Emp Appraisal
            RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
            //Payroll Approval
            RunworkflowOnCancelPayrollApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
            //Payroll Request
            RunworkflowOnCancelPayrollRequestApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollRequestApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
            //Allowance Register
            RunworkflowOnCancelAllowanceRegisterApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelAllowanceRegisterApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                // New Employee
            RunWorkflowOnCancelNewEmployeeApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());


            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    //Leave Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
                    //Leave Recall
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Payroll Change
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
                    //Loan application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp acting and Promotion
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp Appraisal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    //Leave Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
                    //Leave Recall
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Payroll Change
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
                    //Loan Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp acting and Promotion
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp Appraisal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin
                    //Leave Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
                    //Leave Recall
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Payroll Change
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
                    //Loan Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp acting and Promotion
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp Appraisal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendTransportApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnSendTransportForApproval(var TransportReq: Record "Travel Requests")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportForApprovalCode(), TransportReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelTransportApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelTransportApprovalRequest(var TransportReq: Record "Travel Requests")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportApprovalRequestCode(), TransportReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLeaveRequestApproval', '', false, false)]
    local procedure RunworkflowOnSendLeaveApplicationforApproval(var LeaveRequest: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLeaveApplicationforApprovalCode(), LeaveRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLeaveRequestApproval', '', false, false)]
    local procedure RunworkflowOnCancelLeaveApplicationApprovalRequest(var LeaveRequest: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLeaveApplicationApprovalRequestCode(), LeaveRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendRecruitmentApprovalRequest', '', false, false)]
    local procedure RunworkflowOnSendRecruitmentRequestforApproval(var RecruitmentRequest: Record "Recruitment Needs")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendRecruitmentRequestforApprovalCode(), RecruitmentRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelRecruitmentApprovalRequest', '', false, false)]
    local procedure RunworkflowOnCancelRecruitmentRequestApproval(var RecruitmentRequest: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelRecruitmentRequestApprovalCode(), RecruitmentRequest);

        Recruitment.Reset();
        Recruitment.SetRange("No.", RecruitmentRequest."No.");
        if Recruitment.FindFirst() then begin
            Recruitment.Status := Recruitment.Status::Open;
            Recruitment.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendTrainingRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendTrainingRequestforApproval(var TrainingReq: Record "Training Request")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendTrainingRequestforApprovalCode(), TrainingReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelTrainingRequestApproval', '', false, false)]
    local procedure RunworkflowOnCancelTrainingRequestApprovalRequest(var TrainingReq: Record "Training Request")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelTrainingRequestApprovalRequestCode(), TrainingReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendEmployeeAppraisalRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendEmployeeAppraisalRequestforApproval(var EmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode(), EmployeeAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelEmployeeAppraisalApprovalRequest', '', false, false)]
    local procedure RunworkflowOnCancelEmployeeAppraisalApprovalRequest(var EmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode(), EmployeeAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLeaveRecallRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendLeaveRecallRequestforApproval(var LeaveRecall: Record "Employee Off/Holiday")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLeaveRecallRequestforApprovalCode(), LeaveRecall);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLeaveRecallApprovalRequest', '', false, false)]
    local procedure RunworkflowOnCancelLeaveRecallApprovalRequest(var LeaveRecall: Record "Employee Off/Holiday")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLeaveRecallApprovalRequestCode(), LeaveRecall);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendEmployeeAppraisalRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendEmployeeTransferRequestforApproval(var EmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode(), EmployeeAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelEmployeeAppraisalApprovalRequest', '', false, false)]
    local procedure RunworkflowOnCancelEmployeeTransferApprovalRequest(var EmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode(), EmployeeAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendPayrollChangeforApproval', '', false, false)]
    local procedure RunworkflowOnSendPayrollChangeRequestforApproval(var "Payroll Change": Record "Payroll Change Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendPayrollChangeRequestforApprovalCode(), "Payroll Change");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelPayrollChangeApproval', '', false, false)]
    local procedure RunworkflowOnCancelPayrollChangeApprovalRequest(var "Payroll Change": Record "Payroll Change Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelPayrollChangeApprovalRequestCode(), "Payroll Change");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLoanApplicationRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendLoanApplicationforApproval(var LoanApplication: Record "Payroll Loan Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLoanApplicationforApprovalCode(), LoanApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLoanApplicationRequestApproval', '', false, false)]
    local procedure RunworkflowOnCancelLoanApplicationApprovalRequest(var LoanApplication: Record "Payroll Loan Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLoanApplicationApprovalRequestCode(), LoanApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendEmpActingAndPromotionRequestForApproval', '', false, false)]
    local procedure RunWorkflowOnSendEmpActingPromotionForApproval(var EmpActing: Record "Employee Acting Position")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpActingPromotionForApprovalCode(), EmpActing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelEmpActingAndPromotionRequestApproval', '', false, false)]
    local procedure RunWorkflowOnCancelEmpActingPromotionApprovalRequest(var EmpActing: Record "Employee Acting Position")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(), EmpActing);
    end;

    //Leave Adjustment Approvals
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLeaveAdjApproval', '', false, false)]
    local procedure RunWorkflowOnSendLeaveAdjForApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveAdjForApprovalCode(), LeaveAdj);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLeaveAdjApproval', '', false, false)]
    local procedure RunWorkflowOnCancelLeaveAdjForApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveAdjForApprovalCode(), LeaveAdj);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendNewEmpAppraisalRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendNewEmpAppraisalforApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendNewEmpAppraisalforApprovalCode(), NewEmployeeAppraisal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelNewEmpAppraisalRequestApproval', '', false, false)]
    local procedure RunworkflowOnCancelNewEmpAppraisalApprovalRequest(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(), NewEmployeeAppraisal);
    end;

    //Payroll Approval
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendPayrollApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnSendPayrollApprovalForApproval(var PayApproval: Record "Payroll Approval")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPayrollApprovalForApprovalCode(), PayApproval);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelPayrollApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelPayrollApprovalRequest(var PayApproval: Record "Payroll Approval")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollApprovalRequestCode(), PayApproval);
    end;

    //Payroll Request
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendPayrollRequestForApproval', '', false, false)]
    local procedure RunWorkflowOnSendPayrollRequestForApproval(var PayrollRequest: Record "Payroll Requests")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPayrollRequestForApprovalCode(), PayrollRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelPayrollRequestApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelPayrollRequestApprovalRequest(var PayrollRequest: Record "Payroll Requests")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollRequestApprovalRequestCode(), PayrollRequest);
    end;

    //Allowance Register
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendAllowanceRegisterForApproval', '', false, false)]
    local procedure RunWorkflowOnSendAllowanceRegisterForApproval(var AllowanceRegister: Record "Allowance Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendAllowanceRegisterForApprovalCode(), AllowanceRegister);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelAllowanceRegisterRequest', '', false, false)]
    local procedure RunWorkflowOnCancelAllowanceRegisterApprovalRequest(var AllowanceRegister: Record "Allowance Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelAllowanceRegisterApprovalRequestCode(), AllowanceRegister);
    end;
    // New Employee
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendNewEmployeeApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnSendNewEmployeeForApproval(var Emp: Record "Employee")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendNewEmployeeForApprovalCode(), Emp);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelNewEmployeeApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelNewEmployeeApprovalRequest(var Emp: Record "Employee")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), Emp);
    end;
}





