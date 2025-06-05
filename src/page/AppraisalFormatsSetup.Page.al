page 52071 "Appraisal Formats Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Appraisal Formats";
    Caption = 'Appraisal Formats Setup';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field(Indicator; Rec.Indicator)
                {
                    ToolTip = 'Specifies the value of the Indicator field';
                }
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





