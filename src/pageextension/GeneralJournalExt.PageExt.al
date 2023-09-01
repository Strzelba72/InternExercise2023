pageextension 50100 GeneralJournalExt extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Navigation)
        {
            action(CommentsMS)
            {
                Caption = 'CommentsMS';
                Image = Comment;
                ToolTip = 'Comments';

                RunObject = Page "Comment Sheet MS";
                RunPageLink = "Journal Template Name" = field("Journal Template Name"),
                                  "Journal Batch Name" = field("Journal Batch Name"),
                                  "Line No." = field("Line No.");

                trigger OnAction();
                begin
                    Message('My message');
                end;
            }
        }
    }

}