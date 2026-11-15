namespace Nsc.Core.Persistance;

using Nsc.Core.Enums;

table 1000005 "Nsc Delivery Submission"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sending Id"; Guid) { }

        field(2; "Delivery Header Entry No."; Guid) { }

        field(3; "Delivery Status"; Enum "Nsc Delivery Status") { }

        field(4; "Delivery Type"; Enum "Nsc Delivery Type") { }

        field(5; "Recipient Name"; Text[200]) { }

        field(6; "Recipient Address"; Text[500]) { }

        field(7; "Recipient Post-Code"; Code[20]) { }

        field(8; "Recipient Country Code"; Text[20]) { }

        field(9; "Recipient Email"; Text[500]) { }

    }

    keys
    {
        key(PrimaryKey; "Sending Id")
        {
            Clustered = true;
        }
    }
}