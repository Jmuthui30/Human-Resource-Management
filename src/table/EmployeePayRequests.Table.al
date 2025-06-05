table 52139 "Employee Pay Requests"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Pay Requests';
    fields
    {
        field(1; Date; Date)
        {
            Caption = 'Date';
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    if EmpContract.Get(Emp."Nature of Employment") then
                        "Employee Type" := EmpContract."Employee Type";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(4; Type; Option)
        {
            OptionCaption = 'Casual,Lecturer';
            OptionMembers = Casual,Lecturer;
            Caption = 'Type';
        }
        field(5; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(6; "End Time"; Time)
        {
            Caption = 'End Time';

            trigger OnValidate()
            begin
                "No. of Units" := ("End Time" - "Start Time") / 3600000;
                Validate("No. of Units");
            end;
        }
        field(7; "No. of Units"; Decimal)
        {
            Caption = 'No. of Units';

            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }
        field(8; Remarks; Decimal)
        {
            Caption = 'Remarks';
        }
        field(9; Leason; Code[20])
        {
            Caption = 'Leason';
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(11; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Paid;
            Caption = 'Status';
        }
        field(12; "ED Code"; Code[20])
        {
            Caption = 'ED Code';
        }
        field(13; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(14; "Payment Type"; Code[20])
        {
            TableRelation = "Employee Pay Types";
            Caption = 'Payment Type';

            trigger OnValidate()
            begin
                // IF PayCodes.GET("Payment Type") THEN
                //  "ED Code":=PayCodes."Earning Code";
            end;
        }
        field(15; "USER ID"; Code[40])
        {
            Caption = 'USER ID';
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(18; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
        }
        field(19; "Payroll Period"; Date)
        {
            TableRelation = if ("Employee Type" = filter(Parmanent | Partime | Locum)) "Payroll Period" where(Closed = const(false))
            else
            if ("Employee Type" = filter(Casual)) "Payroll Period Casuals";
            Caption = 'Payroll Period';
        }
        field(20; "Employee Type"; Option)
        {
            OptionCaption = 'Parmanent,Partime,Locum,Casual';
            OptionMembers = Parmanent,Partime,Locum,Casual;
            Caption = 'Employee Type';
        }
        field(21; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
    }

    keys
    {
        key(Key1; "Document No", "Employee No.", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "USER ID" := UserId;

        // IF UserSetup.GET("USER ID") THEN BEGIN
        //  "Employee No.":=UserSetup."Employee No.";
        //  VALIDATE("Employee No.");
        //  IF Emp.GET("Employee No.") THEN BEGIN
        //     VALIDATE("Dimension Set ID","Dimension Set ID");
        //    "Global Dimension 1 Code":= Emp."Global Dimension 1 Code";
        //    "Global Dimension 2 Code":= Emp."Global Dimension 2 Code";
        //  END;
        //  END;
    end;

    var
        Emp: Record Employee;
        EmpContract: Record "Employment Contract";
        DimMgt: Codeunit DimensionManagement;
        PayrollMgt: Codeunit Payroll;

    local procedure CalculateAmount()
    var
        Emp: Record Employee;
        PayTypes: Record "Employee Pay Types";
        ScaleBenefit: Record "Scale Benefits";
        Rate1: Decimal;
    begin
        if PayTypes.Get("Payment Type") then
            case PayTypes."Calculation Type" of
                PayTypes."Calculation Type"::"Salary Scale":

                    if Emp.Get("Employee No.") then begin
                        ScaleBenefit.Reset();
                        ScaleBenefit.SetRange("Salary Scale", Emp."Salary Scale");
                        ScaleBenefit.SetRange("Salary Pointer", Emp."Present Pointer");
                        ScaleBenefit.SetFilter("Payment Option", '<>%1', ScaleBenefit."Payment Option"::Amount);
                        if ScaleBenefit.FindFirst() then begin
                            if ScaleBenefit."Payment Option" = ScaleBenefit."Payment Option"::"Hour Rate" then
                                Rate1 := ScaleBenefit.Rate
                            else
                                if ScaleBenefit."Payment Option" = ScaleBenefit."Payment Option"::Percentage then
                                    Rate1 := ScaleBenefit.Amount * ScaleBenefit.Rate / 30 / 100;

                            //MESSAGE('%1-%2-%3-%4',"Employee No.",ScaleBenefit."Salary Pointer",ScaleBenefit."Salary Scale",ScaleBenefit."Payment Option");
                            "ED Code" := ScaleBenefit."ED Code";
                            Rate := Rate1;

                            Amount := Rate * "No. of Units";
                        end;
                    end;

                PayTypes."Calculation Type"::Formual:

                    Amount := PayrollMgt.GetResult(PayrollMgt.GetPureFormula("Employee No.", PayrollMgt.GetCurrentPayPeriodDate(), PayTypes.Formula)) * "No. of Units";
            end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Employee, "Employee No.", FieldNumber, ShortcutDimCode);
        Modify();
    end;
}





