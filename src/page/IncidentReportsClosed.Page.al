page 52305 "Incident Reports - Closed"
{
    ApplicationArea = All;
    Caption = 'Incidences';
    CardPageID = "Incident Report";
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(Closed), Type = filter(<> Risk));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnOpenPage()
    begin
        if not UserSetup.Get(UserId) THEN
            ERROR(UserNotFoundErr, USERID);

    end;

    var
        UserSetup: Record "User Setup";
        UserNotFoundErr: Label 'The User Name %1 does not exist in the User Setup.';

}







