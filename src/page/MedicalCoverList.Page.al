page 52103 "Medical Cover List"
{
    ApplicationArea = All;
    CardPageID = "Medical Scheme Header";
    PageType = List;
    SourceTable = "Medical Scheme Header";
    Caption = 'Medical Cover List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Cover Type"; Rec."Cover Type")
                {
                    ToolTip = 'Specifies the value of the Cover Type field';
                }
                field("Name of Broker"; Rec."Name of Broker")
                {
                    ToolTip = 'Specifies the value of the Name of Broker field';
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                    ToolTip = 'Specifies the value of the Policy Start Date field';
                }
                field("Policy Expiry Date"; Rec."Policy Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Policy Expiry Date field';
                }
                field("No. Of Lives"; Rec."No. Of Lives")
                {
                    ToolTip = 'Specifies the value of the No. Of Lives field';
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    ToolTip = 'Specifies the value of the Fiscal Year field';
                }
            }
        }
    }

    actions
    {
    }
}





