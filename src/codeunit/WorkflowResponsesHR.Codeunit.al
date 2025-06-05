codeunit 52004 "Workflow Responses HR"
{
    trigger OnRun()
    begin
    end;

    var
        Committment: Codeunit "Commitments Mgt HR";
        HRMgnt: Codeunit "HR Management";

    procedure ReleaseLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset();
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst() then begin
            LeaveRec.Status := LeaveRec.Status::Released;
            LeaveRec.Modify(true);
            //Recall
            HRMgnt.LeaveRecall(LeaveRec."No.");
        end;
    end;

    procedure ReopenLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset();
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst() then begin
            LeaveRec.Status := LeaveRecall.Status::Open;
            LeaveRec.Modify(true)
        end;
    end;

    procedure ReleaseLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset();
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst() then begin
            Leave.Validate(Status, Leave.Status::Released);
            Leave.Modify(true);
            HRMgnt.LeaveApplication(Leave."Application No");
            if guiAllowed then begin
                if Confirm('Do you want to notify the leave applicant and their reliever(s)', false) then
                    HRMgnt.NotifyLeaveReliever(Leave."Application No");
            end else
                HRMgnt.NotifyLeaveReliever(Leave."Application No");
        end;
    end;

    procedure ReopenLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset();
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst() then begin
            Leave.Status := Leave.Status::Open;
            Leave.Modify(true);
        end;
    end;

    procedure ReleaseTrainingRequest(var TrainingReq: Record "Training Request")
    var
        Training: Record "Training Request";
        ErrorMsg: Text;
    begin
        Training.Reset();
        Training.SetRange("Request No.", TrainingReq."Request No.");
        if Training.FindFirst() then begin
            HRMgnt.CheckTrainingCostExceeded(Training."Request No.", Training."Training Need");
            Committment.TrainingRequestCommittment(Training, ErrorMsg);
            if ErrorMsg <> '' then
                Error(ErrorMsg);
            Training.Status := Training.Status::Released;
            Training.Modify(true);
        end;
    end;

    procedure ReopenTrainingRequest(var TrainingReq: Record "Training Request")
    var
        Training: Record "Training Request";
    begin
        Training.Reset();
        Training.SetRange("Request No.", TrainingReq."Request No.");
        if Training.FindFirst() then begin
            Training.Status := Training.Status::Open;
            Training.Modify(true)
        end;
    end;

    procedure ReleaseEmployeeAppraisalRequest(var Appraisal: Record "Employee Appraisal")
    var
        EmployeeApp: Record "Employee Appraisal";
    begin
        EmployeeApp.Reset();
        EmployeeApp.SetRange("Appraisal No", Appraisal."Appraisal No");
        if EmployeeApp.FindFirst() then begin
            /*if (EmployeeApp.Type = EmployeeApp.Type::"Mid-Year") and (EmployeeApp.Status <> EmployeeApp.Status::"Mid-Year Approved") then
                EmployeeApp.Status := EmployeeApp.Status::"Mid-Year Approved";

            if (EmployeeApp.Type = EmployeeApp.Type::"Mid-Year") and (EmployeeApp.Status = EmployeeApp.Status::"Mid-Year Approved") then
                HRMgnt.SendToFinalYearAppraisal(EmployeeApp);
            Commit();

            if (EmployeeApp.Type <> EmployeeApp.Type::"Mid-Year") and (EmployeeApp.Status <> EmployeeApp.Status::"Mid-Year Approved") then
                EmployeeApp.Status := EmployeeApp.Status::Released;*/

            EmployeeApp.Status := EmployeeApp.Status::Released;
            EmployeeApp."Appraisal Status" := EmployeeApp."Appraisal Status"::Review;
            EmployeeApp.Modify(true);
        end;
    end;

    procedure ReopenEmployeeAppraisalRequest(var Appraisal: Record "Employee Appraisal")
    var
        EmployeeApp: Record "Employee Appraisal";
    begin
        EmployeeApp.Reset();
        EmployeeApp.SetRange("Appraisal No", Appraisal."Appraisal No");
        if EmployeeApp.FindFirst() then begin
            EmployeeApp.Status := EmployeeApp.Status::Open;
            EmployeeApp."Appraisal Status" := EmployeeApp."Appraisal Status"::Setting;
            EmployeeApp.Modify(true);
        end;
    end;

    procedure ReleaseLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    begin
    end;

    procedure ReopenLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    begin
    end;

    procedure ReleaseTransportReq(var Transport: Record "Travel Requests")
    var
        TransportReq: Record "Travel Requests";
    begin
        if TransportReq.Get(Transport."Request No.") then begin

            /* if Confirm('Do you want to create a travel imprest?', false) then
                HRMgnt.CreateTravelImprest(TransportReq); */

            if Confirm('Do you want to notify travelling employees?', false) then
                HRMgnt.NotifyTransportEmployees(TransportReq."Request No.");

            TransportReq.Status := TransportReq.Status::Released;
            TransportReq.Modify(true);
        end;
    end;

    procedure ReopenTransportReq(var Transport: Record "Travel Requests")
    var
        TransportReq: Record "Travel Requests";
    begin
        TransportReq.Reset();
        TransportReq.SetRange("Request No.", Transport."Request No.");
        if TransportReq.FindFirst() then begin
            TransportReq.Status := TransportReq.Status::Open;
            TransportReq.Modify(true)
        end;
    end;

    procedure ReleaseRecruitment(var RecruitmentReq: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        Recruitment.Reset();
        Recruitment.SetRange("No.", RecruitmentReq."No.");
        if Recruitment.FindFirst() then begin
            RecruitmentReq.Status := RecruitmentReq.Status::Released;
            RecruitmentReq.Modify(true);
        end;
        /*
        RecruitmentReq.Reset();
        RecruitmentReq.SetRange("No.",Recruitment."No.");
          if RecruitmentReq.FindFirst() then begin
            RecruitmentReq.Status:=RecruitmentReq.Status::Released;
            RecruitmentReq.Modify(true);
            end;
        */

    end;

    procedure ReopenRecruitment(var RecruitmentReq: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        RecruitmentReq.Reset();
        RecruitmentReq.SetRange("No.", Recruitment."No.");
        if RecruitmentReq.FindFirst() then begin
            RecruitmentReq.Status := RecruitmentReq.Status::Open;
            RecruitmentReq.Modify(true)
        end;
    end;

    procedure ReleasePayrollChange(var Payroll: Record "Payroll Change Header")
    var
        PayrollChange: Record "Payroll Change Header";
    begin
        PayrollChange.Reset();
        PayrollChange.SetRange(No, Payroll.No);
        if PayrollChange.FindFirst() then begin
            PayrollChange.Status := PayrollChange.Status::Approved;
            PayrollChange.Modify(true);
        end;
    end;

    procedure ReopenPayrollChange(var Payroll: Record "Payroll Change Header")
    var
        PayrollChange: Record "Payroll Change Header";
    begin
        PayrollChange.Reset();
        PayrollChange.SetRange(No, Payroll.No);
        if PayrollChange.FindFirst() then begin
            PayrollChange.Status := PayrollChange.Status::Open;
            PayrollChange.Modify(true);
        end;
    end;

    procedure ReleasePayrollRequest(var PayrollReq: Record "Payroll Requests")
    var
        PayrollRequest: Record "Payroll Requests";
    begin
        PayrollRequest.Reset();
        PayrollRequest.SetRange("No.", PayrollReq."No.");
        if PayrollRequest.FindFirst() then begin
            PayrollRequest.Status := PayrollRequest.Status::Approved;
            PayrollRequest.Modify(true);
        end;
    end;

    procedure ReopenPayrollRequest(var PayrollReq: Record "Payroll Requests")
    var
        PayrollRequest: Record "Payroll Requests";
    begin
        PayrollRequest.Reset();
        PayrollRequest.SetRange("No.", PayrollReq."No.");
        if PayrollRequest.FindFirst() then begin
            PayrollRequest.Status := PayrollRequest.Status::Open;
            PayrollRequest.Modify(true);
        end;
    end;

    procedure ReleaseLoanApplication(var LoanApp: Record "Payroll Loan Application")
    var
        LoanApplication: Record "Payroll Loan Application";
    begin
        LoanApplication.Reset();
        LoanApplication.SetRange("Loan No", LoanApp."Loan No");
        if LoanApplication.FindFirst() then begin
            LoanApplication."Loan Status" := LoanApplication."Loan Status"::Approved;
            LoanApplication.Modify(true);
        end;
    end;

    procedure ReopenLoanApplication(var LoanApp: Record "Payroll Loan Application")
    var
        LoanApplication: Record "Payroll Loan Application";
    begin
        LoanApplication.Reset();
        LoanApplication.SetRange("Loan No", LoanApp."Loan No");
        if LoanApplication.FindFirst() then begin
            LoanApplication."Loan Status" := LoanApplication."Loan Status"::Application;
            LoanApplication.Modify(true);
        end;
    end;

    procedure ReleaseEmpActingPromotion(var EmpActingProm: Record "Employee Acting Position")
    var
        Employee: Record Employee;
        EmpActingPromRec: Record "Employee Acting Position";
    begin
        EmpActingPromRec.Reset();
        EmpActingPromRec.SetRange(No, EmpActingProm.No);
        if EmpActingPromRec.FindFirst() then begin
            case EmpActingPromRec."Document Type" of
                EmpActingPromRec."Document Type"::Acting:
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", EmpActingPromRec."Acting Employee No.");
                        if Employee.Find('-') then begin
                            EmpActingPromRec.TestField("End Date");
                            if Employee."End Date" > Today then
                                Error('This Employee is already on an acting Capacity');

                            Employee."Acting No" := EmpActingPromRec.No;
                            Employee."Acting Position" := EmpActingPromRec.Position;
                            Employee."Acting Description" := EmpActingPromRec."Job Description";
                            Employee."Relieved Employee" := EmpActingPromRec."Relieved Employee";
                            Employee."Relieved Name" := EmpActingPromRec."Relieved Name";
                            Employee."Start Date" := EmpActingPromRec."Start Date";
                            Employee."End Date" := EmpActingPromRec."End Date";
                            Employee."Reason for Acting" := EmpActingPromRec.Reason;
                            Employee.Modify();
                        end;
                    end;
                EmpActingPromRec."Document Type"::Promotion:
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", EmpActingPromRec."Acting Employee No.");
                        if Employee.Find('-') then begin
                            Employee."Job Title" := EmpActingPromRec."Job Description";
                            Employee."Job Position" := EmpActingPromRec."Desired Position";
                            Employee.Modify();
                        end;
                        // EmpActingPromRec.Promoted := true;
                        // EmpActingPromRec.Modify;
                    end;
            end;

            EmpActingPromRec.Status := EmpActingPromRec.Status::Approved;
            EmpActingPromRec.Modify(true);
        end;
    end;

    procedure ReopenEmpActingPromotion(var EmpActingProm: Record "Employee Acting Position")
    var
        EmpActingPromRec: Record "Employee Acting Position";
    begin
        EmpActingPromRec.Reset();
        EmpActingPromRec.SetRange(No, EmpActingProm.No);
        if EmpActingPromRec.FindFirst() then begin
            EmpActingPromRec.Status := EmpActingPromRec.Status::New;
            EmpActingPromRec.Modify(true);
        end;
    end;

    procedure ReleaseLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code) then begin
            LeaveAdjRec.Status := LeaveAdjRec.Status::Released;
            LeaveAdjRec.Modify();
        end;
    end;

    procedure ReopenLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code) then begin
            LeaveAdjRec.Status := LeaveAdjRec.Status::Open;
            LeaveAdjRec.Modify();
        end;
    end;

    procedure ReleasePayrollApproval(var PayrollApproval: Record "Payroll Approval")
    var
        PayApproval: Record "Payroll Approval";
        PayPeriods: Record "Payroll Period";
    begin
        if PayApproval.Get(PayrollApproval.Code) then begin
            PayApproval.Status := PayApproval.Status::Approved;
            PayApproval.Modify(true);

            PayPeriods.Get(PayrollApproval."Payroll Period");
            PayPeriods.Validate("Approval Status", PayPeriods."Approval Status"::Approved);
            PayPeriods.Modify();
        end;

    end;

    procedure ReopenPayrollApproval(var PayrollApproval: Record "Payroll Approval")
    var
        PayApproval: Record "Payroll Approval";
        PayPeriods: Record "Payroll Period";
    begin
        if PayApproval.Get(PayrollApproval.Code) then begin
            PayApproval.Status := PayApproval.Status::Open;
            PayApproval.Modify(true);

            PayPeriods.Get(PayrollApproval."Payroll Period");
            PayPeriods.Validate("Approval Status", PayPeriods."Approval Status"::Open);
            PayPeriods.Modify();
        end;

    end;

    procedure ReleaseAllowanceRegister(var AllowanceRegister: Record "Allowance Register")
    var
        AllowanceRegisterRec: Record "Allowance Register";
    begin
        if AllowanceRegisterRec.Get(AllowanceRegister."No.") then begin
            AllowanceRegisterRec.Validate(Status, AllowanceRegisterRec.Status::Approved);
            AllowanceRegisterRec.Modify();
        end;
    end;

    procedure ReOpenAllowanceRegister(var AllowanceRegister: Record "Allowance Register")
    var
        AllowanceRegisterRec: Record "Allowance Register";
    begin
        if AllowanceRegisterRec.Get(AllowanceRegister."No.") then begin
            AllowanceRegisterRec.Validate(Status, AllowanceRegisterRec.Status::Open);
            AllowanceRegisterRec.Modify();
        end;
    end;
    // New Employee Application
    procedure ReleaseNewEmployeeApplication(var Emp: Record Employee)
    var
    Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("No.", Emp."No.");
        if Employee.FindFirst() then begin
            Employee."Approval Status" := Employee."Approval Status"::Approved;
            Employee.Modify(true);
        end;
    end;

    procedure ReopenNewEmployeeApplication(var Emp: Record Employee)
    var
    Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("No.", Emp."No.");
        if Employee.FindFirst() then begin
            Employee."Approval Status" := Employee."Approval Status"::Open;
            Employee.Modify(true);
        end;
    end;
}
