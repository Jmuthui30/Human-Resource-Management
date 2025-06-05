page 52079 "Travelling Non Employees"
{
    ApplicationArea = All;
    PageType = Listpart;
    SourceTable = "Travelling Non Employees";
    Caption = 'Travelling Non Employees';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Passport No"; Rec."Passport No")
                {
                    Caption = 'ID/ Passport No.';
                    ToolTip = 'Specifies the value of the ID/ Passport No. field';
                }
            }
        }
    }

    actions
    {
    }
}





