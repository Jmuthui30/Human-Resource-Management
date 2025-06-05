page 52293 "Appraisal Workplan Codes"
{
    ApplicationArea = All;
    Caption = 'Appraisal Workplan Codes';
    PageType = List;
    SourceTable = "Appraisal Workplan Code";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    ShowMandatory = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PerformanceMeasures)
            {
                Caption = 'Performance Measures';
                RunObject = page "Appraisal Performance Measures";
                RunPageLink = "Workplan Code" = field(Code);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UnitOfMeasure;
            }

            action(Initiatives)
            {
                Caption = 'Initiatives';
                RunObject = page "Strategic Impl Initiative";
                RunPageLink = ObjectiveCode = field(Code);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Percentage;
            }
        }
    }
}






