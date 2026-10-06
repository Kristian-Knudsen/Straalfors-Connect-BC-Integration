namespace Nsc.Persistance;

table 100000 NscSetup
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; SenderSystem; Text[10])
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

        field(5; IncludeInvoices; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(6; IncludeCreditMemos; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(7; IncludeReminders; Boolean)
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
}