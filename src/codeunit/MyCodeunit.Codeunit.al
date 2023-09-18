codeunit 50101 MyCodeunit
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertGLEntry', '', false, false)]
    local procedure MyProcedure(GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line")
    var
        CommentsTable: Record CommentsTable;
        CommentsTable2: Record CommentsTable;
    //SalesCommentLine: Record "Sales Comment Line";
    begin
        if (GenJnlLine."Journal Template Name" <> '') and (GenJnlLine."Line No." <> 0) and (GenJnlLine."Journal Batch Name" <> '') then begin
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
        end;



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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostGLAndCustomer', '', false, false)]
    local procedure MyProcedure3(CustLedgEntry: Record "Cust. Ledger Entry"; SalesHeader: Record "Sales Header")
    var
        GLRegisters: Record "G/L Register";
        CommentsTable: Record CommentsTable;
        SalesCommentLine: Record "Sales Comment Line";
        GLStart: Integer;
        GLEnd: Integer;
        I: Integer;
    begin
        GLRegisters.SetFilter("To Entry No.", '<=%1', CustLedgEntry."Entry No.");
        GLRegisters.FindLast();
        GLStart := GLRegisters."From Entry No.";
        GLEnd := GLRegisters."To Entry No.";
        SalesCommentLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesCommentLine.SetRange("No.", SalesHeader."No.");
        if SalesCommentLine.FindSet() then
            repeat
                for I := GLStart to GLEnd do begin
                    CommentsTable.Init();
                    CommentsTable."G/L Entry No." := I;
                    CommentsTable."Journal Template Name" := '';
                    CommentsTable."Line No." := 0;
                    CommentsTable."Journal Batch Name" := '';
                    CommentsTable."Comment Line No." := SalesCommentLine."Line No.";
                    CommentsTable.Date := SalesCommentLine.Date;
                    CommentsTable.Comment := SalesCommentLine.Comment;
                    CommentsTable.Code := SalesCommentLine.Code;
                    CommentsTable.Insert();
                end;
            until SalesCommentLine.Next() = 0;



    end;





}