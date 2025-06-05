report 52008 "HR Notifications"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;
    Caption = 'HR Notifications';
    dataset
    {
        /* dataitem(Employee; Employee)
        {
            DataItemTableView = where("Birth Date" = filter(<> 0D));

            trigger OnAfterGetRecord()
            begin
                // EmployeeBirthday;
                // FleetNextService(FA."No.");
                Hrmgt.EmployeeBirthday(Employee);
            end;
        } */
    }

    trigger OnPostReport()
    begin
        HRNotifications.BirthdayMessage();
        HRNotifications.YearsOfServiceNotification();
        HRNotifications.EmployeeAnniversaryNotification();
    end;

    var
        CompanyInfo: Record "Company Information";
        HRNotifications: Codeunit "HR Notifications";

    procedure ContractEndNotice(EmployeeNo: Code[50])
    var
        Employee: Record Employee;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        ContractEndDate: Date;
        TodayDate: Date;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your Contract is ending<br> Kindly Re-Apply for another Contract<br> Thank you. <br> Kind Regards, <br> %2';
        FormattedBody: Text;
        Receipient: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin

        TodayDate := Today;

        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        //Employee.SETRANGE("Contract Type",Employee."Contract Type"::);
        if Employee.Find('-') then begin
            ContractEndDate := Employee."Contract End Date";
            if TodayDate = CalcDate('-9M', ContractEndDate) then begin
                CompanyInfo.Get();
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");

                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient := Employee."E-Mail";
                Subject := 'Contract End';
                TimeNow := Format(Time);

                FormattedBody := StrSubstNo(NewBody, Employee."First Name", CompanyInfo.Name);
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);
            end;
        end;
    end;

    procedure EmployeeBirthday()
    var
        Employee: Record Employee;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        BirthDate: Integer;
        BirthMonth: Integer;
        TodayDate: Integer;
        TodayMonth: Integer;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">HAPPY BIRTHDAY<br> Enjoy!<br> Thank you. <br> Kind Regards, <br> %2';
        FormattedBody: Text;
        Receipient: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin

        TodayDate := Date2DMY(Today, 1);
        TodayMonth := Date2DMY(Today, 2);
        BirthDate := 0;
        BirthMonth := 0;

        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetRange("No.", Employee."No.");
        if Employee.Find('-') then begin
            BirthDate := Date2DMY(Employee."Birth Date", 1);
            BirthMonth := Date2DMY(Employee."Birth Date", 2);
            if (BirthDate = TodayDate) and (BirthMonth = TodayMonth) then begin
                CompanyInfo.Get();
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");

                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient := Employee."E-Mail";
                Subject := 'Happy Birthday';
                TimeNow := Format(Time);

                FormattedBody := StrSubstNo(NewBody, Employee."First Name", CompanyInfo.Name);
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);
            end;
        end;
    end;

    procedure FleetNextService(FleetNo: Code[10]) EmployeeEmail: Text
    var
        Maintain: Record "Maintenance Registration";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TodayDate: Date;
        NewBody: Label 'Body';
        Receipient: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        TodayDate := Today;

        Maintain.Reset();
        Maintain.SetRange("FA No.", FleetNo);
        if Maintain.Find('-') then
            if TodayDate = CalcDate('-1D', Today) then begin
                CompanyInfo.Get();
                CompanyInfo.TestField(Name);
                CompanyInfo.TestField("E-Mail");

                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient := EmployeeEmail;
                Subject := 'Vehicle Service';
                TimeNow := Format(Time);

                EmailMessage.Create(Receipient, Subject, NewBody, true);
                Email.Send(EmailMessage);
            end;
    end;
}





