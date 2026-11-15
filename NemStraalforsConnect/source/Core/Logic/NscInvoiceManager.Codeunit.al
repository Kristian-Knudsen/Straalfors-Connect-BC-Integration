namespace Nsc.Core.Logic;

using Microsoft.Sales.History;
using Nsc.Core.Abstractions;
using Nsc.Core.Enums;

codeunit 1000010 "Nsc Invoice Manager" implements INscDocumentManager
{
    var
        InvoiceHeader: Record "Sales Invoice Header";

    procedure GetDocument(DocumentNo: Code[20]): RecordRef
    var
        DocumentRef: RecordRef;
    begin
        Clear(InvoiceHeader);

        InvoiceHeader.Get(DocumentNo);

        DocumentRef.GetTable(InvoiceHeader);
        exit(DocumentRef);
    end;

    procedure GetCustomerNo(DocumentNo: Code[20]): Code[20]
    var
        NoCustomerFoundLbl: Label 'Customer for invoice with no: %1, is not found', Comment = '%1 => Invoice No.';
    begin
        Clear(InvoiceHeader);

        if InvoiceHeader.Get(DocumentNo) then
            exit(InvoiceHeader."Sell-to Customer No.");

        Error(NoCustomerFoundLbl, DocumentNo);
    end;

    procedure FetchDocuments()
    var
        DeliveriesHeaderMgt: Codeunit "Nsc Delivery Header Mgt.";
        SubmissionMgt: Codeunit "Nsc Delivery Submission Mgt.";
        CreatedDeliveryId: Guid;
        CreatedSubmissionId: Guid;
    begin
        Clear(InvoiceHeader);
        InvoiceHeader.SetLoadFields("No.");

        if InvoiceHeader.FindSet() then
            repeat
                if not DeliveriesHeaderMgt.ShouldCreateDelivery(Enum::"Nsc Document Type"::Invoice, InvoiceHeader."No.") then
                    continue;

                CreatedDeliveryId := DeliveriesHeaderMgt.CreateDelivery(Enum::"Nsc Document Type"::Invoice, InvoiceHeader."No.");

                CreatedSubmissionId := SubmissionMgt.CreateDocumentAsSubmission(CreatedDeliveryId, InvoiceHeader."No.");

                if ValidateInvoiceAsSubmission(InvoiceHeader, CreatedSubmissionId) then
                    SubmissionMgt.SetSubmissionStatus(CreatedSubmissionId, Enum::"Nsc Delivery Status"::ReadyForSending)
                else
                    SubmissionMgt.SetSubmissionStatus(CreatedSubmissionId, Enum::"Nsc Delivery Status"::FailedValidation);

                SubmissionMgt.FillSubmissionRecipientInformation(CreatedSubmissionId);

            until InvoiceHeader.Next() = 0;
    end;

    local procedure ValidateInvoiceAsSubmission(Invoice: Record "Sales Invoice Header"; SubmissionId: Guid): Boolean
    var
        DeliveryErrorMgt: Codeunit "Nsc Delivery Error Mgt.";
        IsValid: Boolean;
    begin
        IsValid := true;

        if Invoice."Bill-to Name" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Name of customer is empty');
        end;

        if Invoice."Bill-to Address" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Address of customer is empty');
        end;

        if Invoice."Bill-to City" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to City of customer is empty');
        end;

        if Invoice."Bill-to Post Code" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Post-code of customer is empty');
        end;

        if Invoice."Bill-to Country/Region Code" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Country/Region Code of customer is empty');
        end;

        OnAfterValidateInvoiceAsSubmission(Invoice, IsValid);

        exit(IsValid);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateInvoiceAsSubmission(var Invoice: Record "Sales Invoice Header"; var IsValid: Boolean)
    begin
    end;
}