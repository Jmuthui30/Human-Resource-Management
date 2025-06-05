page 52218 "Applicant Job Prof Course"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Applicant Job Professional Course';
    PageType = ListPart;
    SourceTable = "Applicant Job Education";
    SourceTableView = where("Education Level" = filter(Professional));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Qualification Code"; Rec."Qualification Code Prof")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Section/Level"; Rec."Section/Level")
                {
                    ToolTip = 'Specifies the value of the Section/Level field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Applicant No. field';
                }
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Education Level" := Rec."Education Level"::Professional;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Education Level" := Rec."Education Level"::Professional;
    end;
}





