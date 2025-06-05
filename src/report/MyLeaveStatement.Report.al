report 52001 "My Leave Statement"
{
    ApplicationArea = All;
    Caption = 'My Leave Statement';

    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/MyLeaveStatement.rdl';

    dataset
    {
        dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
        {
            DataItemTableView = sorting("Entry No.", "Document No.", "Staff No.");

            column(Noofdays_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."No. of days")
            {
            }
            column(PostingDate_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Date")
            {
            }
            column(Balance; Balance)
            {
            }
            column(LeaveEntryType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Entry Type")
            {
            }
            column(LeaveType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Type")
            {
            }
            column(StaffNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Staff No.")
            {
            }
            column(StaffName_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Staff Name")
            {
            }
            column(DocumentNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Document No.")
            {
            }
            column(LeavePeriodCode_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Period Code")
            {
            }
            column(TransactionType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Transaction Type")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }

            //RequestFilterFields = "Staff No.", "Leave Type", "Leave Period Code";
            trigger OnAfterGetRecord()
            begin


            end;

            trigger OnPreDataItem()
            var
                UserSetup: record "User Setup";
            begin
                if UserSetup.Get(UserId) then begin
                    UserSetup.TestField("Employee No.");
                    SetRange("Staff No.", UserSetup."Employee No.");
                end else
                    Error('You have not been set up as a user. Kindly consult IT');

                if LeavePeriodCode <> '' then
                    SetRange("Leave Period Code", LeavePeriodCode);

                if LeaveTypeCode <> '' then
                    SetRange("Leave Type", LeaveTypeCode);

                // HREmp.RESET;
                // HREmp.SETRANGE(HREmp."User ID",USERID);
                // IF HREmp.FIND('-') THEN
                // BEGIN
                //    "HR Leave Ledger Entries".SETFILTER("HR Leave Ledger Entries"."Staff No.",HREmp."No.")
                // END ELSE
                // BEGIN
                //    ERROR('UserID %1 not found in employees table',USERID);
                // END;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(LeavePeriodCode; LeavePeriodCode)
                {
                    ApplicationArea = All;
                    Caption = 'Leave Period';
                    TableRelation = "Leave Period"."Leave Period Code";
                }
                field(LeaveTypeCode; LeaveTypeCode)
                {
                    ApplicationArea = All;
                    Caption = 'Leave Type';
                    TableRelation = "Leave Type".Code;
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
        CI.Reset();
        CI.Get();

        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        LeavePeriodCode: Code[20];
        LeaveTypeCode: Code[20];
        Balance: Decimal;
}


