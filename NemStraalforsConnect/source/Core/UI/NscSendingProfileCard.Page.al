namespace Nsc.Core.UI;

using Microsoft.Sales.Customer;
using Nsc.Core.Enums;
using Nsc.Core.Persistance;

page 1000009 "Nsc Sending Profile Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Customer;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Customer sending profile';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SendingProfile; SendingProfile)
                {
                    ApplicationArea = All;
                    Caption = 'Sending profile';
                    ToolTip = 'Specifies the sending profile for the customer.';

                    trigger OnValidate()
                    var
                        CustomerSendingProfile: Record "Nsc Customer Sending Profile";
                    begin
                        if CustomerSendingProfile.Get(Rec."No.") then begin
                            CustomerSendingProfile.Validate("Sending Profile", SendingProfile);
                            CustomerSendingProfile.Modify(true);
                        end else begin
                            CustomerSendingProfile.Init();
                            CustomerSendingProfile.Validate("Customer No.", Rec."No.");
                            CustomerSendingProfile.Validate("Sending Profile", SendingProfile);
                            CustomerSendingProfile.Insert(true);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CustomerSendingProfile: Record "Nsc Customer Sending Profile";
    begin
        Clear(SendingProfile);

        if CustomerSendingProfile.Get(Rec."No.") then
            SendingProfile := CustomerSendingProfile."Sending Profile";
    end;

    var
        SendingProfile: Enum "Nsc Sending Profile";
}
