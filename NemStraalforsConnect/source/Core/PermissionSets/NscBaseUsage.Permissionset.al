namespace Nsc.Core.PermissionSets;

using Nsc.Core.DataExchangeFormats.Xml;
using Nsc.Core.Persistance;
using Nsc.Core.UI;

permissionset 1000000 "Nsc Base Usage"
{
    Assignable = false;
    Permissions = codeunit "Xml Parser" = X,
        tabledata "Nsc Customer Sending Profile" = RIM,
        page "Nsc Sending Profile Part" = X,
        page "Nsc Sending Profile Card" = X;
}
