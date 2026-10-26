namespace Nsc.UI;
using Nsc.Persistance;
using Nsc.UI.Logic;

page 1000002 "Nsc Deliveries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Nsc Deliveries";
    RefreshOnActivate = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Deliveries)
            {
                field(DeliveryId; Rec.DeliveryId)
                {
                    Caption = 'Delivery id';
                    ApplicationArea = All;
                    ToolTip = 'Id of the delivery';
                }

                field(DeliveryStatus; Rec.DeliveryStatus)
                {
                    Caption = 'Delivery status';
                    ApplicationArea = All;
                    ToolTip = 'Delivery status of the delivery';
                }

                field(DocumentType; Rec.DocumentType)
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

                field(CustomerName; Rec.CustomerName)
                {
                    Caption = 'Customer name';
                    ApplicationArea = All;
                    ToolTip = 'Customer name of the underlying document of the delivery';
                    Visible = ShouldDisplayCustomerNameOnRecords;
                }

                field(CustomerAddress; Rec.CustomerAddress)
                {
                    Caption = 'Customer address';
                    ApplicationArea = All;
                    ToolTip = 'Customer address of the underlying document of the delivery';
                    Visible = ShouldDisplayCustomerAddressOnRecords;
                }

                field(DocumentDueDate; Rec.DocumentDueDate)
                {
                    Caption = 'Document due date';
                    ApplicationArea = All;
                    ToolTip = 'Due date of the underlying document of the delivery';
                    Visible = ShouldDisplayDocumentDueDateOnRecords;
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
                    DeliveriesLogic.FetchNewDocuments();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        Setup: Record "Nsc Setup";
        MissingSetupLbl: Label 'Missing Nsc setup. Please set it up';
    begin
        if not Setup.FindFirst() then
            Error(MissingSetupLbl);

        ShouldDisplayCustomerNameOnRecords := Setup.DisplayCustomerName;
        ShouldDisplayCustomerAddressOnRecords := Setup.DisplayCustomerAddress;
        ShouldDisplayDocumentDueDateOnRecords := Setup.DisplayDocumentDueDate;
    end;

    var
        ShouldDisplayCustomerNameOnRecords: Boolean;
        ShouldDisplayCustomerAddressOnRecords: Boolean;
        ShouldDisplayDocumentDueDateOnRecords: Boolean;
}