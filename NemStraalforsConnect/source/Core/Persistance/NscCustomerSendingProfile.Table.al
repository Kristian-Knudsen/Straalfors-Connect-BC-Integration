namespace Nsc.Core.Persistance;
using Nsc.Core.Enums;

table 1000003 "Nsc Customer Sending Profile"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        field(2; "Sending Profile"; Enum "Nsc Sending Profile")
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PrimaryKey; "Customer No.")
        {
            Clustered = true;
        }
    }
}