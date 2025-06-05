report 52071 "Suggest Loan Interest"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/SuggestLoanInterest.rdlc';
    Caption = 'Suggest Loan Interest';
    dataset
    {
        dataitem(LoanApplication; "Payroll Loan Application")
        {
            CalcFields = "Total Repayment";
            DataItemTableView = where("Loan Status" = filter(Issued));
            RequestFilterFields = "Loan No", "Date filter";
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }
}





