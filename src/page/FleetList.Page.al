page 52074 "Fleet List"
{
    ApplicationArea = All;
    CardPageID = "Fleet Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Fixed Asset";
    SourceTableView = where("Fixed Asset Type" = filter(Fleet));
    Caption = 'Fleet List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Select Vehicle"; SelectVehicle)
                {
                    ToolTip = 'Specifies the value of the SelectVehicle field';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                    ToolTip = 'Specifies the value of the Under Maintenance field';
                }
            }
        }
        area(factboxes)
        {
            systempart(RecordLinks; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
    }

    var
        SelectVehicle: Boolean;

    procedure GetSelection()
    begin
        CurrPage.SetSelectionFilter(Rec);
    end;
}





