page 52280 "Appraisal Goals Self"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Appraisal goals from job description';
    PageType = ListPart;
    SourceTable = "Appraisal Lines-JD";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Key Responsibility";

                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Goal';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ToolTip = 'Specifies the value of the Goal field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Initiatives';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Initiatives field';
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Activities';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Activities field';
                }
                field("Appraisal Line Type"; Rec."Appraisal Line Type")
                {
                    ToolTip = 'Specifies the value of the Objective Type field';

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Agreed Target Date"; Rec."Agreed Target Date")
                {
                    Caption = 'Individual Performance Targets';
                    Editable = LineEditable and not UnderReview;
                    ToolTip = 'Specifies the value of the Individual Performance Targets field';
                }
                field(KPI; Rec.KPI)
                {
                    Caption = 'Key Perfomance Indicators';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Key Perfomance Indicators field';
                }
                field(Weighting; Rec.Weighting)
                {
                    Editable = LineEditable and Setting;
                    ToolTip = 'Specifies the value of the Weighting field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Mid-Year Appraisal"; Rec."Mid-Year Appraisal")
                {
                    Editable = LineEditable and UnderReview and MidYearVisible;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Mid-Year Appraisal field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Final Self-Appraisal"; Rec."Final Self-Appraisal")
                {
                    Caption = 'Self-Appraisal Score';
                    Editable = LineEditable;
                    Visible = UnderReview;
                    ToolTip = 'Specifies the value of the Self-Appraisal Score field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Score/Points"; Rec."Score/Points")
                {
                    Caption = 'Appraiser''s Score';
                    Editable = LineEditable;
                    Visible = UnderReview;
                    ToolTip = 'Specifies the value of the Appraiser''s Score field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Caption = 'Justification';
                    Editable = LineEditable;
                    Visible = Approved;
                    ToolTip = 'Specifies the value of the Justification field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Indent)
            {
                Caption = 'Manually Indent Appraisal Goals';
                Image = Indent;
                ToolTip = 'Executes the Manually Indent Appraisal Goals action';

                trigger OnAction()
                begin
                    HRMgt.IndentAppraisalGoals(Rec."Appraisal No");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Appraisal Line Type" <> Rec."Appraisal Line Type"::Objective;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        NameEmphasize := Rec."Appraisal Line Type" <> Rec."Appraisal Line Type"::Objective;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
        Rec."Employee No" := EmployeeAppraisal."Employee No";
        NameEmphasize := Rec."Appraisal Line Type" <> Rec."Appraisal Line Type"::Objective;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    var
        EmployeeAppraisal: Record "Employee Appraisal";
        HRMgt: Codeunit "HR Management";
        Approved: Boolean;
        Completed: Boolean;
        LineEditable: Boolean;
        MidYearVisible: Boolean;
        NameEmphasize: Boolean;
        Setting: Boolean;
        UnderReview: Boolean;
        NameIndent: Integer;

    local procedure GetHeader()
    begin
        EmployeeAppraisal.SetRange(EmployeeAppraisal."Appraisal No", Rec."Appraisal No");
        if EmployeeAppraisal.FindFirst() then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader();
        if Rec."Appraisal Line Type" = Rec."Appraisal Line Type"::Objective then
            LineEditable := true
        else
            LineEditable := false;

        if (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) then
            //or (EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Final Year") then
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

        /*if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Mid-Year" then
            MidYearVisible := true
        else
            MidYearVisible := false;

        if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Final Year" then
            FinalYearVisible := true
        else
            FinalYearVisible := false;
            */

        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}





