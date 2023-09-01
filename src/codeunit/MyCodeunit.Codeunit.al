codeunit 50101 MyCodeunit
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertGLEntry', '', false, false)]
    local procedure MyProcedure(GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line")
    var
        CommentsTable: Record CommentsTable;
        CommentsTable2: Record CommentsTable;
    begin
        CommentsTable.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        CommentsTable.SetRange("Line No.", GenJnlLine."Line No.");
        CommentsTable.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        if CommentsTable.FindSet() then
            Message('i found');
        repeat
            CommentsTable2.Init();

            CommentsTable2."G/L Entry No." := GLEntry."Entry No.";
            CommentsTable2."Journal Template Name" := '';
            CommentsTable2."Line No." := 0;
            CommentsTable2."Journal Batch Name" := '';
            CommentsTable2."Comment Line No." := CommentsTable."Comment Line No.";
            CommentsTable2.Date := CommentsTable.Date;
            CommentsTable2.Comment := CommentsTable.Comment;
            CommentsTable2.Code := CommentsTable.Code;

            CommentsTable2.Insert();



        until CommentsTable.Next() = 0;

        //ComentsTable.Reset();
        //.SetRange("G/L Entry No.",GLEntry."Entry No.")


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterGLFinishPosting', '', false, false)]
    local procedure MyProcedure2(GenJnlLine: Record "Gen. Journal Line")
    var
        CommentsTable: Record CommentsTable;
    begin
        CommentsTable.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        CommentsTable.SetRange("Line No.", GenJnlLine."Line No.");
        CommentsTable.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        CommentsTable.DeleteAll();


    end;

}