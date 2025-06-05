page 52067 "Employee Transfer Card"
{
    ApplicationArea = All;
    Caption = 'Job Rotation Card';
    PageType = Card;
    SourceTable = "Employee Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transfer No"; Rec."Transfer No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transfer No field';

                    trigger OnValidate()
                    begin

                        if Employee.Get(Rec."Transfer No") then
                            Employee.TestField("Date Of Join");

                        Rec.County := Rec.GetAge(Employee."Date Of Join");
                    end;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Employee No field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Job Position"; Rec."Job Position")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Position field.';
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Position Title field.';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mobile No field';
                }
                field("Job Group"; Rec."Job Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Group field';
                }
                field("Length of Stay"; Rec."Length of Stay")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Length of Stay field';
                }
                field("Shortcut Dimension 1"; Rec."Shortcut Dimension 1") { }
                field("Shortcut Dimension 2"; Rec."Shortcut Dimension 2")
                {
                    //  Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 field';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field';
                }
                field("Sub County"; Rec."Sub County")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Sub County field';
                }
                field(County; Rec.County)
                {
                    Editable = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the County field';
                }
                label("Transfer Details:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ToolTip = 'Specifies the value of the Transfer Type field';
                }
                group(Control28)
                {
                    ShowCaption = false;
                    Visible = Rec."Transfer Type" = Rec."Transfer Type"::Internal;

                    field("Station To Transfer"; Rec."Station To Transfer")
                    {
                        MultiLine = false;
                        ToolTip = 'Specifies the value of the Station To Transfer field';
                    }
                    field("Transfer Department Name"; Rec."Transfer Department Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Transfer Department Name field';
                    }
                    field("New Job Position"; Rec."New Job Position")
                    {
                        ToolTip = 'Specifies the value of the New Job Position field.';
                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                    field("New Job Position Title"; Rec."New Job Position Title")
                    {
                        ToolTip = 'Specifies the value of the New Job Position Title field.';
                    }
                }
                group(Control29)
                {
                    ShowCaption = false;
                    Visible = Rec."Transfer Type" = Rec."Transfer Type"::External;

                    field(Company; Rec.Company)
                    {
                        ToolTip = 'Specifies the value of the Company field';
                    }
                }
                field("Reason of Transfer"; Rec."Reason of Transfer")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Reason of Transfer field';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                label("Head of Department:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the HOD Employee No field';
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the HOD Name field';
                }
                field("HOD Recommendations"; Rec."HOD Recommendations")
                {
                    Editable = true;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the HOD Recommendations field';
                }
                field("Transfer Date"; Rec."Transfer Date")
                {
                    ToolTip = 'Specifies the value of the Transfer Date field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send For Approval action';
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Cancel Approval Request action';
            }
            action("Transfer Staff")
            {
                Image = ContactReference;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Transfer Staff action';

                trigger OnAction()
                begin

                    if Rec."Transfer Type" = Rec."Transfer Type"::Internal then begin
                        Rec.TestField("Station To Transfer");
                        Rec.TestField("Employee No");
                        if Confirm(Text001, true, Rec."Employee No", Rec."Employee Name", Rec."Station To Transfer", Rec."Transfer Department Name") = false
                          then
                            exit
                        else
                            HRMgt.TransferEmployee(Rec."Transfer No", Rec."Employee No", Rec.Company);
                        Message(Text002, Rec."Employee No", Rec."Employee Name", Rec."Station To Transfer", Rec."Transfer Department Name");
                    end;


                    if Rec."Transfer Type" = Rec."Transfer Type"::External then begin
                        Rec.TestField(Company);
                        Rec.TestField("Employee No");
                        if Confirm(Text003, true, Rec."Employee No", Rec."Employee Name", Rec.Company) = false
                          then
                            exit
                        else
                            HRMgt.TransferEmployee(Rec."Transfer No", Rec."Employee No", Rec.Company);
                        Message(Text004, Rec."Employee No", Rec."Employee Name", Rec.Company);
                        HRMgt.DeleteEmployee(Rec."Employee No");
                    end;

                    CurrPage.Close();
                    Rec.Status := Rec.Status::Released;
                end;
            }
        }
    }

    var
        Employee: Record Employee;
        HRMgt: Codeunit "HR Management";
        Text001: Label 'Do you want to transfer Employee %1 - %2 to Department %3 - %4?';
        Text002: Label 'Employee %1 - %2 has been transferred Successfully to %3 - %4 Department Successfully';
        Text003: Label 'Do you want to transfer Employee %1 - %2 to %3?';
        Text004: Label 'Employee %1 - %2 has been transferred Successfully to %3';
}





