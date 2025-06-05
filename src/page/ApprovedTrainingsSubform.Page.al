page 52175 "Approved Trainings Subform"
{
    ApplicationArea = All;
    CardPageID = "Training Request Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Training Request";
    SourceTableView = where(Status = const(Released));
    Caption = 'Approved Trainings Subform';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                    ToolTip = 'Specifies the value of the Request No. field';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                }
            }
        }
    }

    actions
    {
    }
}





