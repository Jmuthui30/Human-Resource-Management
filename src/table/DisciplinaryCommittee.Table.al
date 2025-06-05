table 52169 "Disciplinary Committee"
{
    Caption = 'Disciplinary Committee';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Case No."; Code[50])
        {
            Caption = 'Case No.';
            DataClassification = CustomerContent;
        }
        field(2; "Committee Member No."; Code[50])
        {
            TableRelation = if ("Member Type" = const("Internal")) Employee where(Status = const(Active));
            ValidateTableRelation = false;
            Caption = 'Employee No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Committee Member No.") then
                    "Committee Member Name" := Employee.FullName();
            end;
        }
        field(3; "Committee Member Name"; Text[100])
        {
            Caption = 'Committee Member Name';
            DataClassification = CustomerContent;
        }
        field(4; "Member Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            Caption = 'Member Type';
        }
    }
    keys
    {
        key(PK; "Case No.", "Committee Member No.")
        {
            Clustered = true;
        }
    }
}






