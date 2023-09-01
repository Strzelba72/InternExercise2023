table 50100 CommentsTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(4; "G/L Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; "Comment Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(50; Date; Date)
        {
            Caption = 'Date';
        }
        field(60; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(70; Comment; Text[80])
        {
            Caption = 'Comment';
        }


    }

    keys
    {
        key(PK; "Journal Template Name", "Line No.", "Journal Batch Name", "G/L Entry No.", "Comment Line No.")
        {
            Clustered = true;
        }
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