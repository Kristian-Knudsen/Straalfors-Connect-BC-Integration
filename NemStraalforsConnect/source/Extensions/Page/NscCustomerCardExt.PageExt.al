namespace Nsc.Extensions.Page;
using Microsoft.Sales.Customer;

pageextension 1000000 "Nsc Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter(Invoicing)
        {
            group("NemStraalforsConnect")
            {
                Caption = 'Nem Strålfors Connect';

                field(ExcludeFromReceiving; Rec.ExcludeFromReceiving)
                {
                    ApplicationArea = All;
                    Caption = 'Exclude from receiving';
                    ToolTip = 'If checked, customer will be excluded from receiving documents via. Strålfors Connect';
                }
            }
        }
    }
}