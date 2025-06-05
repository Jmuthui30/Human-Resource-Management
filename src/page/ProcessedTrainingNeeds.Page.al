page 52174 "Processed Training Needs"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Training';
    SourceTable = "Training Need";
    Caption = 'Processed Training Needs';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field.';
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Training Objectives field';
                }
                field(Provider; Rec.Provider)
                {
                    Caption = 'Training Provider';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Training Provider field';
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Provider Name field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duration Units field';
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duration field';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cost Of Training field';
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cost Of Training (LCY) field';
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Location field';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field';
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Venue field';
                }
                group(More)
                {
                    Caption = 'More Details';
                    Editable = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field(DimVal1; Rec.DimVal1)
                    {
                        Caption = 'Name';
                        Visible = false;
                        ToolTip = 'Specifies the value of the Name field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
                    field(DimVal2; Rec.DimVal2)
                    {
                        Caption = '&Name';
                        Visible = false;
                        ToolTip = 'Specifies the value of the &Name field';
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field';
                    }
                    field("No. of Participants"; Rec."No. of Participants")
                    {
                        ToolTip = 'Specifies the value of the No. of Participants field';
                    }
                    field("Total Cost"; Rec."Total Cost")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Total Cost field';
                    }
                    field("Total PerDiem"; Rec."Total PerDiem")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Total PerDiem field';
                    }
                }
            }
            group(Remarks)
            {
                Caption = 'Remarks';
                Editable = Rec."Status" = Rec."Status"::"Application";

                field(Control40; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                }
                group(Control23)
                {
                    ShowCaption = false;
                    Visible = false;

                    field(Qualification; Rec.Qualification)
                    {
                        ToolTip = 'Specifies the value of the Qualification field';
                    }
                    field("Re-Assessment Date"; Rec."Re-Assessment Date")
                    {
                        ToolTip = 'Specifies the value of the Re-Assessment Date field';
                    }
                    field(Source; Rec.Source)
                    {
                        ToolTip = 'Specifies the value of the Source field';
                    }
                    field("Need Source"; Rec."Need Source")
                    {
                        ToolTip = 'Specifies the value of the Need Source field';
                    }
                    field(Post; Rec.Post)
                    {
                        ToolTip = 'Specifies the value of the Post field';
                    }
                    field(Posted; Rec.Posted)
                    {
                        ToolTip = 'Specifies the value of the Posted field';
                    }
                    field("Department Code"; Rec."Department Code")
                    {
                        ToolTip = 'Specifies the value of the Department Code field';
                    }
                }
            }
            part(Control41; "Training Needs Lines")
            {
                Editable = false;
                SubPageLink = "Document No." = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Ready)
            {
                Caption = 'Set As Ready For Application';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Set As Ready For Application action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to set this need as ready for application ?', false) then begin
                        Rec.Status := Rec.Status::Application;
                        Rec.Modify();
                    end;
                end;
            }
            action(Close)
            {
                Caption = 'Close Need';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Application";
                ToolTip = 'Executes the Close Need action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this need?', false) then begin
                        Rec.TestField(Remarks);
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify();
                    end;
                end;
            }
            action(Cancel)
            {
                Enabled = Rec.Status = Rec.Status::Application;
                Image = Cancel;
                Caption = 'Cancel Need';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this need?', false) then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify();
                    end;
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen For Editing';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Reopen For Editing action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reopen this need?', false) then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                end;
            }
            action("Training Participants")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Approved Trainings Subform";
                RunPageLink = "Training Need" = field(Code),
                              Status = filter(Released);
                RunPageMode = View;
                ToolTip = 'Executes the Training Participants action';
            }
            action("Training Evaluations")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Training Evaluation List";
                RunPageLink = "Training Name" = field(Code),
                              Submitted = filter(true);
                RunPageMode = View;
                ToolTip = 'Executes the Training Evaluations action';
            }
        }
    }
}





