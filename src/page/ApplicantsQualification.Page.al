page 52113 "Applicants Qualification"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Employee Qualification";
    Caption = 'Applicants Qualification';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ToolTip = 'Specifies the value of the Qualification Type field';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ToolTip = 'Specifies the value of the Institution/Company field';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field';
                }
            }
        }
    }

    actions
    {
    }
}





