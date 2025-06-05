page 52273 "Loan Reschedule"
{
    ApplicationArea = All;
    PageType = StandardDialog;
    SourceTable = "Payroll Loan Application";
    Caption = 'Loan Reschedule';
    layout
    {
        area(content)
        {
            group("Loan Details")
            {
                Caption = 'Original Loan Details';
                Editable = false;

                field("Loan No"; Rec."Loan No")
                {
                    Caption = 'Loan No.';
                    ToolTip = 'Specifies the value of the Loan No. field';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Caption = 'Original Loan Amount';
                    ToolTip = 'Specifies the value of the Original Loan Amount field';
                }
                field(Instalment; Rec.Instalment)
                {
                    Caption = 'Original No. of Installments';
                    ToolTip = 'Specifies the value of the Original No. of Installments field';
                }
                field(Repayment; Rec.Repayment)
                {
                    Caption = 'Original Repayment Amount';
                    ToolTip = 'Specifies the value of the Original Repayment Amount field';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ToolTip = 'Specifies the value of the Repayment Frequency field';
                }
            }
            group("New Loan Details")
            {
                field(NewRescheduleDate; NewRescheduleDate)
                {
                    Caption = 'Loan Reschedule Date';
                    ToolTip = 'Specifies the value of the Loan Reschedule Date field';
                }
                field("Loan Balance"; LoanBal)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the LoanBal field';
                }
                field(NewInstallments; NewInstallments)
                {
                    Caption = 'New Installments';
                    ToolTip = 'Specifies the value of the New Installments field';

                    trigger OnValidate()
                    begin
                        Freq := GetFrequency();
                        GetLoanBal();
                        NewRepaymentAmt := CalculateLoanRepayment(NewInstallments, LoanBal);
                    end;
                }
                field(NewRepaymentAmt; NewRepaymentAmt)
                {
                    Caption = 'New Repayment Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the New Repayment Amount field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Total Repayment");
        GetLoanBal();
    end;

    trigger OnAfterGetRecord()
    begin
        NewRescheduleDate := Today;
        GetLoanBal();
    end;

    trigger OnInit()
    begin
        LoanBal := 0;
    end;

    trigger OnOpenPage()
    begin
        NewRescheduleDate := Today;
        GetLoanBal();
    end;

    var
        NewRescheduleDate: Date;
        Freq: Decimal;
        LoanBal: Decimal;
        NewRepaymentAmt: Decimal;
        NewInstallments: Integer;

    procedure CalculateLoanRepayment(NewInst: Integer; NewBal: Decimal) NewRepayment: Decimal
    var
        LoanTypeRec: Record "Loan Product Type-Payroll";
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Text;
    begin
        GetLoanBal();

        NewBal := 0;
        NewInst := 0;

        if LoanTypeRec.Get(Rec."Loan Product Type") then;
        LoanTypeRec.TestField("Rounding Precision");

        case LoanTypeRec.Rounding of
            LoanTypeRec.Rounding::Nearest:
                RoundDirectionCode := '=';
            LoanTypeRec.Rounding::Down:
                RoundDirectionCode := '<';
            LoanTypeRec.Rounding::Up:
                RoundDirectionCode := '>';
        end;

        RoundPrecisionDec := LoanTypeRec."Rounding Precision";

        case Rec."Interest Calculation Method" of
            Rec."Interest Calculation Method"::Amortised,
          Rec."Interest Calculation Method"::"Reducing Balance":
                NewRepayment := Round((Rec."Interest Rate" / 12 / 100) / (1 - Power((1 + (Rec."Interest Rate" / 12 / 100)),
                              -NewInst)) * NewBal, LoanTypeRec."Rounding Precision",
                                  RoundDirectionCode);

            Rec."Interest Calculation Method"::"Flat Rate":
                NewRepayment := Round((NewBal / NewInst) + Rec.FlatRateCalc(NewBal, Rec.Interest), LoanTypeRec."Rounding Precision",
                                  RoundDirectionCode);

            Rec."Interest Calculation Method"::"Sacco Reducing Balance":
                NewRepayment := Round(NewBal / NewInst, LoanTypeRec."Rounding Precision",
                                  RoundDirectionCode);
        end;
        exit(Rec.Repayment);
    end;

    procedure GetRescheduleDetails(var NewInst: Integer; var NewRepAmt: Decimal; var RescheduleDate: Date; var Bal: Decimal)
    begin
        NewInst := NewInstallments;
        NewRepAmt := NewRepaymentAmt;
        RescheduleDate := NewRescheduleDate;
        Rec.CalcFields("Total Repayment");
        Bal := Rec."Approved Amount" + Rec."Total Repayment";
    end;

    local procedure GetFrequency() Frequency: Decimal
    begin
        case Rec."Repayment Frequency" of
            Rec."Repayment Frequency"::Monthly:
                Frequency := 1 / 12;
            Rec."Repayment Frequency"::Quaterly:
                Frequency := 3 / 12;
            Rec."Repayment Frequency"::"Semi-Annually":
                Frequency := 6 / 12;
            Rec."Repayment Frequency"::Annually:
                Frequency := 1;
        end;
    end;

    local procedure GetLoanBal()
    begin
        Rec.CalcFields("Total Repayment");
        LoanBal := Rec."Approved Amount" + Rec."Total Repayment";
    end;
}





