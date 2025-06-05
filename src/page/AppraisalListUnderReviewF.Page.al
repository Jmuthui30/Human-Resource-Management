page 52189 "Appraisal List - UnderReview-F"
{
    ApplicationArea = All;
    CardPageID = "Appraisal Card-Review";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Appraisal";
    SourceTableView = where(Status = const(Released),
                            "Appraisal Status" = filter(Review));
    Caption = 'Appraisal List - UnderReview-F';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    ToolTip = 'Specifies the value of the Appraisee Name field';
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                    ToolTip = 'Specifies the value of the Appraisee''s Job Title field';
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ToolTip = 'Specifies the value of the Appraiser No field';
                }
            }
        }
    }

    actions
    {
    }

    //Type = CONST ("Final Year"));
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Appraiser ID", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}





