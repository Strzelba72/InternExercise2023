pageextension 50101 GLEntriesExt extends "General Ledger Entries"
{
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
                RunPageLink = "G/L Entry No." = field("Entry No.");

                trigger OnAction();
                begin
                    Message('My message');
                end;
            }
        }
    }
}