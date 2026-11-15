namespace Nsc.Core.Logic;

using Microsoft.Sales.Customer;
using Nsc.Core.Enums;
using Nsc.Core.Persistance;

codeunit 1000008 "Nsc Delivery Submission Mgt."
{
    procedure FillSubmissionRecipientInformation(SubmissionId: Guid)
    var
        Customer: Record Customer;
        DeliveryHeader: Record "Nsc Delivery Header";
        Submission: Record "Nsc Delivery Submission";
        DocumentManager: Codeunit "Nsc Document Manager";
        CustomerNo: Code[20];
    begin
        if not Submission.Get(SubmissionId) then exit;

        DeliveryHeader.SetRange(SystemId, Submission."Delivery Header Entry No.");

        if not DeliveryHeader.FindFirst() then exit;

        CustomerNo := DocumentManager.GetCustomerNo(DeliveryHeader."Document Type", DeliveryHeader."Document No.");

        if not Customer.Get(CustomerNo) then exit;

        Submission."Recipient Name" := Customer.Name;
        Submission."Recipient Address" := Customer.Address;
        Submission."Recipient Country Code" := Customer."Country/Region Code";
        Submission."Recipient Post-Code" := Customer."Post Code";
        Submission."Recipient Email" := Customer."E-Mail";

        Submission.Modify();
    end;

    procedure SetSubmissionStatus(SubmissionEntryNo: Guid; Status: Enum "Nsc Delivery Status")
    var
        Submission: Record "Nsc Delivery Submission";
    begin
        if not Submission.Get(SubmissionEntryNo) then exit;

        Submission."Delivery Status" := Status;
        Submission.Modify();
    end;

    procedure CreateDocumentAsSubmission(DeliveryHeaderId: Guid; DocumentNo: Code[20]): Guid
    var
        Submission: Record "Nsc Delivery Submission";
        DeliveryHeader: Record "Nsc Delivery Header";
        SendingProfileMgt: Codeunit "Nsc Sending Profile Mgt";
    begin
        DeliveryHeader.SetRange(SystemId, DeliveryHeaderId);

        if not DeliveryHeader.FindFirst() then exit;

        Clear(Submission);

        Submission.Init();

        Submission."Delivery Header Entry No." := DeliveryHeaderId;
        Submission."Delivery Type" := SendingProfileMgt.MapCustomerPreferedSendingProfileToDeliveryType(
            GetCustomerSendingProfile(DeliveryHeader."Document Type", DeliveryHeader."Document No.")
        );
        Submission."Delivery Status" := Enum::"Nsc Delivery Status"::NoStatus;

        Submission.Insert();

        exit(Submission.SystemId);
    end;

    procedure GetCustomerSendingProfile(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]): Enum "Nsc Sending Profile"
    var
        CustomerSendingProfile: Record "Nsc Customer Sending Profile";
        DocumentManager: Codeunit "Nsc Document Manager";
        CustomerNo: Code[20];
        MissingCustomerSendingProfileSetupLbl: Label 'Missing customer sending profile for customer number: %1', Comment = '%1 => Customer No.';
    begin
        CustomerNo := DocumentManager.GetCustomerNo(DocumentType, DocumentNo);

        if not CustomerSendingProfile.Get(CustomerNo) then
            Error(MissingCustomerSendingProfileSetupLbl, CustomerNo);

        exit(CustomerSendingProfile."Sending Profile");
    end;
}