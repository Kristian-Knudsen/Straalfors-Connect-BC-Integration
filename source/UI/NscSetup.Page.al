namespace Nsc.UI;
using Nsc.Persistance;

page 100000 NscSetup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = NscSetup;

    layout
    {
        area(Content)
        {
            group(GeneralSettings)
            {
                field(SenderSystem; Rec.SenderSystem)
                {
                    ApplicationArea = All;
                }

                field(DeliveryTypeId; Rec.DeliveryTypeId)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}