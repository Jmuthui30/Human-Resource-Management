page 52196 "Company Job Education"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Company Job Education';
    PageType = ListPart;
    SourceTable = "Company Job Education";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field of Education"; Rec."Field of Study")
                {
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
                field("Field Name"; Rec."Field Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Field Name field';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ToolTip = 'Specifies the value of the Proficiency Level field';
                }
                field(Score; Rec.Score)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Score field';
                }
            }
        }
    }
}





