page 52033 "Job Applicant Picture"
{
    ApplicationArea = All;
    Caption = 'Applicant Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Applicants;

    layout
    {
        area(content)
        {
            field(Image; Rec.Picture)
            {
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the applicant.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    PicInstream: InStream;
                    AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
                    FileName: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField("First Name");
                    Rec.TestField("Last Name");

                    if Rec.Picture.HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    UploadIntoStream('Select a picture to upload', '', AllFilesDescriptionTxt, FileName, PicInstream);
                    if FileName = '' then
                        exit;

                    Clear(Rec.Picture);
                    Rec.Picture.ImportStream(PicInstream, Rec."Full Name");
                    //Rec.Picture.ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    ToFile: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField("First Name");
                    Rec.TestField("Last Name");

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    /* ExportPath := TemporaryPath + Rec."No." + Format(Rec.Picture.MediaId);
                    Rec.Picture.ExportFile(ExportPath);

                    FileManagement.ExportImage(ExportPath, ToFile); */
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec.Picture);
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        MimeTypeTok: Label 'image/jpeg', Locked = true;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';

    local procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField("No.");
        Rec.TestField("First Name");
        Rec.TestField("Last Name");

        if Rec.Picture.HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Picture);
            Rec.Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.HasValue;
    end;
}







