table 52041 "Travel Requests"
{
    DrillDownPageId = "Transport Request";
    LookupPageId = "Transport Request";
    DataClassification = CustomerContent;
    Caption = 'Travel Requests';
    fields
    {
        field(1; "Request No."; Code[30])
        {
            Editable = false;
            Caption = 'Request No.';
        }
        field(2; "Request Date"; Date)
        {
            Editable = false;
            Caption = 'Request Date';
        }
        field(3; "Request ID"; Code[30])
        {
            Caption = 'Request ID';
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                /*
                if Empl.Get("Employee No.") then
                  begin
                    "Employee Name":=Empl."First Name"+' '+Empl."Middle Name"+' '+Empl."Last Name";
                    "Employee Type":=Empl."Nature of Employment";
                
                  end;
                  */

            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            Editable = false;
            Caption = 'Employee Name';
        }
        field(6; "Trip Planned Start Date"; Date)
        {
            Caption = 'Trip Planned Start Date';

            trigger OnValidate()
            begin

                if "Trip Planned Start Date" < Today then Error('Planned start date cannot be earlier than today');
            end;
        }
        field(7; "Trip Planned End Date"; Date)
        {
            Caption = 'Trip Planned End Date';

            trigger OnValidate()
            begin
                begin
                    if "Trip Planned End Date" < Today then Error('Planned end date cannot be earlier than today');
                    if "Trip Planned End Date" < "Trip Planned Start Date" then Error('Planned end date cannot be earlier than planned start date');
                end;
            end;
        }
        field(8; Destinations; Text[250])
        {
            Caption = 'Destinations';
        }
        field(9; "Geographical Terrain"; Text[30])
        {
            Caption = 'Geographical Terrain';
        }
        field(10; "No. of Personnel"; Integer)
        {
            CalcFormula = count("Travelling Employee" where("Request No." = field("Request No.")));
            FieldClass = FlowField;
            Caption = 'No. of Personnel';
        }
        field(11; "Predicted Weather Conditions"; Text[30])
        {
            Caption = 'Predicted Weather Conditions';
        }
        field(12; "Vehicle Allocated"; Code[30])
        {
            TableRelation = "Fixed Asset" where("FA Class Code" = const('MV'));
            Caption = 'Vehicle Allocated';

            trigger OnValidate()
            begin

                if FA.Get("Vehicle Allocated") then
                    "Vehicle Description" := FA.Description;

                FA.TestField("Responsible Employee");
                Empl.SetRange("No.", FA."Responsible Employee");
                if Empl.Find('-') then begin
                    Driver := Empl."No.";
                    "Driver Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                end;


                /*
                if Status<>Status::Released then
                Error('You are not allowed to assign a vehicle when the transport request has not been approved');


                 {
                      if FA.Get("Vehicle Allocated") then
                   begin
                   "Vehicle Description":=FA.Description;
                  // "Vehicle Allocated":="Vehicle Description";
                   FA.CalcFields(FA."In Use");
                   if FA."In Use" then
                   Error('This vehicle is currently un-available');
                   end;
                  }
               */

            end;
        }
        field(13; "Outsourced Vehicle Reg No."; Code[10])
        {
            Caption = 'Outsourced Vehicle Reg No.';
        }
        field(14; "Vehicle Owner"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Vehicle Owner';
        }
        field(15; "Odometer Reading Before"; Decimal)
        {
            Caption = 'Odometer Reading Before';

            trigger OnValidate()
            begin

                "Distance Travelled" := ("Odometer Reading After" - "Odometer Reading Before");

                /*
                Mantainance.Reset();
                 Mantainance.SetRange(Mantainance."Item No.","Vehicle Allocated");
                 if Mantainance.Find('+') then begin
                    if "Odometer Reading Before">=(Mantainance."Current Odometer Reading"+Mantainance."Service Mileage") then begin
                          CompanyInfo.Get();
                      Recipients:=CompanyInfo."Fleet Manager Support Email";
                      CompanyInfo.Get();
                      SenderName:=CompanyName;
                      SenderAddress:=CompanyInfo."E-Mail";
                      Subject:='Vehicle Mantainace '+"Vehicle Allocated";
                      Body:=StrSubstNo('This is to notify you that the Vehicle No. %1 is due for servicing',"Vehicle Allocated");
                      SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,true);
                      SMTPSetup.Send();
                
                    end;
                 end;
                */

            end;
        }
        field(16; "Odometer Reading After"; Decimal)
        {
            Caption = 'Odometer Reading After';

            trigger OnValidate()
            begin
                "Distance Travelled" := ("Odometer Reading After" - "Odometer Reading Before");

                /*
                Mantainance.Reset();
                Mantainance.SetRange(Mantainance."Item No.","Vehicle Allocated");
                if Mantainance.Find('+') then begin
                   if "Odometer Reading Before">=(Mantainance."Current Odometer Reading"+Mantainance."Service Mileage") then begin
                         CompanyInfo.Get();
                     Recipients:=CompanyInfo."Fleet Manager Support Email";
                     CompanyInfo.Get();
                     SenderName:=CompanyName;
                     SenderAddress:=CompanyInfo."E-Mail";
                     Subject:='Vehicle Mantainace '+"Vehicle Allocated";
                     Body:=StrSubstNo('This is to notify you that the Vehicle No. %1 is due for servicing',"Vehicle Allocated");
                     SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,true);
                     SMTPSetup.Send();

                   end;
               end
               */

            end;
        }
        field(17; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(18; Country; Code[10])
        {
            Caption = 'Country';
        }
        field(19; "Town/City"; Code[10])
        {
            Caption = 'Town/City';
        }
        field(20; Status; Option)
        {
            OptionCaption = 'Open,Approved,Pending Approval,Pending Prepayment,Rejected';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
            Caption = 'Status';
        }
        field(21; "No. of Approvals"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Document No." = field("Request No.")));
            FieldClass = FlowField;
            Caption = 'No. of Approvals';
        }
        field(22; "Reason for Travel"; Text[250])
        {
            Caption = 'Reason for Travel';
        }
        field(23; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(24; "Return Date"; Date)
        {
            Caption = 'Return Date';
        }
        field(25; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(26; "Return Time"; Time)
        {
            Caption = 'Return Time';
        }
        field(27; "Vehicle Description"; Text[80])
        {
            Caption = 'Vehicle Description';
        }
        field(28; "User ID"; Code[30])
        {
            TableRelation = "User Setup";
            Caption = 'User ID';
        }
        field(29; "Travel Details"; Text[250])
        {
            Caption = 'Travel Details';
        }
        field(30; Driver; Code[20])
        {
            Caption = 'Driver';

            trigger OnValidate()
            begin
                /*
                 if Status<>Status::Released then
                 Error('You are not allowed to assign a driver when the transport request has not been approved');
                
                 if Empl.Get(Driver) then
                // BEGIN
                 "Driver Name":=Empl."First Name"+' '+Empl."Middle Name"+' '+Empl."Last Name";
                
                 TestField("Vehicle Allocated");
                
                TravellingEmployees.Reset();
                TravellingEmployees.SetRange(TravellingEmployees."Request No.","Request No.");
                if TravellingEmployees.Find('-') then
                begin
                 repeat
                 UserSetup.Reset();
                 UserSetup.SetRange(UserSetup."Employee No.",TravellingEmployees."Employee No.");
                 if UserSetup.Find('-') then
                 begin
                   UserSetup.TestField(UserSetup."E-Mail");
                  Recipients:=UserSetup."E-Mail";
                
                  CompanyInfo.Get();
                  SenderName:=CompanyName;
                  SenderAddress:=CompanyInfo."Fleet Manager Support Email";
                
                  Subject:='Vehicle Allocation for Transport Request '+"Request No.";
                  Body:='This is to inform you that you have been allocated Vehicle No '+"Vehicle Allocated"+', '+"Vehicle Description"+' and Driver '+"Driver Name"+' for the trip to '+Destination;
                  SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,true);
                  SMTPSetup.Send();
                  end;
                 until TravellingEmployees.Next()=0;
                end;
                */

            end;
        }
        field(31; "Driver Name"; Text[50])
        {
            Caption = 'Driver Name';
        }
        field(32; "No of Cars"; Option)
        {
            OptionMembers = Taxi,"Company Car";
            Caption = 'No of Cars';
        }
        field(33; Cancelled; Boolean)
        {
            Caption = 'Cancelled';

            trigger OnValidate()
            begin
                /*
                         if Cancelled=true then  begin
               Message('The trip request is been cancelled');
                   ToName:='';
                   CName:='';

               Subject:='Your vehicle request has been cancelled ';
               Body:='You vehicle Request has been cancelled';
               UserSetup.Get("User ID");
               ToName:=UserSetup."E-Mail";
               //CCName:='navadmin@erc.go.ke';
               MailSent := Mail.NewMessage(ToName,CName,Subject,Body,'',false);
               if MailSent then
               // MailSent:=Mail.Send()
               Message('The trip request has been cancelled')
                else
                   MailSent := Mail.Send();

                          end;
                         if Cancelled=false then  begin
                         Message('You are about to revert the cancelled trip?');
                          end;
               */

            end;
        }
        field(34; "No. of Non Employees"; Integer)
        {
            CalcFormula = count("Travelling Non Employees" where("Request No." = field("Request No.")));
            FieldClass = FlowField;
            TableRelation = "Travelling Non Employees";
            Caption = 'No. of Non Employees';
        }
        field(35; "Shortcut Dimension 1"; Code[30])
        {
            Editable = false;
            Caption = 'Shortcut Dimension 1';
        }
        field(36; "Department Name"; Text[50])
        {
            Editable = false;
            FieldClass = Normal;
            Caption = 'Department Name';
        }
        field(38; "Directorate name"; Text[50])
        {
            Caption = 'Directorate name';
        }
        field(39; "Fuel Consumed"; Decimal)
        {
            Caption = 'Fuel Consumed';
        }
        field(40; "Number of Passengers"; Code[20])
        {
            Caption = 'Number of Passengers';
        }
        field(41; "Distance Travelled"; Decimal)
        {
            Editable = false;
            Caption = 'Distance Travelled';
        }
        field(42; "Estimated Fuel Cost"; Decimal)
        {
            Caption = 'Estimated Fuel Cost';
        }
        field(43; "Estimated Mileage/Mantain-Cost"; Decimal)
        {
            Caption = 'Estimated Mileage/Mantain-Cost';
        }
        field(44; "Travel Cost"; Decimal)
        {
            Caption = 'Travel Cost';
        }
        field(45; "Request Type"; Option)
        {
            OptionCaption = 'Travel,Event';
            OptionMembers = Travel,Eplan;
            Caption = 'Request Type';
        }
        field(46; "Event No"; Code[10])
        {
            Caption = 'Event No';
        }
        field(47; "Event Description"; Text[250])
        {
            Caption = 'Event Description';
        }
        field(48; "Global Dimension 4 code"; Code[20])
        {
            Caption = 'Global Dimension 4 code';
        }
        field(49; "Language Code"; Code[10])
        {
            TableRelation = Language;
            Caption = 'Language Code';
        }
        field(50; "Employees Attending"; Integer)
        {
            CalcFormula = count("Travelling Employee" where("Request No." = field("Request No.")));
            FieldClass = FlowField;
            TableRelation = "Travelling Employee";
            Caption = 'Employees Attending';
        }
        field(51; "Other Participants Attending"; Integer)
        {
            Caption = 'Other Participants Attending';
        }
        field(52; "Employee Type"; Code[20])
        {
            Caption = 'Employee Type';
        }
        field(53; "Shortcut Dimension 2"; Code[30])
        {
            Caption = 'Shortcut Dimension 2';
        }
        field(54; Department; Code[30])
        {
            Caption = 'Department';

            trigger OnValidate()
            begin
                Dim.Reset();
                Dim.SetRange(Code, "Shortcut Dimension 1 Code");
                if Dim.Find('-') then
                    "Department Name" := Dim.Name;
            end;
        }
        field(55; "No of Vehicles"; Integer)
        {
            CalcFormula = count("Transport Trips" where("Request No" = field("Request No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No of Vehicles';
        }
        field(56; Destination; Code[20])
        {
            TableRelation = Destination;
            Caption = 'Destination';
        }
        field(50000; "Total Approved Amount"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Total Approved Amount';
        }
        field(50001; "Total Amount Requested"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Total Amount Requested';
        }
        field(50002; "Event Code"; Code[10])
        {
            Caption = 'Event Code';

            trigger OnValidate()
            begin
                /*
                DimensionValue.Reset();
                DimensionValue.SetRange(DimensionValue.Code,"Event Code");
                if DimensionValue.Find('-')then
                "Event Description":=DimensionValue.Name;
                */

            end;
        }
        field(50003; "Shortcut Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';

            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
            //Blocked = FILTER(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Dim.Reset();
                Dim.SetRange(Code, "Shortcut Dimension 2 Code");
                if Dim.Find('-') then
                    "Department Name" := Dim.Name;
            end;
        }
        field(50004; "Shortcut Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = filter(false));

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50005; "Request Time"; Time)
        {
            Caption = 'Request Time';
        }
        field(50006; "Transport Status"; Option)
        {
            OptionCaption = 'Requisition,On Trip,Completed';
            OptionMembers = Requisition,"On Trip",Completed;
            Caption = 'Transport Status';
        }
        field(50007; "Mode of Travel"; Option)
        {
            OptionCaption = ' ,Road,Air,Train,Sea';
            OptionMembers = " ",Road,Air,Train,Sea;
            Caption = 'Mode of Travel';
        }
    }

    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Request No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Transport Request Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Transport Request Nos.", xRec."No. Series", 0D, "Request No.", "No. Series");
        end;

        "Request Date" := Today;
        "Request Time" := Time;

        "User ID" := UserId;

        if UserSetup.Get("User ID") then
            if Empl.Get(UserSetup."Employee No.") then begin
                "Employee No." := Empl."No.";
                "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                "Shortcut Dimension 1 Code" := Empl."Global Dimension 1 Code";
                Validate("Shortcut Dimension 1 Code");
                Department := Empl."Global Dimension 1 Code";
                Validate(Department);
                "Shortcut Dimension 2 Code" := Empl."Global Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
            end;
    end;

    var
        Dim: Record "Dimension Value";
        Empl: Record Employee;
        FA: Record "Fixed Asset";
        HRSetup: Record "Human Resources Setup";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        // DimMgt.SaveDefaultDim(DATABASE::"Travel Requests","Employee No.",FieldNumber,ShortcutDimCode);
        // MODIFY;
    end;
}





