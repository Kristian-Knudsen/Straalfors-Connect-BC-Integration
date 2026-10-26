namespace Nsc.Persistance;

using Microsoft.Sales.History;
using Microsoft.Sales.Reminder;
using Nsc.Core.Enums;

table 1000001 "Nsc Deliveries"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; DeliveryId; Guid)
        {
            DataClassification = SystemMetadata;
        }

        field(2; DeliveryStatus; Enum "Nsc Delivery Status")
        {
            DataClassification = SystemMetadata;
        }

        field(3; DocumentType; Enum "Nsc Document Type")
        {
            DataClassification = SystemMetadata;
        }

        field(4; "Document No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        field(5; CustomerName; Code[100])
        {
            DataClassification = SystemMetadata;

            TableRelation = if (DocumentType = const("Nsc Document Type"::CreditMemo))
                    "Sales Cr.Memo Header"."Bill-to Name"
                    where("No." = field("Document No."))
            else if (DocumentType = const("Nsc Document Type"::Invoice))
                    "Sales Invoice Header"."Bill-to Name"
                    where("No." = field("Document No."))
            else if (DocumentType = const("Nsc Document Type"::Reminder))
                    "Reminder Header".Name
                    where("No." = field("Document No."));
        }

        field(6; CustomerAddress; Code[100])
        {
            DataClassification = SystemMetadata;

            TableRelation = if (DocumentType = const("Nsc Document Type"::CreditMemo))
                    "Sales Cr.Memo Header"."Bill-to Address"
                    where("No." = field("Document No."))
            else if (DocumentType = const("Nsc Document Type"::Invoice))
                    "Sales Invoice Header"."Bill-to Address"
                    where("No." = field("Document No."))
            else if (DocumentType = const("Nsc Document Type"::Reminder))
                    "Reminder Header".Address
                    where("No." = field("Document No."));
        }

        field(7; DocumentDueDate; Date)
        {
            DataClassification = SystemMetadata;

            TableRelation = if (DocumentType = const("Nsc Document Type"::CreditMemo))
                    "Sales Cr.Memo Header"."Due Date"
                    where("No." = field("Document No."))
            else if (DocumentType = const("Nsc Document Type"::Invoice))
                    "Sales Invoice Header"."Due Date"
                    where("No." = field("Document No."))
            else if (DocumentType = const("Nsc Document Type"::Reminder))
                    "Reminder Header"."Due Date"
                    where("No." = field("Document No."));
        }
    }

    keys
    {
        key(PrimaryKey; DeliveryId)
        {
            Clustered = true;
        }
    }
}