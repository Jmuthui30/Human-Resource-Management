page 52081 "Vacant Positions"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Company Job";
    SourceTableView = where(Vacancy = filter(> 0));
    Caption = 'Vacant Positions';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Job Designation"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Job Description field';
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ToolTip = 'Specifies the value of the No of Posts field';
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    ToolTip = 'Specifies the value of the Occupied Position field';
                }
                field(Vacancy; Rec.Vacancy)
                {
                    Caption = 'Variance';
                    ToolTip = 'Specifies the value of the Variance field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        HRManagement.GetVacantPositions(Rec);
    end;

    var
        HRManagement: Codeunit "HR Management";
}





