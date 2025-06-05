table 52048 "Applicants Qualification"
{
    DataClassification = CustomerContent;
    Caption = 'Applicants Qualification';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Applicants."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            NotBlank = true;
            TableRelation = Qualification;

            trigger OnValidate()
            begin

                Qualifications.Reset();
                Qualifications.SetRange(Qualifications.Code, "Qualification Code");
                if Qualifications.Find('-') then
                    Qualification := Qualifications.Description;



                ShortCriteria.Reset();
                ShortCriteria.SetRange("Need Code", "Need Code");
                ShortCriteria.SetRange(Qualification, "Qualification Code");
                if ShortCriteria.Find('-') then
                    Score := ShortCriteria."Desired Score";
                if ShortCriteria."Desired Score" = Score then
                    Qualified := true
                else
                    Qualified := false;

                /*
                ShortCriteriaHead.Reset();
                ShortCriteriaHead.SetRange("Recruitment Need",Applicant."Need Code");
                if ShortCriteriaHead.FindFirst() then
                  begin
                    ShortCriteria.Reset();
                    ShortCriteria.SetRange("Need Code",ShortCriteriaHead."Recruitment Need");
                    if ShortCriteria.Find('-') then
                      begin
                        AppQualification.Get("Need Code");
                        AppQualification.SetRange("Need Code",ShortCriteria."Need Code");
                        if AppQualification."Qualification Code"=ShortCriteria.Qualification then
                          begin
                            Score:=ShortCriteria."Desired Score";
                            Qualified:=true
                              end else
                            Qualified:=false;
                      end;
                  end;
                */

            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; Institution_Company; Text[100])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Need Code"; Code[50])
        {
            Caption = 'Need Code';
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Qualification"),
                                                                     "No." = field("Employee No."),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(50000; "Qualification Type"; Option)
        {
            NotBlank = false;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
            Caption = 'Qualification Type';
        }
        field(50001; Qualification; Text[200])
        {
            NotBlank = true;
            Caption = 'Qualification';
        }
        field(50003; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(50004; Grade; Text[40])
        {
            Caption = 'Grade';
        }
        field(50005; No; Code[20])
        {
            Caption = 'No';
        }
        field(50006; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
    }

    keys
    {
        key(Key1; No, "Need Code", "Qualification Code")
        {
            Clustered = true;
        }
        key(Key2; "Qualification Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Qualifications: Record Qualification;
        ShortCriteria: Record "R. Shortlisting Criteria";
}





