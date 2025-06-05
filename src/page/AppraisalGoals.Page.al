page 52180 "Appraisal Goals"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    Caption = 'Appraisal Goals';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ToolTip = 'Specifies the value of the Workplan Code field.';
                }
                field("Performance Measure"; Rec."Performance Measure")
                {
                    ToolTip = 'Specifies the value of the Performance Measure field.';
                }
                field("Actual targets"; Rec."Actual targets")
                {
                    ToolTip = 'Specifies the value of the Actual/achieved targets field';
                }
                field("Initiative code"; Rec."Initiative code")
                {
                    ToolTip = 'Specifies the value of the Initiative code field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Initiatives';
                    ToolTip = 'Specifies the value of the Initiatives field';
                }
                field("Achieved (%)"; Rec."Achieved (%)")
                {
                    ToolTip = 'Specifies the value of the Achieved (%) field.';
                    //Editable = UnderReview;
                }
                field(Rating; Rec.Rating)
                {
                    Caption = 'Actual % score';
                    Visible = true;
                    ToolTip = 'Specifies the value of the Actual % score field';
                    //Editable = UnderReview;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Weighting; Rec.Weighting)
                {
                    Visible = true;
                    //Caption = 'Expected % score (Which is 100% for each) (B)';
                    Caption = 'Weighting';
                    ToolTip = 'Specifies the value of the Expected % score (Which is 100% for each) (B) field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Weighted Rating"; Rec."Weighted Rating")
                {
                    ToolTip = 'Specifies the value of the Weighted Rating field.';
                    Editable = UnderReview;
                }
                field("Mid-Year Appraisal"; Rec."Mid-Year Appraisal")
                {
                    Caption = 'Rating by appraiser';
                    //Editable = LineEditable AND UnderReview AND MidYearVisible;
                    Visible = MidYearVisible;
                    ToolTip = 'Specifies the value of the Rating by appraiser field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Variance; Rec.Variance)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variance field';
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Visible = FinalYearVisible;
                    Caption = 'Appraiser''s comments';
                    ToolTip = 'Specifies the value of the Appraiser''s comments field';
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Visible = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                /* 
                field("Objective Code"; Rec."Objective Code")
                {
                    Caption = 'Strategic objecive code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Strategic objecive code field';
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Strategic Objectives';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Strategic Objectives field';
                }
                field("Activity code"; Rec."Activity code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity code field';
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Activities';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activities field';
                }
                field(Task; Rec.Task)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task field';
                }
                field(KPI; Rec.KPI)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KPI field';
                }
                field("Agreed perfomance targets"; Rec."Agreed perfomance targets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreed perfomance targets field';
                } */
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     SetControlAppearance;
    // NameIndent := Indentation;
    // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    // end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        SetControlAppearance();
        // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
        Rec."Employee No" := EmployeeAppraisal."Employee No";
        // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    end;

    trigger OnOpenPage()
    begin
        GetHeader();
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        EmployeeAppraisal: Record "Employee Appraisal";
        Approved: Boolean;
        Completed: Boolean;
        FinalYearVisible: Boolean;
        MidYearVisible: Boolean;
        Setting: Boolean;
        UnderReview: Boolean;

    local procedure GetHeader()
    begin
        //EmployeeAppraisal.SetRange(EmployeeAppraisal."Appraisal No", "Appraisal No");
        if EmployeeAppraisal.Get(Rec."Appraisal No") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader();

        if (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) or (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::"Further review") or
            (EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Final Year") then
            UnderReview := true
        else
            UnderReview := false;

        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Setting then
            Setting := true
        else
            Setting := false;

        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;

        if (EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Mid-Year") and (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) then
            MidYearVisible := true
        else
            MidYearVisible := false;

        if EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Final Year" then
            FinalYearVisible := true
        else
            FinalYearVisible := false;


        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}





