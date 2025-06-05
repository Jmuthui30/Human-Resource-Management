page 52007 "Hazard Register List"
{
    ApplicationArea = All;
    Caption = 'Hazard Register';
    CardPageID = "Hazard Register Card";
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(Open), Type = const(Risk));
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
                field(Status; Rec.Status)
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
        Rec.Type := Rec.Type::Risk;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Risk;
    end;

    trigger OnOpenPage()
    begin
        /* if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange(User, UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId); */
    end;

}





