namespace Nsc.Core.UI;
using Nsc.Core.Persistance;

page 1000008 "Nsc Sending Profile Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Nsc Customer Sending Profile";

    layout
    {
        area(Content)
        {
            field("Sending Profile"; Rec."Sending Profile")
            {
                ApplicationArea = All;
                ToolTip = 'Prefered sending profile for the customer';
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.GetFilter("Customer No.") <> '' then
            if not Rec.FindFirst() then begin
                Rec.Init();
                Rec."Customer No." := Rec.GetRangeMin("Customer No.");
                Rec.Insert(true);
            end;
    end;
}