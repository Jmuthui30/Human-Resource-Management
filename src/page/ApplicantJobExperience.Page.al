page 52199 "Applicant Job Experience"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Applicant Job Experience';
    PageType = ListPart;
    SourceTable = "Applicant Job Experience";

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
                field(Employer; Rec.Employer)
                {
                    ToolTip = 'Specifies the value of the Employer field';
                }
                field(Industry; Rec.Industry)
                {
                    ToolTip = 'Specifies the value of the Industry field';
                }
                field("Hierarchy Level"; Rec."Hierarchy Level")
                {
                    ToolTip = 'Specifies the value of the Hierarchy Level field';
                }
                field("Functional Area"; Rec."Functional Area")
                {
                    ToolTip = 'Specifies the value of the Functional Area field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Present Employment"; Rec."Present Employment")
                {
                    ToolTip = 'Specifies the value of the Present Employment field';
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    ToolTip = 'Specifies the value of the No. of Years field';
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field';
                }
                field("Employer Email Address"; Rec."Employer Email Address")
                {
                    ToolTip = 'Specifies the value of the Employer Email Address field';
                }
                field("Employer Postal Address"; Rec."Employer Postal Address")
                {
                    ToolTip = 'Specifies the value of the Employer Postal Address field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Line No"; Rec."Line No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No field';
                }
            }
        }
    }
}





