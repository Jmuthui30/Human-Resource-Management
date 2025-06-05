page 52214 "Training Evaluation Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Evaluation Lines";
    UsageCategory = Lists;
    Editable = true;
    Caption = 'Training Evaluation Lines';
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





