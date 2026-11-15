namespace Nsc.Core.Logic;

using Nsc.Core.Enums;
using Nsc.Core.Persistance;

codeunit 1000009 "Nsc Delivery Header Mgt."
{
    procedure ShouldCreateDelivery(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]): Boolean
    var
        SkipCreation: Boolean;
    begin
        if DeliveryHeaderExists(DocumentType, DocumentNo) then
            exit(false);

        OnBeforeCreateDeliveryHeader(DocumentType, DocumentNo, SkipCreation);

        exit(not SkipCreation);
    end;

    procedure CreateDelivery(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]): Guid
    var
        DeliveryHeader: Record "Nsc Delivery Header";
        DocumentManager: Codeunit "Nsc Document Manager";
    begin
        DeliveryHeader.Init();

        DeliveryHeader."Document Type" := DocumentType;
        DeliveryHeader."Document No." := DocumentNo;
        DeliveryHeader."Customer No." := DocumentManager.GetCustomerNo(DocumentType, DocumentNo);

        DeliveryHeader.Insert();

        Message(DeliveryHeader.SystemId);

        exit(DeliveryHeader.SystemId);
    end;

    local procedure DeliveryHeaderExists(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]): Boolean
    var
        DeliveryHeader: Record "Nsc Delivery Header";
    begin
        DeliveryHeader.SetRange("Document Type", DocumentType);
        DeliveryHeader.SetRange("Document No.", DocumentNo);

        exit(not DeliveryHeader.IsEmpty());
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateDeliveryHeader(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]; var SkipCreation: Boolean)
    begin
    end;
}