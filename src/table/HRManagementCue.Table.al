table 52008 "HR Management Cue"
{
    Caption = 'Human Resource Management Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Employees Active"; Integer)
        {
            Caption = 'Active Employees';
            FieldClass = FlowField;
            CalcFormula = count(Employee where(Status = const(Active),
                                                "Employee Type" = filter(<> "Board Member")));
        }
        field(3; "Employees Inactive"; Integer)
        {
            Caption = 'Inactive Employees';
            FieldClass = FlowField;
            CalcFormula = count(Employee where(Status = filter(Inactive), "Employee Type" = filter(<> "Board Member")));
        }
        field(4; "Vacant Positions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Company Job" where(Vacancy = filter(> 0)));
            Caption = 'Vacant Positions';
        }
        field(5; "Recruitment Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Recruitment Needs" where(Status = filter(<> Released),
                            Approved = const(false)));
            Caption = 'Recruitment Requests';
        }
        field(6; Applicants; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Applicants where(Submitted = filter(false)));
            Caption = 'Applicants';
        }
        field(7; "Recruitment Shortlist"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Recruitment Needs" where("Shortlisting Closed" = filter(false)));
            Caption = 'Recruitment Shortlist';
        }
        field(8; "Interview List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Applicants where(Employ = const(true),
                            Interviewed = filter(false)));
            Caption = 'Interview List';
        }
        field(13; "Leave Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Application" where(Status = filter(<> Released)));
            Caption = 'Leave Applications';
        }
        field(14; "Leave Adjustments"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Bal Adjustment Header" where(Posted = filter(false)));
            Caption = 'Leave Adjustments';
        }
        field(15; "Leave Recalls"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Off/Holiday" where(Status = filter(Open)));
            Caption = 'Leave Recalls';
        }
        field(16; "Employee Discilinary cases"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Discplinary" where(Posted = filter(false)));
            Caption = 'Employee Discilinary cases';
        }
        field(17; "Closed Disciplinary Cases"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Discplinary" where(Posted = filter(true)));
            Caption = 'Closed Disciplinary Cases';
        }
        field(18; "Open Appraisals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status = const(Open)));
            Caption = 'Open Appraisals';
        }
        field(19; "Appraisals Under Review"; Integer)
        {
            Caption = 'Rolleover/Repayments Due';
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status = filter("Mid-Year Approved" | "Pending Approval" | Released),
                            "Appraisal Status" = filter(Review | Set)));
        }
        field(20; "Completed Appraisals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status = filter("Mid-Year Approved" | "Pending Approval" | Released),
                            "Appraisal Status" = filter(Completed)));
            Caption = 'Completed Appraisals';
        }
        field(21; "Appraisals Further Review"; Integer)
        {
            Caption = 'Appraisals Under Further Review';
            FieldClass = FlowField;
            CalcFormula = count("Employee Appraisal" where(Status = filter("Mid-Year Approved" | "Pending Approval" | Released),
                            "Appraisal Status" = filter("Further review")));
        }
        field(22; "Training Needs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Need" where(Status = filter(Open)));
            Caption = 'Training Needs';
        }
        field(23; "Training Needs Applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Need" where(Status = filter(Application)));
            Caption = 'Training Needs Applications';
        }
        field(24; "Training Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Request" where(Status = filter(<> Released)));
            Caption = 'Training Requests';
        }
        field(25; "Approved Training requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Training Request" where(Status = filter(Released)));
            Caption = 'Approved Training requests';
        }
        field(26; "Acting Duties"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Document Type" = const(Acting), Status = filter(<> Approved | Rejected)));
            Caption = 'Acting Duties';
        }
        field(27; "Acting Duties Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Document Type" = const(Acting), Status = filter(Approved)));
            Caption = 'Acting Duties Approved';
        }
        field(28; "Promotions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Document Type" = const(Promotion),
                            Status = filter(<> Approved | Rejected)));
            Caption = 'Promotions';
        }
        field(29; "Promotions Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Employee Acting Position" where("Document Type" = const(Promotion),
                            Status = filter(Approved)));
            Caption = 'Promotions Approved';
        }
        field(30; "Fleet List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset" where("Fixed Asset Type" = filter(Fleet)));
            Caption = 'Fleet List';
        }
        field(31; "Travel Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where(Status = filter(<> Released)));
            Caption = 'Travel Requests';
        }
        field(32; "Travel Requests Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where(Status = filter(Released)));
            Caption = 'Travel Requests Approved';
        }
        field(33; "Ongoing Trips"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where("Transport Status" = filter("On Trip")));
            Caption = 'Ongoing Trips';
        }
        field(34; "Completed Trips"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where("Transport Status" = filter(Completed)));
            Caption = 'Completed Trips';
        }
        field(35; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(36; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(37; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}





