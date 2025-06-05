page 52212 "Training Areas"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Area";
    UsageCategory = Lists;
    Editable = true;
    Caption = 'Training Areas';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}





