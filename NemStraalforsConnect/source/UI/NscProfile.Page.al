namespace Nsc.UI;
using Nsc.Persistance;

page 1000003 "Nsc Profile"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Nsc Profile";

    layout
    {
        area(Content)
        {
            group(Profile)
            {
                field(CompanyId; Rec.CompanyId)
                {
                    ToolTip = 'Id of the current company. Used to verify account.';
                    Editable = false;
                }

                field(CompanyName; Rec.CompanyName)
                {
                    ToolTip = 'Company name';
                    Editable = false;
                }

                field(AccountType; Rec.AccountType)
                {
                    ToolTip = 'Current status of the account';
                    Editable = false;
                }
            }
        }
    }
}