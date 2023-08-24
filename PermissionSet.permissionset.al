permissionset 50100 PermissionSet
{
    Assignable = true;
    Permissions = report "ITMS Order Confirmation" = X,
        report "ITMS Report Payment Commission" = X,
        report "ITMS Sales - Invoice" = X,
        codeunit "Series Lot Numbers" = X;
}