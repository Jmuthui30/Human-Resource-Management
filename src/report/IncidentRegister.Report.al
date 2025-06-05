report 52113 "Incident Register"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/IncidentRegister.rdl';
    Caption = 'Incident Register';
    dataset
    {
        dataitem("User Support Incident"; "User Support Incident")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompaAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(IncidentDescription; "User Support Incident"."Incident Description")
            {
            }
            column(IncidentDate; "User Support Incident"."Incident Date")
            {
            }
            column(IncidentReference; "User Support Incident"."Incident Reference")
            {
            }
            column(Actiontaken; "User Support Incident"."Action taken")
            {
            }
            column(IncidentCause; "User Support Incident"."Incident Cause")
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







