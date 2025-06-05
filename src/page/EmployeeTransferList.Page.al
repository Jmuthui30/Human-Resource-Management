page 52066 "Employee Transfer List"
{
    ApplicationArea = All;
    CardPageID = "Employee Transfer Card";
    PageType = List;
    SourceTable = "Employee Transfers";
    Caption = 'Employee Transfer List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer Date"; Rec."Transfer Date")
                {
                    Caption = 'Transfer';
                    ToolTip = 'Specifies the value of the Transfer field';
                }
                field("Transfer No"; Rec."Transfer No")
                {
                    ToolTip = 'Specifies the value of the Transfer No field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Job Group"; Rec."Job Group")
                {
                    ToolTip = 'Specifies the value of the Job Group field';
                }
                field("Length of Stay"; Rec."Length of Stay")
                {
                    ToolTip = 'Specifies the value of the Length of Stay field';
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    ToolTip = 'Specifies the value of the HOD Employee No field';
                }
            }
        }
    }

    actions
    {
    }
}





