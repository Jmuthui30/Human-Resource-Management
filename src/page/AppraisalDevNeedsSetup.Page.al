page 52062 "Appraisal Dev Needs Setup"
{
    ApplicationArea = All;
    Caption = 'Appraisal Development Needs Setup';
    PageType = List;
    SourceTable = "Appraisal Devt Need Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}






