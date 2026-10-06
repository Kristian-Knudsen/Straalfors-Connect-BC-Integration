namespace Nsc.Persistance;

table 1000000 NscSetup
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Integer)
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
    }

    keys
    {
        key(Key1; PrimaryKey)
        {
            Clustered = true;
        }
    }

    procedure ReplaceCertificate()
    begin

    end;

    procedure ReplaceCertificateKey()
    begin

    end;
}