page 52009 "User Competences"
{
    ApplicationArea = All;
    Caption = 'User Competences';
    PageType = List;
    SourceTable = "User Competence";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("User Competence Description"; Rec."User Competence Description")
                {
                    ToolTip = 'Specifies the value of the User Competence Description field.';
                }
            }
        }
    }
}






