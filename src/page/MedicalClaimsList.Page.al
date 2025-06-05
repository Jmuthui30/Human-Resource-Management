page 52104 "Medical Claims List"
{
    ApplicationArea = All;
    CardPageID = "Medical Claims Header";
    PageType = List;
    SourceTable = "Medical Claims";
    Caption = 'Medical Claims List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim No"; Rec."Claim No")
                {
                    ToolTip = 'Specifies the value of the Claim No field';
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ToolTip = 'Specifies the value of the Claim Date field';
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ToolTip = 'Specifies the value of the Service Provider field';
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    ToolTip = 'Specifies the value of the Service Provider Name field';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field';
                }
                field(Claimant; Rec.Claimant)
                {
                    ToolTip = 'Specifies the value of the Claimant field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field(Settled; Rec.Settled)
                {
                    ToolTip = 'Specifies the value of the Settled field';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
            }
        }
    }

    actions
    {
    }
}





