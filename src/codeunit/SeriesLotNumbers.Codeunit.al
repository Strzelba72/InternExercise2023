codeunit 50100 "Series Lot Numbers"
{
    trigger OnRun()
    begin

    end;

    var
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";


    procedure RetrieveItemTracking(TableNumber: Integer; SourceID: Code[20]; SalesHeaderDocumentType: Enum "Sales Document Type"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        incrementNumber: Integer;
    begin
        incrementNumber := 0;

        case TableNumber of
            DATABASE::"Sales Header":
                RetrieveItemTrackingFromSalesHeader(SourceID, SalesHeaderDocumentType, TempTrackingSpecification, incrementNumber);
            DATABASE::"Sales Invoice Header":
                RetrieveItemTrackingFromSalesInvoiceHeader(SourceID, TempTrackingSpecification, incrementNumber);
            else
                exit;
        end;

    end;

    local procedure RetrieveItemTrackingFromSalesHeader(SourceID: Code[20]; SalesHeaderDocumentType: Enum "Sales Document Type"; var TempTrackingSpecification: Record "Tracking Specification" temporary; var incrementNumber: Integer)
    begin
        ReservationEntry.SetRange("Source ID", SourceID);
        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        ReservationEntry.SetRange("Source Subtype", SalesHeaderDocumentType);

        if ReservationEntry.FindSet() then
            repeat
                TempTrackingSpecification.Init();
                TempTrackingSpecification."Entry No." := incrementNumber;
                TempTrackingSpecification."Lot No." := ReservationEntry."Lot No.";
                TempTrackingSpecification."Serial No." := ReservationEntry."Serial No.";
                TempTrackingSpecification."Quantity (Base)" := ReservationEntry."Quantity (Base)" * (-1);
                TempTrackingSpecification."Source Ref. No." := ReservationEntry."Source Ref. No.";
                TempTrackingSpecification.Insert();
                incrementNumber += 1;
            until ReservationEntry.Next() = 0;
    end;

    local procedure RetrieveItemTrackingFromSalesInvoiceHeader(SourceID: Code[20]; var TempTrackingSpecification: Record "Tracking Specification" temporary; var incrementNumber: Integer)

    begin
        ValueEntry.SetRange("Document No.", SourceID);
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        if ValueEntry.FindSet() then
            repeat
                ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.");
                TempTrackingSpecification.Init();
                TempTrackingSpecification."Entry No." := incrementNumber;
                TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
                TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
                TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry."Quantity" * (-1);
                TempTrackingSpecification."Source Ref. No." := ItemLedgerEntry."Document Line No.";
                TempTrackingSpecification.Insert();
                incrementNumber += 1;
            until ValueEntry.Next() = 0;
    end;


}