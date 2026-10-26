namespace Nsc.Extensions.Table;
using Microsoft.Sales.History;

tableextension 1000001 "Nsc Sales Inv Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(1000000; HandledByNsc; Boolean)
        {
            DataClassification = SystemMetadata;
        }
    }
}