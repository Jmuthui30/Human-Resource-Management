page 52117 "Qualified Interviewee Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Recruitment Needs";
    Caption = 'Qualified Interviewee Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Positions; Rec.Positions)
                {
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field("Employment Done"; Rec."Employment Done")
                {
                    ToolTip = 'Specifies the value of the Employment Done field';
                    Visible = false;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field';
                    Visible = false;
                }
                field("Total Recruitment Costs"; Rec."Total Recruitment Costs")
                {
                    ToolTip = 'Specifies the value of the Total Recruitment Costs field.';
                }

            }
            part(Control6; "Qualified Interviewee Listpart")
            {
                SubPageLink = "Application Status" = filter(Interviewed | Hired), "Job Applied Code" = field("No.");
            }
            part(RecruitmentCosts; "Recruitment Costs")
            {
                Caption = 'Recruitment Costs';
                Editable = false;
                SubPageLink = "Need Code" = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Employ)
            {
                Image = User;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Employ action';
                Enabled = Rec.Status = Rec.Status::Released;
                Caption = 'Hire Applicants';

                trigger OnAction()
                begin
                    if Confirm('Do you want to hire the selected candidates?', false) then
                        HRMgt.EmployJobApplicant(Rec);

                    CurrPage.Close();
                end;
            }
        }
    }

    var
        HRMgt: Codeunit "HR Management";
}





