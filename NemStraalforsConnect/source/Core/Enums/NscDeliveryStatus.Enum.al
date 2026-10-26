namespace Nsc.Core.Enums;

enum 1000000 "Nsc Delivery Status"
{
    Extensible = true;

    value(0; ReadyForSending)
    {
        Caption = 'Ready for sending';
    }
    value(1; FailedValidation)
    {
        Caption = 'Failed validation';
    }

    value(2; MarkedForSending)
    {
        Caption = 'Marked for sending';
    }

    value(3; Sent)
    {
        Caption = 'Sent';
    }

    value(4; ValidationFailedByPostnord)
    {
        Caption = 'Validation failed by Postnord';
    }

    value(5; AcceptedByPostnord)
    {
        Caption = 'Accepted by Postnord';
    }

    value(6; ReceivedByEnduser)
    {
        Caption = 'Enduser has received the document';
    }

    value(7; FetchingStatus)
    {
        Caption = 'Fetching status';
    }
}