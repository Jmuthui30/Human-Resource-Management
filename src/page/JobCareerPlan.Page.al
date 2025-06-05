page 52012 "Job Career Plan"
{
    ApplicationArea = All;
    Caption = 'Job Career Plan';
    PageType = ListPart;
    SourceTable = "Job Career Plan";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Plan Job ID"; Rec."Plan Job ID")
                {
                    ToolTip = 'Specifies the value of the Plan Job ID field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}






