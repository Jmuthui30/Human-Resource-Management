page 52188 "Appraisal Goals-Completed"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    Caption = 'Appraisal Goals-Completed';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field("Objective Code"; Rec."Objective Code")
                {
                    Caption = 'Strategic objecive code';
                    ToolTip = 'Specifies the value of the Strategic objecive code field';
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Strategic Objectives';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ToolTip = 'Specifies the value of the Strategic Objectives field';
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
                field("Activity code"; Rec."Activity code")
                {
                    ToolTip = 'Specifies the value of the Activity code field';
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Activities';
                    ToolTip = 'Specifies the value of the Activities field';
                }
                field("FY Target"; Rec."FY Target")
                {
                    ToolTip = 'Specifies the value of the Approved performance targets field';
                }
                field(Weighting; Rec.Weighting)
                {
                    ToolTip = 'Specifies the value of the Weighting field';
                }
                field("Final Self-Appraisal"; Rec."Final Self-Appraisal")
                {
                    Caption = 'Perfomance Rating Employee';
                    ToolTip = 'Specifies the value of the Perfomance Rating Employee field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Score/Points"; Rec."Score/Points")
                {
                    Caption = 'Perfomance Rating Supervisor';
                    ToolTip = 'Specifies the value of the Perfomance Rating Supervisor field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Caption = 'Remarks';
                    ToolTip = 'Specifies the value of the Remarks field';
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
        Completed: Boolean;
        LineEditable: Boolean;
        NameEmphasize: Boolean;
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

        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review then
            UnderReview := true
        else
            UnderReview := false;

        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;

        //if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Mid-Year" then
        //MidYearVisible := true
        //else
        //MidYearVisible := false;

        //if EmployeeAppraisal.Type = EmployeeAppraisal.Type::"Final Year" then
        //FinalYearVisible := true
        //else
        //FinalYearVisible := false;
    end;
}





