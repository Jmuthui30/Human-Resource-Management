pageextension 52005 "EmployeeQualificationsExt" extends "Employee Qualifications"
{
    layout
    {
        modify("Institution/Company")
        {
            Editable = false;
        }

        addafter(Description)
        {

            field("Institution Type"; Rec."Institution Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Institution Type field.';
            }
            field("Institution Code"; Rec."Institution Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Institution Code field.';
            }
        }

    }
}






