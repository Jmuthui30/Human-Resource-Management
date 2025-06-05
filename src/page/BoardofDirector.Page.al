page 52126 "Board of Director"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Board of Director";
    Caption = 'Board of Director';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(SurName; Rec.SurName)
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the SurName field';
                }
                field("Other Names"; Rec."Other Names")
                {
                    ToolTip = 'Specifies the value of the Other Names field';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Phone No field';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ToolTip = 'Specifies the value of the PIN Number field';
                }
                field(Nationality; Rec.Nationality)
                {
                    ToolTip = 'Specifies the value of the Nationality field';
                }
                field(Occupation; Rec.Occupation)
                {
                    ToolTip = 'Specifies the value of the Occupation field';
                }
            }
            group(Dates)
            {
                Caption = 'Dates';

                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ToolTip = 'Specifies the value of the Termination Date field';
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Appointment Date field';
                }
            }
        }
    }

    actions
    {
    }
}





