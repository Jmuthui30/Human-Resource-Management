page 52198 "Applicant Job Education"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Applicant Job Education';
    PageType = ListPart;
    SourceTable = "Applicant Job Education";
    SourceTableView = where("Education Level" = filter(<> Professional));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Education Type"; Rec."Education Type")
                {
                    ToolTip = 'Specifies the value of the Education Type field';
                }

                field("Education Level"; Rec."Education Level")
                {
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Institution Type"; Rec."Institution Type")
                {
                    ToolTip = 'Specifies the value of the Institution Type field.';
                }
                field(Institution; Rec.Institution)
                {
                    ToolTip = 'Specifies the value of the Institution field';
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Institution Name field';
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ToolTip = 'Specifies the value of the Proficiency Level field';
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field';
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field';
                }
                field("Highest Level"; Rec."Highest Level")
                {
                    ToolTip = 'Specifies the value of the Highest Level field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No. field';
                }
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field("Need Code"; Rec."Need Code")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Need Code field';
                }
            }
        }
    }
}





