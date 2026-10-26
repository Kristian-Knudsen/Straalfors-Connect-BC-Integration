namespace Nsc.Extensions.Page;

using Microsoft.Sales.History;

pageextension 1000001 "Nsc Posted Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Invoice Details")
        {
            field(HandledByNsc; Rec.HandledByNsc)
            {
                Caption = 'Is handled by Nsc';
                ToolTip = 'If this is checked the document is to be found in a Nsc Delivery page';
            }
        }
    }
}