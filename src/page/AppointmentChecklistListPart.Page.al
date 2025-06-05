page 52049 "Appointment Checklist ListPart"
{
    ApplicationArea = All;
    Caption = 'Induction Checklist';
    PageType = ListPart;
    SourceTable = "Appointment Checklist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ToolTip = 'Specifies the value of the Item field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field(Signed; Rec.Signed)
                {
                    ToolTip = 'Specifies the value of the Signed field';
                }
            }
        }
    }

    actions
    {
    }
}





