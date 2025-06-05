page 52102 "Medical Scheme Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Medical Scheme Header";
    Caption = 'Medical Scheme Header';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                    Visible = false;
                }
                field("Cover Type"; Rec."Cover Type")
                {
                    ToolTip = 'Specifies the value of the Cover Type field';
                }
                field("Cover Selected"; Rec."Cover Selected")
                {
                    ToolTip = 'Specifies the value of the Cover Selected field';
                }
                field("Entitlement -Inpatient"; Rec."Entitlement -Inpatient")
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Entitlement -Inpatient field';
                }
                field("Out-Patient Claims"; Rec."Out-Patient Claims")
                {
                    Visible = false;
                    Caption = 'Medical Expenditure';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Medical Expenditure field';
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                    ToolTip = 'Specifies the value of the Policy Start Date field';
                }
                field("Policy Expiry Date"; Rec."Policy Expiry Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Policy Expiry Date field';
                }
                field("Entitlement -OutPatient"; Rec."Entitlement -OutPatient")
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Entitlement -OutPatient field';
                }
                field("""Entitlement -OutPatient""-""Out-Patient Claims"""; Rec."Entitlement -OutPatient" - Rec."Out-Patient Claims")
                {
                    Visible = false;
                    Caption = 'Balance';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Balance field';
                }
            }
            part(Control13; "Medical Dependants")
            {
                SubPageLink = "Employee Code" = field("Employee No"),
                              "Medical Scheme No" = field("No.");
            }
        }
    }

    actions
    {
    }
}





