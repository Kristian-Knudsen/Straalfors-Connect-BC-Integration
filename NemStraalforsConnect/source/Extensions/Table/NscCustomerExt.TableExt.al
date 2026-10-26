namespace Nsc.Extensions.Table;
using Microsoft.Sales.Customer;

tableextension 1000000 "Nsc Customer Ext" extends Customer
{
    fields
    {
        field(1000000; ExcludeFromReceiving; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}