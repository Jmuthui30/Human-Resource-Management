tableextension 52005 "EmployeeRelativeExt" extends "Employee Relative"
{
    fields
    {
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            begin
                if "Birth Date" > Today then
                    Error('Birth Date can not be greater than today');
                Age := HRDates.DetermineAge("Birth Date", Today);
            end;
        }
        field(52000; Dependant; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Dependant';
        }
        field(52001; Gender; Enum "Employee Gender")
        {
            DataClassification = CustomerContent;
            Caption = 'Gender';
        }
        field(52002; "Dependant No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dependant No';
        }
        field(52003; Age; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Age';
        }
    }

    var
        HRDates: Codeunit "Dates Management";
}





