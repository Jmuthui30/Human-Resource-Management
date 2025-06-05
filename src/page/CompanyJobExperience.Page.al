page 52197 "Company Job Experience"
{
    ApplicationArea = All;
    Caption = 'Company Job Experience';
    PageType = ListPart;
    SourceTable = "Company Job Experience";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Industry; Rec.Industry)
                {
                    ToolTip = 'Specifies the value of the Industry field';
                }
                field("Industry Name"; Rec."Industry Name")
                {
                    ToolTip = 'Specifies the value of the Industry Name field';
                }
                field("Hierarchy Level"; Rec."Hierarchy Level")
                {
                    ToolTip = 'Specifies the value of the Hierarchy Level field';
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    ToolTip = 'Specifies the value of the No. of Years field';
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





