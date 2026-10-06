namespace Nsc.Core.PermissionSets;

using Nsc.Core.DataExchangeFormats.Xml;
using Nsc.Persistance;
using Nsc.UI;

permissionset 1000000 NscAdmin
{
    Assignable = true;
    Permissions = tabledata NscSetup = RIMD,
        table NscSetup = X,
        codeunit XmlParser = X,
        page NscSetup = X;
}