table 52170 "User Competence"
{
    Caption = 'User Competence';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
                Employee: Record Employee;
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get("User ID");
                "Employee No." := UserSetup."Employee No.";
                Employee.Get("Employee No.");
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(2; "User Competence Description"; Text[100])
        {
            Caption = 'User Competence Description';
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
        }
        field(4; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}






