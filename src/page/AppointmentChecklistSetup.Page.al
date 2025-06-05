page 52052 "Appointment Checklist Setup"
{
    ApplicationArea = All;
    Caption = 'Induction Checklist Setup';
    PageType = List;
    SourceTable = "Appointment Checklist Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}






