page 52172 "Training Needs Application"
{
    ApplicationArea = All;
    CardPageID = "Processed Training Needs";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Training Need";
    Caption = 'Training Needs Application';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field';
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Venue field';
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ToolTip = 'Specifies the value of the Provider Name field';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ToolTip = 'Specifies the value of the Cost Of Training field';
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    ToolTip = 'Specifies the value of the Cost Of Training (LCY) field';
                }
                field("No. of Participants"; Rec."No. of Participants")
                {
                    ToolTip = 'Specifies the value of the No. of Participants field';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ToolTip = 'Specifies the value of the Total Cost field';
                }
                field("Total PerDiem"; Rec."Total PerDiem")
                {
                    ToolTip = 'Specifies the value of the Total PerDiem field';
                }
            }
        }
    }
}





