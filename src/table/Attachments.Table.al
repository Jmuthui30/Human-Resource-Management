table 52075 "Attachments"
{
    DrillDownPageID = "Attachments Setup";
    LookupPageID = "Attachments Setup";
    DataClassification = CustomerContent;
    Caption = 'Attachments';
    fields
    {
        field(1; Attachment; Code[20])
        {
            Caption = 'Attachment';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Attachment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





