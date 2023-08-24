codeunit 50100 "Series Lot Numbers"
{
    trigger OnRun()
    begin

    end;

    var
        ReservEntry: Record "Reservation Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntries: Record "Value Entry";

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
        ReservEntry.SetRange("Source ID", SourceID);
        ReservEntry.SetRange("Source Type", Database::"Sales Line");
        ReservEntry.SetRange("Source Subtype", SalesHeaderDocumentType);

        if ReservEntry.FindSet() then
            repeat
                TempTrackingSpecification.Init();
                TempTrackingSpecification."Entry No." := incrementNumber;
                TempTrackingSpecification."Lot No." := ReservEntry."Lot No.";
                TempTrackingSpecification."Serial No." := ReservEntry."Serial No.";
                TempTrackingSpecification."Quantity (Base)" := ReservEntry."Quantity (Base)" * (-1);
                TempTrackingSpecification."Source Ref. No." := ReservEntry."Source Ref. No.";
                TempTrackingSpecification.Insert();
                incrementNumber += 1;
            until ReservEntry.Next() = 0;
    end;

    local procedure RetrieveItemTrackingFromSalesInvoiceHeader(SourceID: Code[20]; var TempTrackingSpecification: Record "Tracking Specification" temporary; var incrementNumber: Integer)

    begin
        ValueEntries.SetRange("Document No.", SourceID);
        ValueEntries.SetRange("Document Type", ValueEntries."Document Type"::"Sales Invoice");
        if ValueEntries.FindSet() then
            repeat
                ItemLedgEntry.Get(ValueEntries."Item Ledger Entry No.");
                TempTrackingSpecification.Init();
                TempTrackingSpecification."Entry No." := incrementNumber;
                TempTrackingSpecification."Lot No." := ItemLedgEntry."Lot No.";
                TempTrackingSpecification."Serial No." := ItemLedgEntry."Serial No.";
                TempTrackingSpecification."Quantity (Base)" := ItemLedgEntry."Quantity" * (-1);
                TempTrackingSpecification."Source Ref. No." := ItemLedgEntry."Document Line No.";
                TempTrackingSpecification.Insert();
                incrementNumber += 1;
            until ValueEntries.Next() = 0;
    end;


}