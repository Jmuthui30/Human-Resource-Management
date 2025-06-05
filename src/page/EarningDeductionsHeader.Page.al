page 52252 "Earning & Deductions Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Import Earn & Ded Header";
    Caption = 'Earning & Deductions Header';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                field(No; Rec.No)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Pay Period"; Rec."Pay Period")
                {
                    ToolTip = 'Specifies the value of the Pay Period field';
                }
                field("Pay Period Text"; Rec."Pay Period Text")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pay Period Text field';
                }
                field(Total; Rec.Total)
                {
                    Caption = 'Batch Total';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Batch Total field';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part(Control4; "Earning & Deduction Lines")
            {
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Earnings & Deductions")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Import Earnings & Deductions action';

                trigger OnAction()
                begin
                    Rec.TestField(Code);
                    Rec.TestField("Pay Period");

                    Clear("Earn&Ded");
                    "Earn&Ded".GetNoSeries(Rec);
                    //"Earn&Ded".NegateDed(Rec);
                    "Earn&Ded".Run();
                end;
            }
            action(Post)
            {
                Caption = 'P&ost';
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the P&ost action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to update the %1 - %2 for Period %3?', true, Rec.Code, Rec.Description, Rec."Pay Period") = false then
                        exit;

                    Rec.TestField(Code);
                    Rec.TestField("Pay Period");

                    PayPeriod.Reset();
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.FindFirst() then
                        if Rec."Pay Period" <> PayPeriod."Starting Date" then
                            if Rec."Pay Period" > PayPeriod."Starting Date" then
                                Error('Kindly close the previous periods before Posting');

                    if PayPeriod.Get(Rec."Pay Period") then
                        if PayPeriod.Closed = true then
                            Error('The specified period %1 is closed', Rec."Pay Period");

                    PayrollMgt.InsertAssignMatrix(Rec);
                    Rec.Status := Rec.Status::Released;
                    Message('The %1 %2-%3 have been updated Successfully for the Period %4', Rec.Type, Rec.Code, Rec.Description, Rec."Pay Period Text");
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        PayPeriod: Record "Payroll Period";
        PayrollMgt: Codeunit Payroll;
        "Earn&Ded": XMLport "Import Earnings & Deductions";
}





