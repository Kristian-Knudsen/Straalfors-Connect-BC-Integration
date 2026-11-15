namespace Nsc.Core.RoleCenters;
using Nsc.Core.UI;

page 1000005 "Nsc Role Center Controls"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            cuegroup("Nsc Shortcuts")
            {
                Caption = 'Nsc shortcuts';
                field("Nsc deliveries"; 0)
                {
                    ApplicationArea = All;
                    Caption = 'Nsc Deliveries';
                    DrillDownPageID = "Nsc Deliveries";
                    ToolTip = 'Displays all Nsc Deliveries';
                }
            }
        }
    }

}