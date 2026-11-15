namespace Nsc.Core.Logic;

using Microsoft.Sales.Reminder;
using Nsc.Core.Abstractions;
using Nsc.Core.Enums;

codeunit 1000005 "Nsc Reminder Manager" implements INscDocumentManager
{
    var
        IssuedReminderHeader: Record "Issued Reminder Header";

    procedure GetDocument(DocumentNo: Code[20]): RecordRef
    var
        DocumentRef: RecordRef;
    begin
        Clear(IssuedReminderHeader);

        IssuedReminderHeader.Get(DocumentNo);

        DocumentRef.GetTable(IssuedReminderHeader);
        exit(DocumentRef);
    end;

    procedure GetCustomerNo(DocumentNo: Code[20]): Code[20]
    var
        NoCustomerFoundLbl: Label 'Customer for invoice with no: %1, is not found', Comment = '%1 => Invoice No.';
    begin
        Clear(IssuedReminderHeader);

        if IssuedReminderHeader.Get(DocumentNo) then
            exit(IssuedReminderHeader."Customer No.");

        Error(NoCustomerFoundLbl, DocumentNo);
    end;

    procedure FetchDocuments()
    var
        DeliveriesHeaderMgt: Codeunit "Nsc Delivery Header Mgt.";
        SubmissionMgt: Codeunit "Nsc Delivery Submission Mgt.";
        CreatedDeliveryId: Guid;
        CreatedSubmissionId: Guid;
    begin
        Clear(IssuedReminderHeader);
        IssuedReminderHeader.SetLoadFields("No.");

        if IssuedReminderHeader.FindSet() then
            repeat
                if not DeliveriesHeaderMgt.ShouldCreateDelivery(Enum::"Nsc Document Type"::Invoice, IssuedReminderHeader."No.") then
                    continue;

                CreatedDeliveryId := DeliveriesHeaderMgt.CreateDelivery(Enum::"Nsc Document Type"::Invoice, IssuedReminderHeader."No.");

                CreatedSubmissionId := SubmissionMgt.CreateDocumentAsSubmission(CreatedDeliveryId, IssuedReminderHeader."No.");

                if ValidateReminderAsSubmission(IssuedReminderHeader, CreatedSubmissionId) then
                    SubmissionMgt.SetSubmissionStatus(CreatedSubmissionId, Enum::"Nsc Delivery Status"::ReadyForSending)
                else
                    SubmissionMgt.SetSubmissionStatus(CreatedSubmissionId, Enum::"Nsc Delivery Status"::FailedValidation);

                SubmissionMgt.FillSubmissionRecipientInformation(CreatedSubmissionId);
            until IssuedReminderHeader.Next() = 0;
    end;

    local procedure ValidateReminderAsSubmission(CreditMemo: Record "Issued Reminder Header"; SubmissionId: Guid): Boolean
    var
        DeliveryErrorMgt: Codeunit "Nsc Delivery Error Mgt.";
        IsValid: Boolean;
    begin
        IsValid := true;

        if CreditMemo."Name" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Name of customer is empty');
        end;

        if CreditMemo."Address" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Address of customer is empty');
        end;

        if CreditMemo."City" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'City of customer is empty');
        end;

        if CreditMemo."Post Code" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Post-code of customer is empty');
        end;

        if CreditMemo."Country/Region Code" = '' then begin
            IsValid := false;
            DeliveryErrorMgt.AddError(SubmissionId, 'Country/Region Code of customer is empty');
        end;

        OnAfterValidateReminderAsSubmission(CreditMemo, IsValid);

        exit(IsValid);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateReminderAsSubmission(var CreditMemo: Record "Issued Reminder Header"; var IsValid: Boolean)
    begin
    end;
}