namespace Nsc.Core.Logic;

using Nsc.Core.Enums;
using Nsc.Core.Persistance;

codeunit 1000004 "Nsc Deliveries Logic"
{
    procedure CreateNewDeliveriesAndSubmissions()
    var
        NscSetup: Record "Nsc Setup";
        DocumentManager: Codeunit "Nsc Document Manager";
        MissingSetupLbl: Label 'Missing Nsc setup. Please set it up';
    begin
        if not NscSetup.FindFirst() then
            Error(MissingSetupLbl);

        if NscSetup.IncludeInvoices then
            DocumentManager.FetchDocuments(Enum::"Nsc Document Type"::Invoice);

        if NscSetup.IncludeCreditMemos then
            DocumentManager.FetchDocuments(Enum::"Nsc Document Type"::CreditMemo);

        if NscSetup.IncludeReminders then
            DocumentManager.FetchDocuments(Enum::"Nsc Document Type"::Reminder);
    end;
}