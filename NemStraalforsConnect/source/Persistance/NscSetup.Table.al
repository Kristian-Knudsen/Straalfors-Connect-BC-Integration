namespace Nsc.Persistance;

table 1000000 "Nsc Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; SetupId; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; SenderSystemId; Text[10])
        {
            DataClassification = CustomerContent;
        }

        field(3; DeliveryTypeId; Text[10])
        {
            DataClassification = CustomerContent;
        }

        field(4; Certificate; Blob)
        {
            DataClassification = CustomerContent;
        }

        field(5; CertificateKey; Blob)
        {
            DataClassification = CustomerContent;
        }

        field(6; IncludeInvoices; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(7; IncludeCreditMemos; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(8; IncludeReminders; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(9; DisplayCustomerName; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(10; DisplayCustomerAddress; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(11; DisplayDocumentDueDate; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PrimaryKey; SetupId)
        {
            Clustered = true;
        }
    }

    procedure ReplaceCertificate()
    begin
        // TODO: Implement this when a cert is aquired
    end;

    procedure ReplaceCertificateKey()
    begin
        // TODO: Implement this when a cert is aquired
    end;
}