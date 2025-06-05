page 52070 "Appraisal Periods"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Appraisal Periods";
    Caption = 'Appraisal Periods';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Submission Due Date"; Rec."Submission Due Date")
                {
                    ToolTip = 'Specifies the value of the Submission Due Date field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type field';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field';
                }
            }
        }
    }

    actions
    {
    }
}





