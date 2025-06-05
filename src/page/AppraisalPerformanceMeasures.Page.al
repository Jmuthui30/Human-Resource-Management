page 52294 "Appraisal Performance Measures"
{
    ApplicationArea = All;
    Caption = 'Appraisal Performance Measures';
    PageType = ListPart;
    SourceTable = "Appraisal Perfomance Measures";

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






