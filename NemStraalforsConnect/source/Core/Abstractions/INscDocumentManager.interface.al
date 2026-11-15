namespace Nsc.Core.Abstractions;

interface INscDocumentManager
{
    procedure GetDocument(DocumentNo: Code[20]): RecordRef;

    procedure GetCustomerNo(DocumentNo: Code[20]): Code[20];

    procedure FetchDocuments();
}