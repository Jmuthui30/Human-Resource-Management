page 52148 "Interview Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Interview Setup";
    Caption = 'Interview Setup';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Oral Interview"; Rec."Oral Interview")
                {
                    ToolTip = 'Specifies the value of the Oral Interview field';
                }
                field("Oral Interview (Board)"; Rec."Oral Interview (Board)")
                {
                    ToolTip = 'Specifies the value of the Oral Interview (Board) field';
                }
                field("Classroom Interview"; Rec."Classroom Interview")
                {
                    ToolTip = 'Specifies the value of the Classroom Interview field';
                }
                field(Practical; Rec.Practical)
                {
                    ToolTip = 'Specifies the value of the Practical field';
                }
                field("Maximum Marks"; Rec."Maximum Marks")
                {
                    ToolTip = 'Specifies the value of the Maximum Marks field.';
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ToolTip = 'Specifies the value of the Pass Mark field.';
                }
            }
        }
    }

    actions
    {
    }
}





