codeunit 52003 "HR Notifications"
{
    trigger OnRun()
    begin
        ContractExpiry();
        ProbationExpiry();
        LeaveScheduleNotification();
        RetiringEmployees();
        AppraisalSubmissionReminder();
        BirthdayMessage();
        YearsOfServiceNotification();
        EmployeeAnniversaryNotification();
        //RetirementMessage();
    end;

    procedure ContractExpiry()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        EmployeeData: Report "Employee Data";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        EndDate: Date;
        AttachInstr: InStream;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To<b> Senior HR and Admin Officer,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">Please find attached a list of Employee Contracts expiring on <strong>%1<strong>.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>%2.</p>';
        Recipient: List of [Text];
        AttachOutstr: OutStream;
        Base64Txt, EmailBody, FileName, Subject : Text;
    begin
        EndDate := CalcDate('1M', Today());

        Employee.Reset();
        Employee.SetRange("Employment Type", Employee."Employment Type"::Contract);
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Contract End Date", '=%1', EndDate);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");

            Clear(EmployeeData);
            EmployeeData.SetTableView(Employee);

            Subject := 'Expiring Contracts';
            Clear(Recipient);
            Recipient.Add(HRSetup."Human Resource Emails");
            FileName := 'ExpiringContracts_' + Format(EndDate) + '.pdf';
            EmailBody := StrSubstNo(NewBody, Format(EndDate), CompanyInfo.Name);
            EmailMessage.Create(Recipient, Subject, EmailBody, true);

            TempBlob.CreateOutStream(AttachOutstr);
            if EmployeeData.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
                TempBlob.CreateInStream(AttachInstr);
                Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
            end;
            Email.Send(EmailMessage);
        end;
    end;

    procedure ProbationExpiry()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        EmployeeData: Report "Employee Data";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        EndDate: Date;
        AttachInstr: InStream;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To<b> Senior HR and Admin Officer,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">Please find attached a list of Employees whose Probation period is expiring on <strong>%1<strong>.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>%2.</p>';
        Recipient: List of [Text];
        AttachOutstr: OutStream;
        Base64Txt, EmailBody, FileName, Subject : Text;
    begin
        EndDate := CalcDate('1M', Today());

        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetFilter("End Of Probation Date", '=%1', EndDate);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");

            Clear(EmployeeData);
            EmployeeData.SetTableView(Employee);

            Subject := 'Probation Expiry';
            Clear(Recipient);
            Recipient.Add(HRSetup."Human Resource Emails");
            FileName := 'ProbationExpiry_' + Format(EndDate) + '.pdf';
            EmailBody := StrSubstNo(NewBody, Format(EndDate), CompanyInfo.Name);
            EmailMessage.Create(Recipient, Subject, EmailBody, true);

            TempBlob.CreateOutStream(AttachOutstr);
            if EmployeeData.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
                TempBlob.CreateInStream(AttachInstr);
                Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
            end;
            Email.Send(EmailMessage);
        end;
    end;

    procedure LeaveScheduleNotification()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeavePeriod: Record "Leave Period";
        LeaveSchedule: Record "Leave Planner Header";
        LeaveScheduleLines: Record "Leave Planner Lines";
        LeaveTypes: Record "Leave Type";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">As per the current leave schedule you are required to proceed on leave starting on <strong>%2<strong> to <strong>%3<strong>.</p><p style="font-family:Verdana,Arial;font-size:10pt">Thank you for your cooperation.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>Senior HR and Admin Officer<br>%4</p>';
        Recipient: List of [Text];
        EmailBody, Subject : Text;
    begin
        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");

            LeavePeriod.SetRange(Closed, false);
            if LeavePeriod.FindLast() then;

            LeaveTypes.SetRange("Annual Leave", true);
            if LeaveTypes.FindFirst() then;
            repeat
                LeaveSchedule.Reset();
                LeaveSchedule.SetRange("Leave Period", LeavePeriod."Leave Period Code");
                if LeaveSchedule.FindFirst() then begin
                    LeaveScheduleLines.Reset();
                    LeaveScheduleLines.SetRange("Document No.", LeaveSchedule."No.");
                    LeaveScheduleLines.SetRange("Employee No.", Employee."No.");
                    LeaveScheduleLines.SetRange("Leave Type", LeaveTypes.Code);
                    LeaveScheduleLines.SetRange("Start Date", CalcDate('1D', Today()));
                    if LeaveScheduleLines.FindFirst() then begin
                        Subject := 'Leave Notification';
                        Clear(Recipient);
                        Recipient.Add(Employee."Company E-Mail");
                        EmailBody := StrSubstNo(NewBody, Employee.FullName(), Format(LeaveScheduleLines."Start Date"), Format(LeaveScheduleLines."End Date"), CompanyInfo.Name);
                        EmailMessage.Create(Recipient, Subject, EmailBody, true);
                        Email.Send(EmailMessage);
                    end;
                end;
            until Employee.Next() = 0;
        end;
    end;

    procedure NotifyTrainingNeeds(TrainingNeed: Record "Training Need")
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">A training entitled <strong>%2<strong> has been approved.<br> It is scheduled to begin on <strong>%3<strong> and end on <strong>%4<strong>.</p><p style="font-family:Verdana,Arial;font-size:10pt">You are hereby requested to apply for this training.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>Senior HR and Admin Officer<br>%5</p>';
        Recipient: List of [Text];
        EmailBody, Subject : Text;
    begin
        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");
            repeat
                Subject := TrainingNeed.Description + ' Training Notification';
                Clear(Recipient);
                Recipient.Add(Employee."Company E-Mail");
                EmailBody := StrSubstNo(NewBody, Employee.FullName(), TrainingNeed.Description, Format(TrainingNeed."Start Date"), Format(TrainingNeed."End Date"), CompanyInfo.Name);
                EmailMessage.Create(Recipient, Subject, EmailBody, true);
                Email.Send(EmailMessage);
            until Employee.Next() = 0;
        end;
    end;

    procedure RetiringEmployees()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        EmployeeData: Report "Employee Data";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        EndDate: Date;
        AttachInstr: InStream;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To<b> Senior HR and Admin Officer,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">Please find attached a list of Employees retiring on <strong>%1<strong>.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>%2.</p>';
        Recipient: List of [Text];
        AttachOutstr: OutStream;
        Base64Txt, EmailBody, FileName, Subject : Text;
    begin
        EndDate := CalcDate('1M', Today());

        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Retirement Date", '=%1', EndDate);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");

            Clear(EmployeeData);
            EmployeeData.SetTableView(Employee);

            Subject := 'Retiring Employees';
            Clear(Recipient);
            Recipient.Add(HRSetup."Human Resource Emails");
            FileName := 'RetiringEmployees_' + Format(EndDate) + '.pdf';
            EmailBody := StrSubstNo(NewBody, Format(EndDate), CompanyInfo.Name);
            EmailMessage.Create(Recipient, Subject, EmailBody, true);

            TempBlob.CreateOutStream(AttachOutstr);
            if EmployeeData.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
                TempBlob.CreateInStream(AttachInstr);
                Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
            end;
            Email.Send(EmailMessage);
        end;
    end;

    procedure AppraisalSubmissionReminder()
    var
        AppraisalPeriods: Record "Appraisal Periods";
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">This is a reminder for you to submit your Performance Appraisal for the Period <strong>%2<strong></p><p style="font-family:Verdana,Arial;font-size:10pt">Please ignore this E-mail if you have already submitted your Appraisal.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>Senior HR and Admin Officer<br>%3</p>';
        Recipient: List of [Text];
        EmailBody, Subject : Text;
    begin
        AppraisalPeriods.Reset();
        AppraisalPeriods.SetRange(Active, true);
        AppraisalPeriods.SetFilter("Submission Due Date", '<>%1', 0D);
        if AppraisalPeriods.FindLast() then
            if (Today() - AppraisalPeriods."Submission Due Date") = 7 then begin //Add to setup
                CompanyInfo.get();
                CompanyInfo.TestField(Name);

                HRSetup.Get();
                HRSetup.TestField("Human Resource Emails");

                Employee.Reset();
                Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
                Employee.SetRange(Status, Employee.Status::Active);
                if Employee.FindSet() then
                    repeat
                        Subject := 'Performance Appraisal Submission';
                        Clear(Recipient);
                        Recipient.Add(Employee."Company E-Mail");
                        EmailBody := StrSubstNo(NewBody, Employee.FullName(), AppraisalPeriods.Description, CompanyInfo.Name);
                        EmailMessage.Create(Recipient, Subject, EmailBody, true);
                        Email.Send(EmailMessage);
                    until Employee.Next() = 0;
            end;
    end;

    procedure BirthdayMessage()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        BirthDate, BirthMonth, TodayDate, TodayMonth : Integer;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">%2 wishes you the very best as you celebrate this important day. Wishing you joyous years ahead!</p><p style="font-family:Verdana,Arial;font-size:10pt">Happy Birthday.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>HR and Admin<br>%2</p>';
        Recipient: List of [Text];
        EmailBody, Subject : Text;
    begin
        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Birth Date", '<>%1', 0D);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");

            TodayDate := Date2DMY(Today(), 1);
            TodayMonth := Date2DMY(Today(), 2);

            repeat
                BirthDate := Date2DMY(Employee."Birth Date", 1);
                BirthMonth := Date2DMY(Employee."Birth Date", 2);

                if (BirthDate = TodayDate) and (BirthMonth = TodayMonth) then begin
                    Subject := 'Happy Birthday';
                    Clear(Recipient);
                    Recipient.Add(Employee."Company E-Mail");
                    EmailBody := StrSubstNo(NewBody, Employee.FullName(), CompanyInfo.Name);
                    EmailMessage.Create(Recipient, Subject, EmailBody, true);
                    Email.Send(EmailMessage);
                end;
            until Employee.Next() = 0;
        end;
    end;

    procedure YearsOfServiceNotification()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">Congratulations on achieving %2 of service with %3. We wish you more prosperous and enjoyable years with us.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>Senior HR and Admin Officer<br>%3</p>';
        Recipient, RecipientBCC, RecipientCC : List of [Text];
        EmailBody, Subject : Text;
    begin
        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Date Of Join", '<>%1', 0D);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");
            repeat
                Employee.Validate("Date Of Join");
                Employee.Modify();

                if Employee."Employment Date - Age" in ['10 Years', '15 Years', '20 Years', '25 Years', '30 Years'] then begin
                    Subject := Employee."Employment Date - Age" + ' of Service';
                    Clear(Recipient);
                    Clear(RecipientCC);
                    Clear(RecipientBCC);
                    Recipient.Add(Employee."Company E-Mail");
                    RecipientCC.Add(HRSetup."Human Resource Emails");
                    if HRSetup."CEO Email" <> '' then
                        RecipientCC.Add(HRSetup."CEO Email");
                    EmailBody := StrSubstNo(NewBody, Employee.FullName(), Employee."Employment Date - Age", CompanyInfo.Name);
                    EmailMessage.Create(Recipient, Subject, EmailBody, true, RecipientCC, RecipientBCC);
                    Email.Send(EmailMessage);
                end;
            until Employee.Next() = 0;
        end;
    end;

    procedure EmployeeAnniversaryNotification()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        PayrollManagement: Codeunit "Payroll";
        NextPointer, NextScale : Code[20];
        CurrentDay, CurrentMonth, JoinDay, JoinMonth : Integer;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To<b> HR and Admin,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that the step anniversary date for Employee No. <strong>%1<strong> - <strong>%2<strong> falls on %3.</p><p style="font-family:Verdana,Arial;font-size:10pt">Their current details are as follows: Current Grade: <strong>%5</strong> & Current Step: <strong>%6</strong>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Their new details are as follows: New Grade: <strong>%7</strong> & New Step: <strong>%8</strong> </p><p style="font-family:Verdana,Arial;font-size:10pt">Thank you,<br>%4.</p>';
        Recipient, RecipientBCC, RecipientCC : List of [Text];
        EmailBody, Subject : Text;
    begin
        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Date Of Join", '<>%1', 0D);
        if Employee.FindSet() then
            repeat
                CompanyInfo.get();
                CompanyInfo.TestField(Name);

                HRSetup.Get();
                HRSetup.TestField("Human Resource Emails");

                JoinDay := Date2DMY(Employee."Date Of Join", 1);
                JoinMonth := Date2DMY(Employee."Date Of Join", 2);

                CurrentDay := Date2DMY(Today(), 1);
                CurrentMonth := Date2DMY(Today(), 2);

                if (JoinDay = CurrentDay) and (JoinMonth = CurrentMonth) then begin

                    PayrollManagement.GetNextSalaryScale(Employee, NextScale, NextPointer);

                    Subject := 'Employee Anniversary';
                    Clear(Recipient);
                    Recipient.Add(HRSetup."Human Resource Emails");
                    if HRSetup."CEO Email" <> '' then
                        RecipientCC.Add(HRSetup."CEO Email");
                    EmailBody := StrSubstNo(NewBody, Employee."No.", Employee.FullName(), Format(Today()), CompanyInfo.Name, Employee."Salary Scale", Employee."Present Pointer", NextScale, NextPointer);
                    EmailMessage.Create(Recipient, Subject, EmailBody, true, RecipientCC, RecipientBCC);
                    Email.Send(EmailMessage);
                end;
            until Employee.Next() = 0;
    end;

    procedure RetirementMessage()
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EndDate: Date;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">%2 wishes you the very best as you celebrate this important day. Wishing you joyous years ahead!</p><p style="font-family:Verdana,Arial;font-size:10pt">Happy Birthday.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>Senior HR and Admin Officer<br>%2</p>';
        Recipient: List of [Text];
        EmailBody, Subject : Text;
    begin
        Employee.Reset();
        Employee.SetFilter("Employee Type", '<>%1', Employee."Employee Type"::"Board Member");
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetFilter("Retirement Date", '<>%1', 0D);
        if Employee.FindSet() then begin
            CompanyInfo.get();
            CompanyInfo.TestField(Name);

            HRSetup.Get();
            HRSetup.TestField("Human Resource Emails");
            EndDate := CalcDate('1M', Today());

            repeat
                //if Employee."Retirement Date" then begin
                Subject := 'Retirement';
                Clear(Recipient);
                Recipient.Add(Employee."Company E-Mail");
                EmailBody := StrSubstNo(NewBody, Employee.FullName(), CompanyInfo.Name);
                EmailMessage.Create(Recipient, Subject, EmailBody, true);
                Email.Send(EmailMessage);
            //end;
            until Employee.Next() = 0;
        end;
    end;
}






