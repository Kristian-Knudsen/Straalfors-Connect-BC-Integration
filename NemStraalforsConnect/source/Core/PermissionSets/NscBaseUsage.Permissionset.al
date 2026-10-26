namespace Nsc.Core.PermissionSets;

using Nsc.Core.DataExchangeFormats.Xml;

permissionset 1000000 "Nsc Base Usage"
{
    Assignable = false;
    Permissions = codeunit "Xml Parser" = X;
}