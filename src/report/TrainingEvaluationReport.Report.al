report 52104 "Training Evaluation Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrainingEvaluationReport.rdl';
    Caption = 'Training Evaluation Report';
    dataset
    {
        dataitem("Training Evaluation Header"; "Training Evaluation Header")
        {
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
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
            column(Header_Training_Evaluation_No_; "Training Evaluation No.")
            {
            }
            column(Header_Personal_No_; "Personal No.")
            {
            }
            column(Header_Name_of_the_participant; "Name of participant")
            {
            }
            column(Header_Training_Name; "Training Name")
            {
            }
            column(Header_Location; Location)
            {
            }
            column(Header_Country; Country)
            {
            }
            column(Header_Commencement_Date; "Commencement Date")
            {
            }
            column(Header_Completion_Date; "Completion Date")
            {
            }
            column(Header_Duration; Duration)
            {
            }
            dataitem("Training Evaluation Lines"; "Training Evaluation Lines")
            {
                DataItemLink = "Training Evaluation No." = field("Training Evaluation No.");

                column(Lines_Description; Description)
                {
                }
                column(Lines_Action_Plan; "Action Plan")
                {
                }
                column(Lines_How_To_achieve; "How To achieve")
                {
                }
                column(Lines_Results_to_be_achieved; "Results to be achieved")
                {
                }
                column(Lines_Timeline; Timeline)
                {
                }
                column(Lines_Evaluation_Line_Type; "Evaluation Line Type")
                {
                }
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





