namespace Nsc.Core.UI;

using Microsoft.Sales.Customer;
using Nsc.Core.Enums;
using Nsc.Core.Persistance;

page 1000008 "Nsc Sending Profile Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            field(SendingProfile; SendingProfile)
            {
                ApplicationArea = All;
                Caption = 'Sending profile';
                DrillDown = true;
                Editable = false;
                ToolTip = 'Shows the customer sending profile. Select it to change the profile.';

                trigger OnDrillDown()
                begin
                    EditProfile();
                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SetSendingProfile)
            {
                ApplicationArea = All;
                Caption = 'Set sending profile';
                Image = Edit;
                ToolTip = 'Assign or change the customer sending profile.';

                trigger OnAction()
                begin
                    EditProfile();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        RefreshProfile();
    end;

    procedure RefreshProfile()
    var
        CustomerSendingProfile: Record "Nsc Customer Sending Profile";
    begin
        Clear(SendingProfile);

        if CustomerSendingProfile.Get(Rec."No.") then
            SendingProfile := CustomerSendingProfile."Sending Profile";
    end;

    procedure UpdateProfile()
    begin
        RefreshProfile();
        CurrPage.Update(false);
    end;

    local procedure EditProfile()
    var
        SavedCustomer: Record Customer;
        SaveCustomerFirstLbl: Label 'Save the customer before assigning a sending profile.';
    begin
        if not SavedCustomer.Get(Rec."No.") then
            Error(SaveCustomerFirstLbl);

        Page.RunModal(Page::"Nsc Sending Profile Card", SavedCustomer);
        UpdateProfile();
    end;

    var
        SendingProfile: Enum "Nsc Sending Profile";
}
