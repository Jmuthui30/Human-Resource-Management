table 52188 Region
{
    Caption = 'Region';
    LookupPageID = Region;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }

        field(8; "Address Format"; Enum "Country/Region Address Format")
        {
            Caption = 'Address Format';
            InitValue = "City+Post Code";

            trigger OnValidate()
            begin

            end;
        }
        field(9; "Contact Address Format"; Option)
        {
            Caption = 'Contact Address Format';
            InitValue = "After Company Name";
            OptionCaption = 'First,After Company Name,Last';
            OptionMembers = First,"After Company Name",Last;
        }
        field(10; "VAT Scheme"; Code[10])
        {
            Caption = 'VAT Scheme';
        }

        field(12; "County Name"; Text[30])
        {
            Caption = 'County Name';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
            ObsoleteState = Pending;
            ObsoleteReason = 'This functionality will be replaced by the systemID field';
            ObsoleteTag = '15.0';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }

        key(Key4; Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Code", Name, "VAT Scheme")
        {
        }
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    trigger OnDelete()
    var
        VATRegNoFormat: Record "VAT Registration No. Format";
    begin
        VATRegNoFormat.SetRange("Country/Region Code", Code);
        VATRegNoFormat.DeleteAll();
    end;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnRename()
    begin
    end;

    var
        TypeHelper: Codeunit "Type Helper";

        CountryRegionNotFilledErr: Label 'You must specify a country or region.';
        ISOCodeLengthErr: Label 'The length of the string is %1, but it must be equal to %2 characters. Value: %3.', Comment = '%1, %2 - numbers, %3 - actual value';
        ASCIILetterErr: Label 'must contain ASCII letters only';
        NumericErr: Label 'must contain numbers only';




}

