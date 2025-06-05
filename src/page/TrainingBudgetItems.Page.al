page 52286 "Training Budget Items"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Budget";
    Caption = 'Training Budget Items';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Budget Item No"; Rec."Budget Item No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Budget Item No field';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ToolTip = 'Specifies the value of the Approved Budget field';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Estimated Cost field';
                }
                field(Actual; Rec.Actual)
                {
                    ToolTip = 'Specifies the value of the Actuals field';
                }
                field(Commitment; Rec.Commitment)
                {
                    ToolTip = 'Specifies the value of the Commitments field';
                }
                field("1stQuarter"; "1stQuarter")
                {
                    Caption = '1st Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 1st Quarter field';
                }
                field("2ndQuarter"; "2ndQuarter")
                {
                    Caption = '2nd Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 2nd Quarter field';
                }
                field("3rdQuarter"; "3rdQuarter")
                {
                    Caption = '3rd Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 3rd Quarter field';
                }
                field("4thQuarter"; "4thQuarter")
                {
                    Caption = '4th Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 4th Quarter field';
                }
                field("Budget Year"; Rec."Training Year")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Training Year field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //GetQuarters;
    end;

    trigger OnOpenPage()
    begin
        //GetQuarters;
    end;

    var
        AccPeriod: Record "Accounting Period";
        TrainingBudget: Record "Training Budget";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;

    procedure GetQuarters1()
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then
            NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "1stQuarter" := Rec."Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "2ndQuarter" := Rec."Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "3rdQuarter" := Rec."Estimated Cost";
        end;
        //Get 4th Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "4thQuarter" := Rec."Estimated Cost";
        end;
    end;
}





