namespace Nsc.Core.Logic;
using Nsc.Core.Persistance;

codeunit 1000013 "Nsc Delivery Error Mgt."
{
    var
        SubmissionError: Record "Nsc Delivery Submission Error";

    procedure AddError(DeliverySubmissionId: Guid; ErrorMessage: Text[500])
    begin
        Clear(SubmissionError);

        SubmissionError.Init();

        SubmissionError."Delivery Submission Id" := DeliverySubmissionId;
        SubmissionError."Error Message" := ErrorMessage;

        SubmissionError.Insert();
    end;

    procedure ClearErrors(DeliverySubmissionId: Guid)
    begin
        Clear(SubmissionError);

        SubmissionError.SetRange("Delivery Submission Id");
        SubmissionError.DeleteAll();
    end;
}