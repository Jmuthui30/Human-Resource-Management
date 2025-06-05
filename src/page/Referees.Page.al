page 52099 "Referees"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = Listpart;
    SourceTable = "Applicant Referees";
    Caption = 'Referees';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field(Company; Rec.Company)
                {
                    Caption = 'Institution/Company';
                    ToolTip = 'Specifies the value of the Institution/Company field';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Telephone No field';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field';
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
            }
        }
    }

    actions
    {
    }
}





