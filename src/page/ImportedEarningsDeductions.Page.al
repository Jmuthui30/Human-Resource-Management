page 52255 "Imported Earnings & Deductions"
{
    ApplicationArea = All;
    CardPageID = "Earning & Deductions Header";
    PageType = List;
    SourceTable = "Import Earn & Ded Header";
    SourceTableView = where(Status = filter(Released));
    Caption = 'Imported Earnings & Deductions';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
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
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Pay Period Text"; Rec."Pay Period Text")
                {
                    ToolTip = 'Specifies the value of the Pay Period Text field';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Total; Rec.Total)
                {
                    ToolTip = 'Specifies the value of the Total field';
                }
            }
        }
    }

    actions
    {
    }
}





