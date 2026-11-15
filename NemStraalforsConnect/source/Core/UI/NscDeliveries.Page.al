namespace Nsc.Core.UI;

using Nsc.Core.Logic;
using Nsc.Core.Persistance;

page 1000002 "Nsc Deliveries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Nsc Delivery Header";
    RefreshOnActivate = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Deliveries)
            {
                field(DeliveryId; Rec.SystemId)
                {
                    Caption = 'Delivery id';
                    ApplicationArea = All;
                    ToolTip = 'Id of the delivery';
                }

                field(DocumentType; Rec."Document Type")
                {
                    Caption = 'Document type';
                    ApplicationArea = All;
                    ToolTip = 'Document type of the underlying document of the delivery';
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document No. of the underlying document of the delivery';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(FetchNewDocuments)
            {
                ApplicationArea = All;
                Caption = 'Fetch new documents';
                Image = Import;
                ToolTip = 'Fetch new documents that are posted and not handled yet';

                trigger OnAction()
                var
                    DeliveriesLogic: Codeunit "Nsc Deliveries Logic";
                begin
                    DeliveriesLogic.CreateNewDeliveriesAndSubmissions();
                end;
            }
        }
    }
}