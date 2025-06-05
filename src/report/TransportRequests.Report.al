report 52014 "Transport Requests"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TransportRequests.rdl';
    Caption = 'Transport Requests';
    dataset
    {
        dataitem("Travel Requests"; "Travel Requests")
        {
            RequestFilterFields = "Request No.", "Request Date", Status;

            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Request_No; "Travel Requests"."Request No.")
            {
            }
            column(Request_Date; "Travel Requests"."Request Date")
            {
            }
            column(Employee_No; "Travel Requests"."Employee No.")
            {
            }
            column(Employee_Name; "Travel Requests"."Employee Name")
            {
            }
            column(Destination; "Travel Requests".Destination)
            {
            }
            column(No_of_Personnel_; "Travel Requests"."No. of Personnel")
            {
            }
            column(Status; "Travel Requests".Status)
            {
            }
            column(StartDate; "Travel Requests"."Trip Planned Start Date")
            {
            }
            column(ReturnDate; "Travel Requests"."Trip Planned End Date")
            {
            }
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

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}





