page 52031 "Emp Disciplinary Cases"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Employee Disciplinary Cases";
    Caption = 'Emp Disciplinary Cases';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reference No"; Rec."Refference No")
                {
                    ToolTip = 'Specifies the value of the Refference No field';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Disciplinary Case"; Rec."Disciplinary Case")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Type of Hearing field';
                }
                field("Case Description"; Rec."Case Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Case Description field';
                }
                field(Hearing; Rec.Hearing)
                {
                    Caption = 'Define the case';
                    ToolTip = 'Specifies the value of the Define the case field';
                }
                field(Capability; Rec.Capability)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Capability field';
                }
                field("Accused Defence"; Rec."Accused Defence")
                {
                    Caption = 'Accused Defence';
                    ToolTip = 'Specifies the value of the Accused witness field';
                }
                field("Witness Type"; Rec."Witness Type")
                {
                    ToolTip = 'Specifies the value of the Witness Type field';

                    trigger OnValidate()
                    begin
                        ShowStaffWitness();
                    end;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    Caption = 'Witness Employee';
                    ToolTip = 'Specifies the value of the Witness Employee field';
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ToolTip = 'Specifies the value of the Witness Name field';
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    Caption = 'Other Witness';
                    ToolTip = 'Specifies the value of the Other Witness field';
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ToolTip = 'Specifies the value of the Recommended Action field';
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ToolTip = 'Specifies the value of the Action Taken field';
                }
                field("Action Description"; Rec."Action Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Action Description field';
                }
                field("Date Taken"; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date Taken field';
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Remarks field';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field';
                }
                field(Attachment; Rec.Attachment)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Attachment field';
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Cases Discusion"; Rec."Cases Discusion")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cases Discusion field';
                }
                field("RecAction Description"; Rec."RecAction Description")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the RecAction Description field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ShowStaffWitness();
    end;

    trigger OnOpenPage()
    begin
        ShowStaffWitness();
    end;

    var
        Staff: Boolean;

    local procedure ShowStaffWitness()
    begin
        if Rec."Witness Type" = Rec."Witness Type"::Staff then
            Staff := false
        else
            Staff := true;
    end;
}





