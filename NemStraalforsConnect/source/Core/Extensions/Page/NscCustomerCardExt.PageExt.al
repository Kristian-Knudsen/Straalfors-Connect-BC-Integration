namespace Nsc.Core.Extensions.Page;

using Microsoft.Sales.Customer;
using Nsc.Core.UI;

pageextension 1000000 "Nsc Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter(Invoicing)
        {
            group("NemStraalforsConnect")
            {
                Caption = 'Nem Strålfors Connect';

                field(ExcludeFromReceiving; Rec.ExcludeFromReceiving)
                {
                    ApplicationArea = All;
                    Caption = 'Exclude from receiving';
                    ToolTip = 'If checked, customer will be excluded from receiving documents via. Strålfors Connect';
                }
            }
        }

        addlast(FactBoxes)
        {
            part("Nsc Customer Sending Profile"; "Nsc Sending Profile Part")
            {
                ApplicationArea = All;
                Caption = 'Sending profile';
                Editable = true;
                SubPageLink = "No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(SetSendingProfile)
            {
                ApplicationArea = All;
                Caption = 'Set sending profile';
                Image = Edit;
                ToolTip = 'Assign or change the customer sending profile.';

                trigger OnAction()
                var
                    SavedCustomer: Record Customer;
                    SaveCustomerFirstLbl: Label 'Save the customer before assigning a sending profile.';
                begin
                    if Rec."No." = '' then
                        Error(SaveCustomerFirstLbl);

                    CurrPage.SaveRecord();
                    SavedCustomer.Get(Rec."No.");
                    Page.RunModal(Page::"Nsc Sending Profile Card", SavedCustomer);
                    CurrPage."Nsc Customer Sending Profile".Page.UpdateProfile();
                end;
            }
        }

        addlast(Promoted)
        {
            actionref(SetSendingProfilePromoted; SetSendingProfile)
            {
            }
        }
    }
}
