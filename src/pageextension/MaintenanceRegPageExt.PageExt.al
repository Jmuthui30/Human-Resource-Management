pageextension 52003 "MaintenanceRegPageExt" extends "Maintenance Registration"
{
    layout
    {
        addlast(Control1)
        {
            field("Employee No"; Rec."Employee No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee No field';
            }
        }
    }
}
