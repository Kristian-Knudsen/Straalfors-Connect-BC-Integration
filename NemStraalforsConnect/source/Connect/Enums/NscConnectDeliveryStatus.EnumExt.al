namespace Nsc.Connect.Enums;

using Nsc.Core.Enums;

enumextension 1000000 "Nsc Connect Delivery Status" extends "Nsc Delivery Status"
{
    value(1000000; ValidationFailedByPostnord)
    {
        Caption = 'Validation failed by Postnord';
    }

    value(1000001; AcceptedByPostnord)
    {
        Caption = 'Accepted by Postnord';
    }

    value(1000002; ReceivedByEnduser)
    {
        Caption = 'Enduser has received the document';
    }

    value(1000003; FetchingStatus)
    {
        Caption = 'Fetching status';
    }
}