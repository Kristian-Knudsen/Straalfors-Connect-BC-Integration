namespace Nsc.Core.Logic;

using Nsc.Core.Abstractions;
using Nsc.Core.Enums;

codeunit 1000011 "Nsc Document Manager"
{
    var
        DocumentManager: Interface INscDocumentManager;

    procedure GetCustomerNo(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]): Code[20]
    begin
        DocumentManager := MapDocumentTypeToManagerType(DocumentType);

        exit(DocumentManager.GetCustomerNo(DocumentNo));
    end;

    procedure GetDocument(DocumentType: Enum "Nsc Document Type"; DocumentNo: Code[20]): RecordRef
    begin
        DocumentManager := MapDocumentTypeToManagerType(DocumentType);

        exit(DocumentManager.GetDocument(DocumentNo));
    end;

    procedure FetchDocuments(DocumentType: Enum "Nsc Document Type")
    begin
        DocumentManager := MapDocumentTypeToManagerType(DocumentType);

        DocumentManager.FetchDocuments();
    end;

    local procedure MapDocumentTypeToManagerType(DocumentType: Enum "Nsc Document Type"): Enum "Nsc Document Managers"
    var
        InvalidDocumentTypeForMappingErrorLbl: Label '%1 cannot be mapped as it is not supported', Comment = '%1 => Provided document type';
    begin
        case DocumentType of
            Enum::"Nsc Document Type"::Invoice:
                exit(Enum::"Nsc Document Managers"::Invoice);

            Enum::"Nsc Document Type"::CreditMemo:
                exit(Enum::"Nsc Document Managers"::Creditmemo);

            Enum::"Nsc Document Type"::Reminder:
                exit(Enum::"Nsc Document Managers"::Reminder);

            else
                Error(InvalidDocumentTypeForMappingErrorLbl, DocumentType);
        end;
    end;
}