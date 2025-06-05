page 52166 "Communication ListPart"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Communication Lines";
    Caption = 'Communication ListPart';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field';
                }
                field("Recipient No."; Rec."Recipient No.")
                {
                    ToolTip = 'Specifies the value of the Recipient No. field';
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ToolTip = 'Specifies the value of the Recipient Name field';
                }
                field("Recipient E-Mail"; Rec."Recipient E-Mail")
                {
                    ToolTip = 'Specifies the value of the Recipient E-Mail field';
                }
                field("Recipient Phone No."; Rec."Recipient Phone No.")
                {
                    ToolTip = 'Specifies the value of the Recipient Phone No. field';
                }
                field("E-Mail Sent"; Rec."E-Mail Sent")
                {
                    ToolTip = 'Specifies the value of the E-Mail Sent field';
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the SMS Sent field';
                }
            }
        }
    }

    actions
    {
    }
}





