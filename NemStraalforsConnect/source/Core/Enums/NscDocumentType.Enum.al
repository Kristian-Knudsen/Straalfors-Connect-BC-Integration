namespace Nsc.Core.Enums;

enum 1000001 "Nsc Document Type"
{
    Extensible = true;

    value(0; Invoice)
    {
        Caption = 'Invoice';
    }

    value(1; CreditMemo)
    {
        Caption = 'Credit memo';
    }

    value(2; Reminder)
    {
        Caption = 'Reminder';
    }
}