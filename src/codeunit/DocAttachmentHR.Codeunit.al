codeunit 52009 "Doc Attachment HR"
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure AddCustomTablesOnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Allowance Register":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;

            Database::"Employee Discplinary":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::Applicants:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"Employee Separation":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"Leave Application":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"Payroll Requests":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"CH Company information":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure AddCustomTablesOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        BoardAttendance: Record "Allowance Register";
        Applicants: Record Applicants;
        EmployeeDisp: Record "Employee Discplinary";
        EmpSeparation: Record "Employee Separation";
        LeaveApplication: Record "Leave Application";
        PayrollRequests: Record "Payroll Requests";
        CHCompanyInform: Record "CH Company information";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Allowance Register":
                begin
                    RecRef.Open(Database::"Allowance Register");
                    if BoardAttendance.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(BoardAttendance);
                end;
            Database::"Employee Discplinary":
                begin
                    RecRef.Open(Database::"Employee Discplinary");
                    if EmployeeDisp.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(EmployeeDisp);
                end;
            Database::Applicants:
                begin
                    RecRef.Open(Database::Applicants);
                    if Applicants.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Applicants);
                end;
            Database::"Employee Separation":
                begin
                    RecRef.Open(Database::"Employee Separation");
                    if EmpSeparation.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(EmpSeparation);
                end;
            Database::"Leave Application":
                begin
                    RecRef.Open(Database::"Leave Application");
                    if LeaveApplication.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(LeaveApplication);
                end;
            Database::"Payroll Requests":
                begin
                    RecRef.Open(Database::"Payroll Requests");
                    if PayrollRequests.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(PayrollRequests);
                end;
            Database::"CH Company information":
                begin
                    RecRef.Open(Database::"CH Company information");
                    if CHCompanyInform.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(CHCompanyInform);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure InsertCustomTablesOnAfterInitFieldsFromRecRef(var RecRef: RecordRef; var DocumentAttachment: Record "Document Attachment")
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Allowance Register",
            Database::"Employee Discplinary",
            Database::Applicants,
            Database::"Employee Separation",
            Database::"CH Company information",
            Database::"Payroll Requests":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", GetAttachmentDocumentTypeFromRec(RecRef));
                end;
            Database::"Leave Application":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", GetAttachmentDocumentTypeFromRec(RecRef));
                end;
        end;
    end;

    local procedure GetAttachmentDocumentTypeFromRec(RecRef: RecordRef): Enum "Document Attachment File Type"
    begin
        case RecRef.Number of
            Database::"Allowance Register":
                exit(Enum::"Attachment Document Type"::Allowances);
            Database::"Employee Discplinary":
                exit(Enum::"Attachment Document Type"::"Employee Disciplinary");
            Database::Applicants:
                exit(Enum::"Attachment Document Type"::"Job Applicants");
            Database::"Employee Separation":
                exit(Enum::"Attachment Document Type"::"Employee Separation");
            Database::"Payroll Requests":
                exit(Enum::"Attachment Document Type"::"Payroll Requests");
        end;
    end;
}






