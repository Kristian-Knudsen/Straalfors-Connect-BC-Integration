namespace Nsc.Core.Extensions.Page;

using Microsoft.Sales.Customer;
using Nsc.Core.UI;

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

        addbefore(Control149)
        {
            part("Nsc Customer Sending Profile"; "Nsc Sending Profile Part")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}