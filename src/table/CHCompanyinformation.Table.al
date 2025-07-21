table 52899 "CH Company information"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(2; Name; text[1000])
        {
            Caption = 'Document Name';
            DataClassification = ToBeClassified;
        }
        field(3; Address1; text[1000])
        {
            Caption = 'Address 1';
            DataClassification = ToBeClassified;
        }
        field(4; "Document type"; Enum "Document Attachment File Type")
        {
            Caption = 'Document Type';

            DataClassification = ToBeClassified;
        }
        field(5; Description; text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; CreatedAtUtc; DateTime)
        {
            Caption = 'Created At';
            DataClassification = ToBeClassified;
        }
        field(7; CreatedByUserId; Text[50])
        {
            Caption = 'Created By User ID';
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(Key1; code)
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}