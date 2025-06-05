tableextension 52007 "Qualification Table Ext" extends Qualification
{
    fields
    {
        field(52000; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
            DataClassification = CustomerContent;
            Caption = 'Qualification Type';
        }
        field(52001; "Field of Study"; Code[50])
        {
            TableRelation = "Field of Study";
            DataClassification = CustomerContent;
            Caption = 'Field of Study';
        }
        field(52002; "Education Level"; Enum "Education Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Education Level';
        }
    }
}





