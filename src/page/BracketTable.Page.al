page 52232 "Bracket Table"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Bracket Tables";
    Caption = 'Bracket Table';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bracket Code"; Rec."Bracket Code")
                {
                    ToolTip = 'Specifies the value of the Bracket Code field';
                }
                field("Bracket Description"; Rec."Bracket Description")
                {
                    ToolTip = 'Specifies the value of the Bracket Description field';
                }
                field("Effective Starting Date"; Rec."Effective Starting Date")
                {
                    ToolTip = 'Specifies the value of the Effective Starting Date field';
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                    ToolTip = 'Specifies the value of the Effective End Date field';
                }
                field(Annual; Rec.Annual)
                {
                    ToolTip = 'Specifies the value of the Annual field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Brackets)
            {
                Caption = 'Brackets';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Tax Table";
                RunPageLink = "Table Code" = field("Bracket Code");
                ToolTip = 'Executes the Brackets action';
            }
        }
    }
}





