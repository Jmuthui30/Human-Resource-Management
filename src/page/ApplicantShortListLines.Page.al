page 52090 "Applicant ShortList Lines"
{
    ApplicationArea = All;
    Caption = 'Applicant Shortlist Lines';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Applicant Shortlist";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                    Editable = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    Editable = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ToolTip = 'Specifies the value of the Cellular Phone Number field.';
                    Editable = false;
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    Editable = false;
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                    Editable = false;
                }
                field("Interview Date"; Rec."Interview Date")
                {
                    ToolTip = 'Specifies the value of the Interview Date field.';
                    Editable = Rec.Qualified;
                }
                field("Interview Time"; Rec."Interview Time")
                {
                    ToolTip = 'Specifies the value of the Interview Time field.';
                    Editable = Rec.Qualified;
                }
                field(Qualified; Rec.Qualified)
                {
                    ToolTip = 'Specifies the value of the Qualified field.';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View Applicant Information")
            {
                //Promoted = true;
                Image = View;
                // PromotedCategory = Process;
                //PromotedIsBig = true;
                //PromotedOnly = true;
                RunObject = page "Submitted Applicant Card";
                RunPageLink = "No." = field("Applicant No.");
                RunPageMode = View;
                Caption = 'View Applicant Information';
            }
        }
    }
}






