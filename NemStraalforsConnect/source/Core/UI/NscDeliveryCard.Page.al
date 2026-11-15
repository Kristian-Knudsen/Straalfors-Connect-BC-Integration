namespace Nsc.Core.UI;
using Nsc.Core.Persistance;

page 1000006 "Nsc Delivery Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Nsc Delivery Header";

    layout
    {
        area(Content)
        {
            group(GeneralInformation)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Document type of the underlying document';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Customer No. of the recipient';
                }
            }

            part(Sendings; "Nsc Delivery Submissions Part")
            {
                SubPageLink = "Delivery Header Entry No." = field(SystemId);
            }
        }
    }
}