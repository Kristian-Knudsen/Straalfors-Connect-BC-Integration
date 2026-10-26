namespace Nsc.UI.Logic;

using Microsoft.Sales.History;
using Nsc.Persistance;

codeunit 1000004 "Nsc Deliveries Logic"
{
    procedure FetchNewDocuments()
    var
        NscSetup: Record "Nsc Setup";
        MissingSetupLbl: Label 'Missing Nsc setup. Please set it up';
        IsOnFetchInvoicesHandled, IsOnFetchCreditMemosHandled, IsOnFetchRemindersHandled : Boolean;
    begin
        if not NscSetup.FindFirst() then
            Error(MissingSetupLbl);

        if NscSetup.IncludeInvoices then begin
            OnBeforeFetchInvoices(IsOnFetchInvoicesHandled);

            if not IsOnFetchInvoicesHandled then
                FetchInvoices();
        end;

        if NscSetup.IncludeCreditMemos then begin
            OnBeforeFetchCreditMemos(IsOnFetchCreditMemosHandled);

            if not IsOnFetchCreditMemosHandled then
                FetchCreditMemos();
        end;

        if NscSetup.IncludeReminders then begin
            OnBeforeFetchReminders(IsOnFetchRemindersHandled);

            if not IsOnFetchRemindersHandled then
                FetchReminders();
        end;
    end;

    local procedure FetchInvoices()
    var
        Invoices: Record "Sales Invoice Header";
        Deliveries: Record "Nsc Deliveries";
    begin
        Invoices.SetRange(HandledByNsc, false);
        Invoices.SetRange(Cancelled, false);

        if not Invoices.FindSet(true) then
            exit;

        repeat
            Clear(Deliveries);
            Deliveries.Init();

        // Deliveries.

        until Invoices.Next() = 0;


    end;

    local procedure FetchCreditMemos()
    var
    begin

    end;

    local procedure FetchReminders()
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFetchInvoices(var isHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFetchCreditMemos(var isHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFetchReminders(var isHandled: Boolean)
    begin
    end;
}