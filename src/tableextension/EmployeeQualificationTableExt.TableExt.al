tableextension 52004 "EmployeeQualificationTableExt" extends "Employee Qualification"
{
    fields
    {
        modify("From Date")
        {
            trigger OnAfterValidate()
            begin
                if "From Date" > Today then
                    Error('You can not input a date in the future');

                if "To Date" <> 0D then
                    if "From Date" > "To Date" then
                        Error('From Date can not be greater that To Date');
            end;
        }
        modify("To Date")
        {
            trigger OnAfterValidate()
            begin
                if "To Date" > Today then
                    Error('You can not input a date in the future');

                if "From Date" <> 0D then
                    if "To Date" < "From Date" then
                        Error('To Date can not be earlier than From Date');
            end;
        }
        field(52000; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
            DataClassification = CustomerContent;
            Caption = 'Qualification Type';
        }
        field(52001; Qualification; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification';
        }
        field(52002; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(52003; Grade; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(52004; "Institution Type"; Enum "Education Institution Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Institution Type';
        }
        field(52005; "Institution Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Education Institution"."Institution Code" where(Type = field("Institution Type"));
            Caption = 'Institution Code';

            trigger OnValidate()
            var
                Institutions: Record "Education Institution";
            begin
                if Institutions.Get("Institution Code") then
                    "Institution/Company" := Institutions."Institution Name";
            end;
        }
        field(52006; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            DataClassification = CustomerContent;
            TableRelation = "Field of Study";
        }
        field(52007; "Education Type"; Enum "Education Types")
        {
            Caption = 'Education Type';
            DataClassification = CustomerContent;
        }
        field(52008; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
            DataClassification = CustomerContent;
        }
        field(52009; "Proficiency Level"; Enum "Proficiency Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Proficiency Level';
        }
        field(52010; Country; Code[50])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
    }
}





