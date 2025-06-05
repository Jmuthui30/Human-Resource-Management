codeunit 52007 "Wkflw Event Response HR Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle HR Ext";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkFlowResponse.SetStatusToPendingApprovalCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.CreateApprovalRequestsCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Employee Acting Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    //New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.SendApprovalRequestForApprovalCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.OpenDocumentCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveApplicationApprovalRequestCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelRecruitmentRequestApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelTrainingRequestApprovalRequestCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelTransportApprovalRequestCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveRecallApprovalRequestCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeTransferApprovalRequestCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelLoanApplicationApprovalRequestCode());
                    //Employee Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnRejectEmpActingPromotionCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollApprovalRequestCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollRequestApprovalRequestCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelAllowanceRegisterApprovalRequestCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelNewEmployeeApprovalRequestCode());
                end;
            WorkFlowResponse.CancelAllApprovalRequestsCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveApplicationApprovalRequestCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelRecruitmentRequestApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelTrainingRequestApprovalRequestCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelTransportApprovalRequestCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveRecallApprovalRequestCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeTransferApprovalRequestCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelLoanApplicationApprovalRequestCode());
                    //Employee Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollApprovalRequestCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollRequestApprovalRequestCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelAllowanceRegisterApprovalRequestCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelNewEmployeeApprovalRequestCode());
                end;
            WorkFlowResponse.ReleaseDocumentCode():
                ;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        AllowanceRegister: Record "Allowance Register";
        EActingPosition: Record "Employee Acting Position";
        EAppraisal: Record "Employee Appraisal";
        LRecall: Record "Employee Off/Holiday";
        LeaveApp: Record "Leave Application";
        LAdj: Record "Leave Bal Adjustment Header";
        PayrollApproval: Record "Payroll Approval";
        LoanApplication: Record "Payroll Loan Application";
        PayrollRequest: Record "Payroll Requests";
        RNeeds: Record "Recruitment Needs";
        TRequest: Record "Training Request";
        TravelRequest: Record "Travel Requests";
        WorkflowResponses: Codeunit "Workflow Responses HR";
        Emp: Record "Employee";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of
            //Leave Application
            Database::"Leave Application":
                begin
                    LeaveApp.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLeave(VarVariant);
                end;
            //Recruitment
            Database::"Recruitment Needs":
                begin
                    RNeeds.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseRecruitment(VarVariant);
                end;
            //Training Request
            Database::"Training Request":
                begin
                    TRequest.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseTrainingRequest(VarVariant);
                end;
            //Transport Request
            Database::"Travel Requests":
                begin
                    TravelRequest.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseTransportReq(VarVariant);
                end;
            //Employee Appraisal
            Database::"Employee Appraisal":
                begin
                    EAppraisal.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseEmployeeAppraisalRequest(VarVariant);
                end;
            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    LRecall.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLeaveRecallRequest(VarVariant);
                end;
            //Loan Application
            Database::"Payroll Loan Application":
                begin
                    LoanApplication.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLoanApplication(VarVariant);
                end;
            //Emp acting and Promotion
            Database::"Employee Acting Position":
                begin
                    EActingPosition.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseEmpActingPromotion(VarVariant);
                end;
            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    LAdj.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLeaveAdj(VarVariant);
                end;
            //Payroll Approval
            Database::"Payroll Approval":
                begin
                    PayrollApproval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleasePayrollApproval(VarVariant);
                end;
            //Payroll Request
            Database::"Payroll Requests":
                begin
                    PayrollRequest.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleasePayrollRequest(VarVariant);
                end;
            //Allowance Register
            Database::"Allowance Register":
                begin
                    AllowanceRegister.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseAllowanceRegister(VarVariant);
                end;
            // New Employee
            Database::"Employee":
                begin
                    Emp.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseNewEmployeeApplication(VarVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        AllowanceRegister: Record "Allowance Register";
        EActingPosition: Record "Employee Acting Position";
        EAppraisal: Record "Employee Appraisal";
        LRecall: Record "Employee Off/Holiday";
        LeaveApp: Record "Leave Application";
        LAdj: Record "Leave Bal Adjustment Header";
        PayrollApproval: Record "Payroll Approval";
        LoanApplication: Record "Payroll Loan Application";
        PayrollRequest: Record "Payroll Requests";
        RNeeds: Record "Recruitment Needs";
        TRequest: Record "Training Request";
        TravelRequest: Record "Travel Requests";
        Emp: Record "Employee";
        WorkflowResponses: Codeunit "Workflow Responses HR";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;

        case RecRef.Number of
            //Leave Application
            Database::"Leave Application":
                begin
                    LeaveApp.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLeave(VarVariant);
                end;
            //Recruitment
            Database::"Recruitment Needs":
                begin
                    RNeeds.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenRecruitment(VarVariant);
                end;
            //Training Request
            Database::"Training Request":
                begin
                    TRequest.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenTrainingRequest(VarVariant);
                end;
            //Transport Request
            Database::"Travel Requests":
                begin
                    TravelRequest.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenTransportReq(VarVariant);
                end;
            //Employee Appraisal
            Database::"Employee Appraisal":
                begin
                    EAppraisal.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenEmployeeAppraisalRequest(VarVariant);
                end;
            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    LRecall.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLeaveRecallRequest(VarVariant);
                end;
            //Loan Application
            Database::"Payroll Loan Application":
                begin
                    LoanApplication.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLoanApplication(VarVariant);
                end;
            //Emp acting and Promotion
            Database::"Employee Acting Position":
                begin
                    EActingPosition.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenEmpActingPromotion(VarVariant);
                end;
            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    LAdj.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLeaveAdj(VarVariant);
                end;
            //Payroll Approval
            Database::"Payroll Approval":
                begin
                    PayrollApproval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenPayrollApproval(VarVariant);
                end;
            //Payroll Request
            Database::"Payroll Requests":
                begin
                    PayrollRequest.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenPayrollRequest(VarVariant);
                end;
            //Allowance Register
            Database::"Allowance Register":
                begin
                    AllowanceRegister.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReOpenAllowanceRegister(VarVariant);
                end;
            // New Employee
            Database::"Employee":
                begin
                    Emp.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenNewEmployeeApplication(VarVariant);
                end;
        end;
    end;
}





