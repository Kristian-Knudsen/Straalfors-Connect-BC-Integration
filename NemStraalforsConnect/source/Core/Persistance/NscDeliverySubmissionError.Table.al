namespace Nsc.Core.Persistance;

table 1000006 "Nsc Delivery Submission Error"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Error No."; Integer)
        {
            DataClassification = SystemMetadata;
        }

        field(2; "Delivery Submission Id"; Guid)
        {
            DataClassification = SystemMetadata;
        }

        field(3; "Error Message"; Text[500])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PrimaryKey; "Error No.")
        {
            Clustered = true;
        }

        key(Key1; "Delivery Submission Id") { }
    }
}