page 52182 "Appraisal work related attr"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal - attributes";
    Caption = 'Appraisal work related attr';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AttributeCode; Rec.AttributeCode)
                {
                    ToolTip = 'Specifies the value of the AttributeCode field';
                }
                field(Attribute; Rec.Attribute)
                {
                    ToolTip = 'Specifies the value of the Attribute field';
                }
                field("Indicator code"; Rec."Indicator code")
                {
                    ToolTip = 'Specifies the value of the Indicator code field';
                }
                field(Indicator; Rec.Indicator)
                {
                    ToolTip = 'Specifies the value of the Indicator field';
                }
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Expected rating attributes"; Rec."Expected rating attributes")
                {
                    ToolTip = 'Specifies the value of the Expected rating field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
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
        Setting: Boolean;
        UnderReview: Boolean;

    local procedure GetHeader()
    begin
        if EmployeeAppraisal.Get(Rec."Appraisal No.") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader();

        if (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) or (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::"Further review") then
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

        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}





