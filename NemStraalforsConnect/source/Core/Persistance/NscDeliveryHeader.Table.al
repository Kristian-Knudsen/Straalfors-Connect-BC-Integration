namespace Nsc.Core.Persistance;

using Nsc.Core.Enums;

table 1000001 "Nsc Delivery Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Nsc Document Type")
        {
            DataClassification = SystemMetadata;
        }

        field(2; "Document No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        field(3; "Customer No."; Code[20])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
        }
    }

    keys
    {
        key(PrimaryKey; "Document Type", "Document No.")
        {
            Clustered = true;
        }
    }
}