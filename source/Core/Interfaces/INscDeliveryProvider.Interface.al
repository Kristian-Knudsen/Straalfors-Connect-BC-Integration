namespace Nsc.Core.Interfaces;

interface INscDeliveryProvider
{
    procedure Send();
    procedure GetStatus();
}