page 52308 "Other Deduction Lines"
{
    ApplicationArea = All;
    Caption = 'Other Deductions';
    PageType = List;
    SourceTable = "Other Deduction Line";
    UsageCategory = None;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Deduction Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
