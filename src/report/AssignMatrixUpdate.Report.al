report 52056 "Assign Matrix Update"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/AssignMatrixUpdate.rdlc';
    Caption = 'Assign Matrix Update';
    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix")
        {
            trigger OnAfterGetRecord()
            begin

                if Emp.Get("Assignment Matrix-X"."Employee No") then
                    "Assignment Matrix-X".Area := Emp.Area;
                "Assignment Matrix-X".Modify();
            end;
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

    var
        Emp: Record Employee;
}





