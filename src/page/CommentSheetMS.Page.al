page 50100 "Comment Sheet MS"
{
    AutoSplitKey = true;
    Caption = 'Comment Sheet MS';
    DataCaptionFields = "Journal Template Name", "Journal Batch Name", "Line No.", "G/L Entry No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = CommentsTable;

    layout
    {
        area(content)

        {

            repeater(Control1)
            {
                Editable = PageEditable;
                ShowCaption = false;


                field(Date; Rec.Date)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the date the comment was created.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the comment itself.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies a code for the comment.';
                    Visible = false;
                }
            }
        }
    }


    actions
    {
    }
    var
        PageEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        if Rec."G/L Entry No." = 0 then
            PageEditable := true
        else
            PageEditable := false;

        CurrPage.Editable(PageEditable);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //SetUpNewLine();
    end;

}