page 52125 "Employee Contract"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Contracts";
    Caption = 'Employee Contract';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';

                    trigger OnValidate()
                    begin

                        Clear(Rec.Tenure);
                        Rec."Start Date" := 0D;
                        Rec."Contract Type" := '';
                        Rec."End Date" := 0D;
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field';
                }
                field(Tenure; Rec.Tenure)
                {
                    Caption = 'Contract Length';
                    ToolTip = 'Specifies the value of the Contract Length field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Contract")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Open;
                ToolTip = 'Executes the Update Contract action';

                trigger OnAction()
                begin
                    if Confirm(Text002, true, Rec."Employee No", Rec."Employee Name") then begin
                        Rec.TestField("Employee No");
                        Rec.TestField("Start Date");
                        HRMgt.UpdateContract(Rec."No.", Rec."Employee No");
                        Message(Text001, Rec."Employee No", Rec."Employee Name");
                        //update leave days
                        /*EmployeeContracts.Reset();
                        EmployeeContracts.SetRange("Employee No", Rec."Employee No");
                        EmployeeContracts.SetRange("No.", Rec."No.");
                        if EmployeeContracts.FindFirst() then
                            HRMgt.AssignContracteeLeave(Rec."Employee No", Rec."Contract Type", Rec."End Date", EmployeeContracts);
                        Message(Text003, Rec."Employee No", Rec."Employee Name");*/
                        Rec.Status := Rec.Status::Released;
                    end;
                    CurrPage.Close();
                end;
            }
            action("Change request")
            {
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Released;
                ToolTip = 'Executes the Change request action';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        HRMgt: Codeunit "HR Management";
        Text001: Label 'Employee %1 - %2 Contract details Updated Successfully.';
        Text002: Label 'Do you want to update Contract details for %1 - %2? ';
}





