report 52909 "Employee Time Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Timesheet;

    dataset
    {
        dataitem("Employee Work Time"; "Employee Work Time")
        {
            column(No_Header; "No.")
            {

            }
            dataitem("Employee Working  Line"; "Employee Working  Line")
            {
                column(No_Line; "No.")
                { }
            }
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {

                //     }
                // }
            }
        }

        actions
        {
            area(processing)
            {
                // action(LayoutName)
                // {

                // }
            }
        }
    }

    rendering
    {
        layout(Timesheet)
        {
            Type = RDLC;
            LayoutFile = './src/report_layout/EmployeeTimesheet.rdlc';
        }
    }

    var
        myInt: Integer;
}