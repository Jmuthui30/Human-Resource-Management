page 52038 "Appraisal List"
{
    ApplicationArea = All;
    CardPageID = "Appraisal Card-New";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Employee Appraisal";
    Caption = 'Appraisal List';
    //SourceTableView = where(Status = const(Open));

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

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Appraisee ID", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}





