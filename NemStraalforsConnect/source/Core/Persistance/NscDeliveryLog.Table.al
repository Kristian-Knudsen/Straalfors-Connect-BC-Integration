namespace Nsc.Core.Persistance;

using Nsc.Core.Enums;

table 1000004 "Nsc Delivery Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Guid)
        {
            DataClassification = SystemMetadata;
        }

        field(2; "Delivery Submission Entry No."; Guid)
        {
            DataClassification = SystemMetadata;
        }

        field(3; "Delivery Status At Change"; Enum "Nsc Delivery Status")
        {
            DataClassification = SystemMetadata;
        }

        field(4; Message; Text[200])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PrimaryKey; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure AddLog(DeliveryId: Guid; LogMessage: Text[200]; StatusAtChange: Enum "Nsc Delivery Status")
    var
        Log: Record "Nsc Delivery Log";
    begin
        Clear(Log);

        Log.Init();
        Log."Entry No." := Guid.CreateGuid();

        Log."Delivery Submission Entry No." := DeliveryId;
        Log."Delivery Status At Change" := StatusAtChange;
        Log.Message := LogMessage;

        Log.Insert();
    end;

    procedure AddLog(SubmissionId: Guid; LogMessage: Text[200])
    var
        Submission: Record "Nsc Delivery Submission";
        SubmissionNotFoundLbl: Label 'The delivery submission to log message for was not found.';
    begin
        Submission.SetRange(SystemId, SubmissionId);

        if not Submission.FindFirst() then
            Error(SubmissionNotFoundLbl);

        AddLog(SubmissionId, LogMessage, Submission."Delivery Status");
    end;
}