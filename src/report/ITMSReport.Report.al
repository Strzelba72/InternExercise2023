report 50100 "ITMS Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    RDLCLayout = './src/report/layouts/SalespersonCommission2.rdlc';
    //Caption = 'Report Payment Commission';
    Caption = 'Report';


    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(Salesperson_Purchaser__TABLECAPTION__________SalespersonFilter; TableCaption + ': ' + SalespersonFilter)
            {
            }
            column(SalespersonFilter; SalespersonFilter)
            {
            }
            column(Cust__Ledger_Entry__TABLECAPTION__________CustLedgEntryFilter; "Detailed Cust. Ledg. Entry".TableCaption + ': ' + CustLedgEntryFilter)
            {
            }
            column(CustLedgEntryFilter; CustLedgEntryFilter)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(Salesperson_Purchaser__Commission___; "Commission %")
            {
            }
            column(Cust__Ledger_Entry___Sales__LCY__; "Cust. Ledger Entry"."Sales (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Profit__LCY__; "Cust. Ledger Entry"."Profit (LCY)")
            {
            }
            column(SalesCommissionAmt; SalesCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(ProfitCommissionAmt; ProfitCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(AdjProfit; AdjProfit)
            {
                AutoFormatType = 1;
            }
            column(AdjProfitCommissionAmt; AdjProfitCommissionAmt)
            {
                AutoFormatType = 1;
            }
            column(Salesperson___CommissionCaption; Salesperson___CommissionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; Cust__Ledger_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(Invoice_No__Caption; Invoice_No)
            {
            }
            column(Payment_No__Caption; Payment_No)
            {
            }
            column(Invoice_Amount__LCY__Caption; Invoice_Amount__LCY)
            {
            }
            column(Profit_Amount__Caption; "Cust. Ledger Entry".FieldCaption("Profit (LCY)"))
            {
            }
            column(SalesCommissionAmt_Control32Caption; SalesCommissionAmt_Control32CaptionLbl)
            {
            }
            column(ProfitCommissionAmt_Control33Caption; ProfitCommissionAmt_Control33CaptionLbl)
            {
            }
            column(PaymentAmountCaption; PaymentAmountCaptionLbl)
            {
            }
            column(SalespersonCommissionAmountCaption; SalespersonCommissionAmountCaptionLbl)
            {
            }
            column(Salesperson_Purchaser__Commission___Caption; FieldCaption("Commission %"))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PrintDetailsLayout; PrintLDetails)
            {

            }
            column(SalesPearsonLabelTotalLayout1; SalesPearsonLabelTotal1)
            {

            }
            column(SalesPearsonLabelTotalLayout2; SalesPearsonLabelTotal2)
            {

            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {

            }

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {

                DataItemLink = "Salesperson Code" = field(Code);
                DataItemTableView = sorting("Posting Date") where("Document Type" = filter(Invoice), "Sales (LCY)" = filter(<> 0));

                PrintOnlyIfDetail = true;
                column(TotalInvoicesSum; TotalSumCalcInvoiceAmount)
                {
                    AutoFormatType = 1;
                }
                column(TotalProfitSum; TotalSumCalcProfitAmount)
                {
                    AutoFormatType = 1;
                }
                column(PartialInvoicesSum; PartialSumCalcInvoiceAmount)
                {
                    AutoFormatType = 1;
                }
                column(PartialProfitSum; PartialSumCalcProfitAmount)
                {
                    AutoFormatType = 1;
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")

                {
                    DataItemLink = "Cust. Ledger Entry No." = field("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = sorting("Posting Date", "Document No.") where("Entry Type" = filter("Application"), "Document Type" = filter("Payment"));
                    RequestFilterFields = "Posting Date";
                    column(Cust__Ledger_Entry__Posting_Date_; Format("Detailed Cust. Ledg. Entry"."Posting Date"))
                    {
                    }
                    column(Cust__Ledger_Entry__Posting_Date_Month; Date2DMY("Detailed Cust. Ledg. Entry"."Posting Date", 2))
                    {
                    }
                    column(Cust__Ledger_Entry__Document_No__; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(Cust__Ledger_Entry__Customer_No__; "Detailed Cust. Ledg. Entry"."Document No.")
                    {
                    }
                    column(Cust__Ledger_Entry__Sales__LCY__; "Cust. Ledger Entry"."Sales (LCY)")
                    {
                    }
                    column(Cust__Ledger_Entry__Profit__LCY__; "Cust. Ledger Entry"."Profit (LCY)")
                    {
                    }
                    column(PaymantAmountLayout; "Detailed Cust. Ledg. Entry"."Amount (LCY)" * (-1))
                    {
                        AutoFormatType = 1;
                        //DecimalPlaces = 2 : 2;
                    }
                    column(SalesCommissionLayout; SalesCommissionAmt)
                    {
                        AutoFormatType = 1;
                    }
                    column(Salesperson_Purchaser__Name; "Salesperson/Purchaser".Name)
                    {
                    }


                    trigger OnAfterGetRecord()
                    begin
                        TotalSumCalcInvoiceAmountBoolen := true;
                        SalesCommissionAmt := Round(("Detailed Cust. Ledg. Entry"."Amount (LCY)" * (-1)) / ("Cust. Ledger Entry"."Sales (LCY)") * ("Salesperson/Purchaser"."Commission %" / 100) * "Cust. Ledger Entry"."Profit (LCY)");
                        TotalSumCalcInvoiceAmount := TotalSumCalcInvoiceAmountPost + "Cust. Ledger Entry"."Sales (LCY)";
                        TotalSumCalcProfitAmount := TotalSumCalcProfitAmountPost + "Cust. Ledger Entry"."Profit (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin


                        ClearAmounts();
                    end;

                    trigger OnPostDataItem()

                    begin

                        if (TotalSumCalcInvoiceAmountBoolen) then begin
                            TotalSumCalcInvoiceAmountBoolen := false;
                            TotalSumCalcInvoiceAmountPost += "Cust. Ledger Entry"."Sales (LCY)";
                            TotalSumCalcProfitAmountPost += "Cust. Ledger Entry"."Profit (LCY)";
                        end;


                    end;

                }

                trigger OnPreDataItem()
                begin

                    ClearAmounts();
                end;



            }

            trigger OnAfterGetRecord()
            begin
                ClearPartialSum();
                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                ClearAmounts();


            end;

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Suite;
                        Caption = 'New Page per Person';
                        ToolTip = 'Specifies if each person''s information is printed on a new page if you have chosen two or more persons to be included in the report.';
                    }
                    field(PrintLDetails; PrintLDetails)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Print less Details';
                        ToolTip = 'Show less infromation about payments';

                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        SalespersonFilter := "Salesperson/Purchaser".GetFilters();
        CustLedgEntryFilter := "Detailed Cust. Ledg. Entry".GetFilters();
        PeriodText := "Detailed Cust. Ledg. Entry".GetFilter("Posting Date");
    end;

    var
        Text000: Label 'Period: %1';
        SalespersonFilter: Text;
        CustLedgEntryFilter: Text;
        PeriodText: Text;
        AdjProfit: Decimal;
        ProfitCommissionAmt: Decimal;
        AdjProfitCommissionAmt: Decimal;
        SalesCommissionAmt: Decimal;
        PrintOnlyOnePerPage: Boolean;
        PrintLDetails: Boolean;
        PageGroupNo: Integer;
        Salesperson___CommissionCaptionLbl: Label 'Salesperson - Payment Commission';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        Cust__Ledger_Entry__Posting_Date_CaptionLbl: Label 'Posting Date';
        SalesCommissionAmt_Control32CaptionLbl: Label 'Sales Commission (LCY)';
        ProfitCommissionAmt_Control33CaptionLbl: Label 'Profit Commission (LCY)';
        PaymentAmountCaptionLbl: Label 'Payment Amount (LCY)';
        SalespersonCommissionAmountCaptionLbl: Label 'Salesperson Commission Amount (LCY)';
        TotalCaptionLbl: Label 'Total';
        TotalSumCalcInvoiceAmount: Decimal;
        TotalSumCalcInvoiceAmountPost: Decimal;
        TotalSumCalcInvoiceAmountBoolen: Boolean;
        TotalSumCalcProfitAmount: Decimal;
        TotalSumCalcProfitAmountPost: Decimal;
        PartialSumCalcInvoiceAmount: Decimal;
        PartialSumCalcInvoiceAmountPost: Decimal;
        PartialSumCalcProfitAmount: Decimal;
        PartialSumCalcProfitAmountPost: Decimal;
        SalesPearsonLabelTotal1: Label 'Salesperson: ';
        SalesPearsonLabelTotal2: Label ' Comission Total';
        Invoice_No: Label 'Invoice No.';
        Payment_No: Label 'Payment No.';
        Invoice_Amount__LCY: Label 'Invoice Amount (LCY)';



    local procedure ClearAmounts()
    begin
        Clear(AdjProfit);
        Clear(ProfitCommissionAmt);
        Clear(AdjProfitCommissionAmt);
        Clear(SalesCommissionAmt);

    end;

    local procedure ClearPartialSum()
    begin
        Clear(PartialSumCalcInvoiceAmount);
        Clear(PartialSumCalcInvoiceAmountPost);
        Clear(PartialSumCalcProfitAmount);
        Clear(PartialSumCalcProfitAmountPost);

    end;




}

