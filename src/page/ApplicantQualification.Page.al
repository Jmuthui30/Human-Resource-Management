page 52088 "Applicant Qualification"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Applicants Qualification";
    Caption = 'Applicant Qualification';
    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ToolTip = 'Specifies the value of the Qualification Type field';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field(Qualification; Rec.Qualification)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qualification field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Institution_Company; Rec.Institution_Company)
                {
                    ToolTip = 'Specifies the value of the Institution/Company field';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field';
                }
                field(Score; Rec.Score)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Score field';
                }
                field(Qualified; Rec.Qualified)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Qualified field';
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Need Code"; Rec."Need Code")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Need Code field';
                }
            }
        }
    }

    actions
    {
    }
}





