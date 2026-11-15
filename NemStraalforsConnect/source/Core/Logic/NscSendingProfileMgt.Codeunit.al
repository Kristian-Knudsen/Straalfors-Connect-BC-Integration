namespace Nsc.Core.Logic;
using Nsc.Core.Enums;

codeunit 1000012 "Nsc Sending Profile Mgt"
{
    procedure MapCustomerPreferedSendingProfileToDeliveryType(CustomerSendingProfile: Enum "Nsc Sending Profile"): Enum "Nsc Delivery Type"
    var
        InvalidMapLbl: Label 'No mapping found for Customer Sending Profile: %1', Comment = '%1 => Customer sending profile';
    begin
        case CustomerSendingProfile of
            Enum::"Nsc Sending Profile"::Email:
                exit(Enum::"Nsc Delivery Type"::Email);

            else
                Error(InvalidMapLbl, CustomerSendingProfile);
        end;
    end;
}