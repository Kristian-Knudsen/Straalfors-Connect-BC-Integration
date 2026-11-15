namespace Nsc.Core.PermissionSets;

using Nsc.Core.Persistance;
using Nsc.Core.UI;

permissionset 1000002 "Nsc Admin"
{
    Assignable = true;

    IncludedPermissionSets = "Nsc Base Usage";

    Permissions = tabledata "Nsc Setup" = RIMD,
        table "Nsc Setup" = X,
        page "Nsc Setup" = X;
}