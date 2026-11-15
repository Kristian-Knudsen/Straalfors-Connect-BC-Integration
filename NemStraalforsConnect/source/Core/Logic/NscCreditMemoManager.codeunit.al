namespace Nsc.Core.Logic;

using Microsoft.Sales.History;
using Nsc.Core.Abstractions;
using Nsc.Core.Enums;

codeunit 1000014 "Nsc CreditMemo Manager" implements INscDocumentManager
{
    var
        CreditMemoHeader: Record "Sales Cr.Memo Header";

    procedure GetDocument(DocumentNo: Code[20]): RecordRef
    var
        DocumentRef: RecordRef;
    begin
        Clear(CreditMemoHeader);

        CreditMemoHeader.Get(DocumentNo);

        DocumentRef.GetTable(CreditMemoHeader);
        exit(DocumentRef);
    end;

    procedure GetCustomerNo(DocumentNo: Code[20]): Code[20]
    var
        NoCustomerFoundLbl: Label 'Customer for invoice with no: %1, is not found', Comment = '%1 => Invoice No.';
    begin
        Clear(CreditMemoHeader);

        if CreditMemoHeader.Get(DocumentNo) then
            exit(CreditMemoHeader."Sell-to Customer No.");

        Error(NoCustomerFoundLbl, DocumentNo);
    end;

    procedure FetchDocuments()
    var
        DeliveriesHeaderMgt: Codeunit "Nsc Delivery Header Mgt.";
        SubmissionMgt: Codeunit "Nsc Delivery Submission Mgt.";
        CreatedDeliveryId: Guid;
        CreatedSubmissionId: Guid;
    begin
        Clear(CreditMemoHeader);
        CreditMemoHeader.SetLoadFields("No.");

        if CreditMemoHeader.FindSet() then
            repeat
                if not DeliveriesHeaderMgt.ShouldCreateDelivery(Enum::"Nsc Document Type"::Invoice, CreditMemoHeader."No.") then
                    continue;

                CreatedDeliveryId := DeliveriesHeaderMgt.CreateDelivery(Enum::"Nsc Document Type"::Invoice, CreditMemoHeader."No.");

                CreatedSubmissionId := SubmissionMgt.CreateDocumentAsSubmission(CreatedDeliveryId, CreditMemoHeader."No.");

                if ValidateCreditMemoAsSubmission(CreditMemoHeader, CreatedSubmissionId) then
                    SubmissionMgt.SetSubmissionStatus(CreatedSubmissionId, Enum::"Nsc Delivery Status"::ReadyForSending)
                else
                    SubmissionMgt.SetSubmissionStatus(CreatedSubmissionId, Enum::"Nsc Delivery Status"::FailedValidation);

                SubmissionMgt.FillSubmissionRecipientInformation(CreatedSubmissionId);
            until CreditMemoHeader.Next() = 0;
    end;

    local procedure ValidateCreditMemoAsSubmission(CreditMemo: Record "Sales Cr.Memo Header"; SubmissionId: Guid): Boolean
    var
        DeliveryErrorMgt: Codeunit "Nsc Delivery Error Mgt.";
        IsValid: Boolean;
    begin
        IsValid := true;

        if CreditMemo."Bill-to Name" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Name of customer is empty');
        end;

        if CreditMemo."Bill-to Address" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Address of customer is empty');
        end;

        if CreditMemo."Bill-to City" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to City of customer is empty');
        end;

        if CreditMemo."Bill-to Post Code" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Post-code of customer is empty');
        end;

        if CreditMemo."Bill-to Country/Region Code" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Bill-to Country/Region Code of customer is empty');
        end;

        OnAfterValidateCreditmemoAsSubmission(CreditMemo, IsValid);

        exit(IsValid);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateCreditmemoAsSubmission(var CreditMemo: Record "Sales Cr.Memo Header"; var IsValid: Boolean)
    begin
    end;
}