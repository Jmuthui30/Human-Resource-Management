report 52054 "Mail Bulk Payslips"
{
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Mail Bulk Payslips';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Status = filter(Active));

            trigger OnAfterGetRecord()
            begin

                Employee.TestField("Company E-Mail");

                //Check Period Entries
                AssignMatrix.Reset();
                AssignMatrix.SetRange("Employee No", Employee."No.");
                AssignMatrix.SetRange("Payroll Period", PayPeriod);
                if not AssignMatrix.Find('-') then
                    CurrReport.Skip();

                Percentage := (Round(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, (Format(Employee."No.") + '-' + Employee.FullName()));

                if (Employee."Birth Date" <> 0D) then begin
                    Employee.Validate("Birth Date");
                    Employee.Modify();
                end;

                //Send Payslips
                Clear(Receipient);
                Receipient.Add(Employee."Company E-Mail");
                Subject := 'Payslip for  Period - ' + PayPeriodText;
                TimeNow := Format(Time);
                FileName := PayPeriodText + '-' + Employee."No." + '.pdf';

                FormattedBody := StrSubstNo(NewBody, Employee."First Name", PayPeriodText, HRSetup."General Payslip Message");
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);

                //Save Pdf
                EmpRec.Reset();
                EmpRec.SetRange("No.", Employee."No.");
                EmpRec.SetRange("Pay Period Filter", PayPeriod);
                if EmpRec.FindFirst() then begin
                    Clear(Payslip);
                    Payslip.SetTableView(EmpRec);
                    TempBlob.CreateOutStream(OutStr);
                    if Payslip.SaveAs('', ReportFormat::Pdf, OutStr) then begin
                        TempBlob.CreateInStream(InStr);
                        Base64Text := Base64Conv.ToBase64(InStr);
                        EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Text);
                    end;
                end;

                Email.Send(EmailMessage);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Payslips sent Successfully!');
            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Sending Payslips: @1@@@@@@@@@@@@@@@' + 'Employee:#2###############');
                TotalCount := Count;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("Pay Period"; PayPeriod)
                {
                    TableRelation = "Payroll Period"."Starting Date";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PayPeriod field';
                }
            }
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin

        if PayPeriod = 0D then
            Error(Error0001);

        //Init File System
        HRSetup.Get();
        HRSetup.TestField("General Payslip Message");
        HRSetup.TestField("Human Resource Emails");

        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        PayPeriodText := Format(PayPeriod, 0, '<Month Text> <Year4>');
        SenderName := HRSetup."General Payslip Message";
        SenderAddress := HRSetup."Human Resource Emails";
    end;

    var
        AssignMatrix: Record "Assignment Matrix";
        CompanyInfo: Record "Company Information";
        EmpRec: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Payslip: Report "Payslipx New";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        PayPeriod: Date;
        Window: Dialog;
        InStr: InStream;
        Counter: Integer;
        Percentage: Integer;
        TotalCount: Integer;
        Error0001: Label 'Please define a payment period';
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Kindly find attached your Payslip for the Month of <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>%3</Strong>';
        Receipient: List of [Text];
        OutStr: OutStream;
        ReportFormat: ReportFormat;
        Base64Text: Text;
        FileName: Text;
        FormattedBody: Text;
        PayPeriodText: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
}





