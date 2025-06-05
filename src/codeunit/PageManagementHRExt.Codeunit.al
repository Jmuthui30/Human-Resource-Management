codeunit 52008 "Page Management HR Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin

        case RecordRef.Number of
            //Transport Req
            Database::"Travel Requests":
                PageID := (GetTransportPageID(RecordRef));
            //Leave adj
            Database::"Leave Bal Adjustment Header":
                PageID := (Page::"Leave Adjustment Header");
            //New emp appraisal
            Database::"Employee Appraisal":
                PageID := (Page::"Appraisal Card-Review");
            //Recruitment Request
            Database::"Recruitment Needs":
                PageID := (Page::"Recruitment Request");
            Database::"Employee Acting Position":
                PageID := (Page::"Acting Position Card");
            Database::"Payroll Loan Application":
                PageID := (Page::"Loan Application Form-Payroll");
            Database::"Payroll Approval":
                PageID := GetPayrollApprovalPage(RecordRef);
            Database::"Leave Application":
                PageID := (Page::"Leave Application Card");
            Database::"Allowance Register":
                PageID := Page::"Allowance Register";
            Database::"Payroll Requests":
                PageID := Page::"Payroll Request Card";
        end;

    end;

    local procedure GetTransportPageID(RecordRef: RecordRef): Integer
    var
        TravelReq: Record "Travel Requests";
    begin
        RecordRef.SetTable(TravelReq);
        exit(Page::"Transport Request");
    end;

    local procedure GetPayrollApprovalPage(RecordRef: RecordRef): Integer
    var
        PayApproval: Record "Payroll Approval";
    begin
        RecordRef.SetTable(PayApproval);
        case PayApproval."Employee Type" of
            PayApproval."Employee Type"::Staff:
                exit(Page::"Payroll Approval-Staff");
            PayApproval."Employee Type"::"Board Member":
                exit(Page::"Payroll Approval-Board");
        end;
    end;
}





