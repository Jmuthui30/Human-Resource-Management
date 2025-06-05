page 52200 "Academic Qualifications"
{
    ApplicationArea = All;
    Caption = 'Academic Qualifications';
    PageType = List;
    SourceTable = Qualification;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Qualification Type" := Rec."Qualification Type"::Academic;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Qualification Type" := Rec."Qualification Type"::Academic;
    end;
}





