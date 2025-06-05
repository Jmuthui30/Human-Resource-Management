page 52216 "Company Job Prof course"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Company Job Professional course';
    PageType = ListPart;
    SourceTable = "Company Job Education";
    SourceTableView = where("Education Level" = filter(Professional));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Qualification Code"; Rec."Qualification Code Prof")
                {
                    ToolTip = 'Specifies the value of the Qualification Code Prof field';
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Section/Level"; Rec."Section/Level")
                {
                    ToolTip = 'Specifies the value of the Section/Level field';
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





