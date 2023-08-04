report 50100 "ITMS Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultRenderingLayout = './src/report/layouts/PaymentCommission.rdlc';
    Caption = 'Report';

    /*
        dataset
        {
            dataitem(DataItemName; SourceTableName)
            {
                column(ColumnName; SourceFieldName)
                {

                }
            }

        }

        requestpage
        {
            layout
            {
                area(Content)
                {
                    group(GroupName)
                    {
                        field(Name; SourceExpression)
                        {
                            ApplicationArea = All;

                        }
                    }
                }
            }

            actions
            {
                area(processing)
                {
                    action(ActionName)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        rendering
        {
            layout(LayoutName)
            {
                Type = RDLC;
                LayoutFile = 'mylayout.rdl';
            }
        }

        var
            myInt: Integer;
            */
}