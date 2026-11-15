namespace Nsc.Core.Enums;
using Nsc.Core.Abstractions;
using Nsc.Core.Logic;

enum 1000005 "Nsc Document Managers" implements INscDocumentManager
{
    Extensible = true;

    value(0; Invoice)
    {
        Implementation = INscDocumentManager = "Nsc Invoice Manager";
    }

    value(1; Creditmemo)
    {
        Implementation = INscDocumentManager = "Nsc CreditMemo Manager";
    }

    value(2; Reminder)
    {
        Implementation = INscDocumentManager = "Nsc Reminder Manager";
    }
}