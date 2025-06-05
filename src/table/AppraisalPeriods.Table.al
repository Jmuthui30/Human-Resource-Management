table 52039 "Appraisal Periods"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Periods';
    fields
    {
        field(1; Period; Code[30])
        {
            NotBlank = true;
            Caption = 'Period';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                if Date2DMY("Start Date", 3) <> Date2DMY(Today, 3) then
                    Error(DateMustBeInCurrYearErr);
            end;
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                if Date2DMY("End Date", 3) <> Date2DMY(Today, 3) then
                    Error(DateMustBeInCurrYearErr);
            end;
        }
        field(5; "Appraisal Category"; Code[20])
        {
            Caption = 'Appraisal Category';
        }
        field(6; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(7; Type; Option)
        {
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ","Mid-Year","Final Year";
            Caption = 'Type';
        }
        field(8; "Appraisal Type"; Option)
        {
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ","Mid-Year","Final Year";
            Caption = 'Appraisal Type';
        }
        field(9; "Submission Due Date"; Date)
        {
            Caption = 'Submission Due Date';
        }
    }

    keys
    {
        key(Key1; Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Period, Description, "Start Date", "End Date")
        {
        }
    }

    var
        DateMustBeInCurrYearErr: Label 'Date must be in the current year';
}





