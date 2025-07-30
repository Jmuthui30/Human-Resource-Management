table 52276 "Leave ApplicationType"
{
    DataClassification = CustomerContent;
    Caption = 'Leave Application Type';
    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
        }
        field(11; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";
            Caption = 'Employee No';
            trigger OnValidate()
            begin
            end;
        }

        field(3; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Type".Code where(Status = const(Active));
            Caption = 'Leave Type';

            trigger OnValidate()
            var
                LeaveApplication: Record "Leave Application";
                OpenPendingLeaveErr: Label 'You have an open/pending %1 leave application %2. Kindly process that one before creating a new one';
            begin
                "Leave Entitlment" := 0;

                if EmployeeRec.Get("Employee No") then begin
                    LeaveTypes.Get("Leave Type");

                    if LeaveTypes.Gender = LeaveTypes.Gender::Female then
                        if EmployeeRec.Gender = EmployeeRec.Gender::Male then
                            Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                    if LeaveTypes.Gender = LeaveTypes.Gender::Male then
                        if EmployeeRec.Gender = EmployeeRec.Gender::Female then
                            Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                    "Date of Joining Company" := EmployeeRec."Date Of Join";
                    "Leave Earned to Date" := HRManagement.GetLeaveDaysEarnedToDate(employeerec, "Leave Type");
                    Message('leave earned to date %1', "Leave Earned to Date");

                end;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            Caption = 'Days Applied';

            trigger OnValidate()
            var
                LeaveEarnedToDateErr: Label 'You can not apply for more days than %1 No. of days earned to date';
            begin


                if "Days Applied" < 1 then
                    Error(Error009);

                TestField("Leave Code");
                CalcFields("Leave Balance");

                if GuiAllowed then begin
                    if "Days Applied" > "Leave Earned to Date" then
                        Message(LeaveEarnedToDateErr, "Leave Earned to Date");

                    if "Days Applied" > "Leave Balance" then
                        Message(Error008);
                end;

                Validate("Start Date");
                Validate("Leave Code");
                CalcFields("Leave Balance");
                "Annual Leave Entitlement Bal" := "Leave Balance";

                if LeaveTypes.Get("Leave Code") then
                    if LeaveTypes."Annual Leave" then
                        "Annual Leave Entitlement Bal" := "Leave Balance" + -"Days Applied"
                    else
                        "Annual Leave Entitlement Bal" := "Leave Balance";
            end;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            var
                BaseCalenderCode: Code[10];
            begin
                LeaveLedger.Reset();
                LeaveLedger.SetRange("Staff No.", "Employee No");
                LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Negative);
                LeaveLedger.SetRange(Closed, false);
                if LeaveLedger.FindLast() then
                    if (LeaveLedger."Leave End Date" > "Start Date") and (LeaveLedger."Leave Start Date" < "Start Date") then
                        Error('You have a running %1 leave ending on %2', LeaveLedger."Leave Type", LeaveLedger."Leave End Date");



                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Default Base Calendar");

                //Get employee base calendar
                EmployeeRec.Get("Employee No");
                if EmployeeRec."Base Calendar" <> '' then
                    BaseCalenderCode := EmployeeRec."Base Calendar"
                else
                    BaseCalenderCode := HumanResSetup."Default Base Calendar";

                NoOfWorkingDays := 0;
                if "Days Applied" <> 0 then
                    if "Start Date" <> 0D then begin
                        NextWorkingDate := "Start Date";
                        repeat
                            if not HRmgt.CheckNonWorkingDay(BaseCalenderCode, NextWorkingDate, Description) then
                                NoOfWorkingDays := NoOfWorkingDays + 1;

                            if LeaveTypes.Get("Leave Code") then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset();
                                    BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", BaseCalenderCode);
                                    BaseCalendar.SetRange(BaseCalendar.Date, NextWorkingDate);
                                    BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.Find('-') then
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                end;

                                if LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 6);

                                    if BaseCalender.Find('-') then
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                end;


                                if LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 7);
                                    if BaseCalender.Find('-') then
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                end;


                                if LeaveTypes."Off/Holidays Days Leave" then;

                            end;

                            NextWorkingDate := CalcDate('1D', NextWorkingDate);
                        until NoOfWorkingDays = "Days Applied";
                        "End Date" := NextWorkingDate - 1;
                        "Resumption Date" := NextWorkingDate;
                    end;

                //check if the date that the person is supposed to report back is a working day or not
                //get base calendar to use
                NonWorkingDay := false;
                if "Start Date" <> 0D then
                    while NonWorkingDay = false
                      do begin
                        NonWorkingDay := HRmgt.CheckNonWorkingDay(HumanResSetup."Default Base Calendar", "Resumption Date", Dsptn);
                        if NonWorkingDay then begin
                            NonWorkingDay := false;
                            "Resumption Date" := CalcDate('1D', "Resumption Date");
                        end
                        else
                            NonWorkingDay := true;
                    end;


            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin


                Validate("Start Date");
                Validate("Leave Code");
            end;
        }
        field(7; "Application Date"; Date)
        {
            Editable = false;
            Caption = 'Application Date';

            trigger OnValidate()
            begin
                if "Leave Code" <> '' then
                    Validate("Leave Code");
            end;
        }

        field(21; days; Decimal)
        {
            Caption = 'days';
        }
        field(23; "No. series"; Code[10])
        {
            Caption = 'No. series';
        }
        field(24; "Leave Balance"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("Employee No"),
                                                                             "Leave Type" = field("Leave Type"),
                                                                             Closed = const(false)));
            FieldClass = FlowField;
            Caption = 'Leave Balance';

        }
        field(25; "Resumption Date"; Date)
        {
            Caption = 'Resumption Date';
        }

        field(28; "Leave Entitlment"; Decimal)
        {
            Caption = 'Leave Entitlment';
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = - sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("Employee No"),
                                                                              "Leave Type" = field("Leave Code"),
                                                                              Closed = const(false),
                                                                              "Leave Entry Type" = const(Negative)));
            FieldClass = FlowField;
            Caption = 'Total Leave Days Taken';
        }
        field(30; "Duties Taken Over By"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Duties Taken Over By';

            trigger OnValidate()
            begin


                if EmployeeRec.Get("Employee No") then begin
                    EmployeeRec.SetRange("No.", "Duties Taken Over By");
                    if EmployeeRec.Find('-') then
                        if "Duties Taken Over By" = "Employee No" then
                            Error('You Cannot take duties over for yourself')


                end;
            end;
        }
        field(33; "Balance brought forward"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("Employee No"),
                                                                                         "Transaction Type" = filter("Leave B/F"),
                                                                                         "Leave Type" = field("Leave Code"),
                                                                                         Closed = const(false)));
            FieldClass = FlowField;
            Caption = 'Balance brought forward';
        }
        field(34; "Leave Earned to Date"; Decimal)
        {
            Caption = 'Leave Earned to Date';
            Editable = false;
        }
        field(35; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
        }
        field(36; "Date of Joining Company"; Date)
        {
            Caption = 'Date of Joining Company';
        }
        field(37; "Fiscal Start Date"; Date)
        {
            Caption = 'Fiscal Start Date';
        }
        field(38; "No. of Months Worked"; Decimal)
        {
            Caption = 'No. of Months Worked';
        }
        field(39; "Annual Leave Entitlement Bal"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Annual Leave Entitlement Bal';
        }
        field(40; "Recalled Days"; Decimal)
        {
            CalcFormula = sum("Employee Off/Holiday"."No. of Off Days" where("Employee No" = field("Employee No")));
            FieldClass = FlowField;
            Caption = 'Recalled Days';
        }
        field(41; "Off Days"; Decimal)
        {
            CalcFormula = sum("Holiday_Off Days"."No. of Days" where("Employee No." = field("Employee No"),
                                                                      "Leave Type" = field("Leave Code"),
                                                                      "Maturity Date" = field("Maturity Date")));
            FieldClass = FlowField;
            Caption = 'Off Days';
        }


        field(45; "Days Absent"; Decimal)
        {
            CalcFormula = sum("Employee Absence".Quantity where("Employee No." = field("Employee No"),
                                                                 "Affects Leave" = filter(true)));
            FieldClass = FlowField;
            Caption = 'Days Absent';
        }



        field(55; "Leave Period"; Code[20])
        {
            TableRelation = "Leave Period";
            Caption = 'Leave Period';
        }

        field(70; "Leave Allowance Paid"; Boolean)
        {
            Caption = 'Leave Allowance Paid';
        }
        field(12; "Staff No"; Code[20])
        {
            TableRelation = Employee."No." where(Status = const(Active), "Employee Type" = filter(<> "Board Member"));
            Caption = 'Staff No';

            trigger OnValidate()
            begin
                LeaveApp.Get("Leave Code");
                if "Staff No" = LeaveApp."Employee No" then
                    Error('You can not be your own reliever!');

                if Employee.Get("Staff No") then
                    "Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(13; "Staff Name"; Text[100])
        {
            Editable = false;
            Caption = 'Staff Name';
        }

        field(14; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "Leave Code", "Employee No")
        { }

    }


    trigger OnInsert()
    begin
        "Entry No." := "Entry No." + 1;
        "Application Date" := Today;

        FindMaturityDate();
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
        "Leave Period" := HRmgt.GetCurrentLeavePeriodCode();
        LeaveApp.Reset();
        LeaveApp.SetRange(LeaveApp."Application No", "Leave Code");
        if LeaveApp.FindFirst() then begin
            "Employee No" := LeaveApp."Employee No";
            // "Leave Period" := LeaveApp."Leave Period";
        end;

    end;

    trigger OnRename()
    begin


    end;

    var
        BaseCalendar: Record "Base Calendar Change";
        BaseCalender: Record Date;
        EmployeeRec: Record Employee;
        LeaveLedger: Record "HR Leave Ledger Entries";
        HRSetup: Record "Human Resources Setup";
        HumanResSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Type";
        UserSertup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        HRmgt: Codeunit "HR Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NonWorkingDay: Boolean;
        FiscalStart: Date;
        MaturityDate: Date;
        NextWorkingDate: Date;
        TotalQualifiedDays: Decimal;
        NoOfWorkingDays: Integer;
        Error007: Label 'You cannot Rename the Record';
        Error008: Label 'The Number of Days applied is more than your Leave Days Balance ';
        Error009: Label 'You cannot take a Leave less than 1 Day';
        Description: Text[30];
        Dsptn: Text[30];
        HRManagement: Codeunit "HR Management";
        LeaveEarnedToDate: Decimal;
        Employee: Record Employee;
        LeaveApp: Record "Leave Application";


    procedure FindMaturityDate()
    var
        AccPeriod: Record "Payroll Period";
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            // repeat
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
            //until AccPeriod.Next = 0;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"Leave Application", "Employee No", FieldNumber, ShortcutDimCode);
        Modify();
    end;
}


